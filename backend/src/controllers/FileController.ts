import { Request, Response } from 'express';
import dotenv from 'dotenv';
import { adicionarEspacoUtilizado, buscaUsuarioPorId, validaSessaoUsuario } from '../helpers/user';
import fs from 'fs';
import path from 'path';
import { buscaArquivoPorId, buscaArquivosPorIdCliente, deletarArquivoNoBanco, excluirArquivosSalvos, excluirArquivosTemporarios, salvaArquivos, validaSeUsuarioTemEspacoDisponivel } from '../helpers/files';

dotenv.config();

export class FileController {

    static async enviarArquivo(req: Request, res: Response) {
        try {
            const token = String(req.headers.authorization).split('Bearer ')[1];

            if (!token) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(401).json({ error: 'Usuário não autorizado!.' });
            }

            if (!await validaSessaoUsuario(token)) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(401).json({ error: 'Sessão expirada! Faça login antes de prosseguir!' });
            }

            const { idCliente } = req.body;

            if (!idCliente) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(400).send('Dados incompletos!');
            }

            const cliente = await buscaUsuarioPorId(idCliente);

            if (!cliente) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(400).send('Usuário não encontrado no sistema!');
            }

            const arquivos = req.files as Express.Multer.File[];
            console.log(arquivos);

            if (!arquivos || arquivos.length === 0) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(400).send('Nenhum arquivo foi enviado.');
            }

            const temEspacoDisponivel = await validaSeUsuarioTemEspacoDisponivel(cliente, arquivos);
            if(!temEspacoDisponivel) {
                await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
                return res.status(400).send('Espaco de armazenamento insuficiente!');
            }

            const baseCaminho = path.join(__dirname, '..', '..');
            const pastaOrigem = path.join(baseCaminho, 'uploads');
            const pastaDestino = path.join(baseCaminho, 'database');
            let tamanhoArquivos = 0;

            await Promise.all(arquivos.map(async (arquivo) => {
                const salvaArquivo = await salvaArquivos(arquivo, idCliente);
                const pastaUsuario = path.join(pastaDestino, idCliente);

                if (!fs.existsSync(pastaUsuario)) {
                    fs.mkdirSync(pastaUsuario, { recursive: true });
                }

                const caminhoOrigem = path.join(pastaOrigem, arquivo.filename);
                const caminhoDestino = path.join(pastaUsuario, `${salvaArquivo.insertedId.toString()}.${arquivo.mimetype.split('/')[1]}`);

                fs.rename(caminhoOrigem, caminhoDestino, (err) => {
                    if (err) {
                        console.error(`Erro ao mover o arquivo '${arquivo}':`, err);
                    } else {
                        console.log(`Arquivo '${arquivo}' movido para '${caminhoDestino}'.`);
                    }
                });
                tamanhoArquivos += arquivo.size;
            }));

            await adicionarEspacoUtilizado(cliente, tamanhoArquivos);

            return res.status(200).send('Arquivo recebido com sucesso.');
        } catch (error) {
            console.log(error);
            await excluirArquivosTemporarios(req.files as Express.Multer.File[]);
            return res.status(500).send('Erro ao processar arquivo.');
        }
    }

    static async arquivosCliente(req: Request, res: Response) {
        try {
            const token = String(req.headers.authorization).split('Bearer ')[1];

            if (!token) {
                return res.status(401).json({ error: 'Usuário não autorizado!.' });
            }

            if (!await validaSessaoUsuario(token)) {
                return res.status(401).json({ error: 'Sessão expirada! Faça login antes de prosseguir!' });
            }

            const idCliente = req.params.id;
            if (!idCliente) {
                return res.status(400).send('Dados incompletos!');
            }

            const arquivos = await buscaArquivosPorIdCliente(idCliente);

            return res.status(200).json({ arquivos });
        } catch (error) {
            console.log(error);
            return res.status(500).send('Erro ao processar arquivo.');
        }
    }

    static async excluirArquivos(req: Request, res: Response) {
        try {
            
            const token = String(req.headers.authorization).split('Bearer ')[1];

            if (!token) {
                console.log(1)
                await excluirArquivosTemporarios(req.files as Express.Multer.File[] || []);
                return res.status(401).json({ error: 'Usuário não autorizado!.' });
            }

            if (!await validaSessaoUsuario(token)) {
                console.log(2)
                await excluirArquivosTemporarios(req.files as Express.Multer.File[] || []);
                return res.status(401).json({ error: 'Sessão expirada! Faça login antes de prosseguir!' });
            }

            const idArquivo = req.params.id;
            if (!idArquivo) {
                console.log(3)
                await excluirArquivosTemporarios(req.files as Express.Multer.File[] || []);
                return res.status(400).send('Dados incompletos!');
            }

            const arquivo = await buscaArquivoPorId(idArquivo);
            if(!arquivo || arquivo.length === 0) {
                console.log(4)
                await excluirArquivosTemporarios(req.files as Express.Multer.File[] || []);
                return res.status(400).send('Arquivo não encontrado no sistema!');
            }

            await deletarArquivoNoBanco(arquivo[0]);
            await excluirArquivosSalvos(arquivo[0]);
            return res.status(200).send('Arquivo excluído com sucesso!');

        } catch (error: any) {
            console.log("Erro na controller excluirArquivosTemporarios", error);
            return res.status(500).send(error.message);
        }
    }

}