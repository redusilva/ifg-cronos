import { client } from "../config/db";
import fs from "fs";
import { ObjectId } from "mongodb";
import path from "path";
import { buscaTodosPlanos } from "./planos";
import { atualizarEspacoUtilizadoCliente, buscaArmazenamentoCliente, buscaUsuarioPorId } from "./user";

interface informacoesArquivo {
    _id: ObjectId;
    idUsuario: string;
    tamanhoArquivo: number;
    nomeArquivo: string;
    dataModificacao: Date;
    tipoMIME: string;
}

const database = client.db('cronos');
const collection = database.collection('arquivos');

export const salvaArquivos = async (arquivo: Express.Multer.File, idUsuario: string) => {
    try {
        const salvaArquivo = await collection.insertOne({
            idUsuario,
            tamanhoArquivo: arquivo.size,
            nomeArquivo: arquivo.originalname,
            dataModificacao: new Date(),
            tipoMIME: arquivo.mimetype
        });
        return salvaArquivo;
    } catch (error) {
        console.log(error);
        throw new Error('Erro ao salvar arquivo.');
    }
}

export const buscaArquivosPorIdCliente = async (idCliente: string) => {
    try {
        const consulta = { idUsuario: idCliente };
        const resultado = await collection.find(consulta, { projection: { idUsuario: 0 } }).toArray();
        const armazenamentoCliente = await buscaArmazenamentoCliente(idCliente);

        return {
            ...armazenamentoCliente,
            arquivos: resultado
        };

    } catch (error) {
        console.log(error);
        throw new Error('Erro ao buscar arquivos.');
    }
}

export const validaSegurancaArquivo = async (arquivo: any, caminhoArquivo: string) => {

    let objRetorno = {
        mensagem: 'Arquivo validado com sucesso!',
        valido: true
    };

    try {
        const conteudo = fs.readFileSync(caminhoArquivo);
        const blob = new Blob([conteudo], { type: arquivo.mimetype });
        let formdata = new FormData();
        formdata.append("file", blob);

        let requestOptions = {
            method: 'POST',
            body: formdata
        };

        const req = await fetch("http://localhost:5000/api/check", requestOptions);
        const res = await req.json();
        console.log("Validação arquivo: ", res);

        if(!res.valid) {
            objRetorno = { mensagem: 'Arquivo inválido.', valido: false };
            return objRetorno;
        }

        return objRetorno;

    } catch (error) {
        console.log(error);
        objRetorno = { mensagem: 'Erro ao validar o arquivo.', valido: false };
        return objRetorno;
    }
}

export const buscaArquivoPorId = async (idArquivo: string) => {
    try {
        const consulta = { _id: new ObjectId(idArquivo) };
        const resultado = await collection.find(consulta).toArray() as informacoesArquivo[];
        return resultado;
    } catch (error) {
        console.log(error);
        throw new Error('Erro ao buscar arquivos.');
    }
}

export const deletarArquivoNoBanco = async (arquivo: any) => {
    try {
        const consulta = { _id: new ObjectId(arquivo._id.toString()) };
        const deletaArquivo = await collection.deleteOne(consulta);
        const usuario: any = await buscaUsuarioPorId(arquivo.idUsuario);
        const dadosAtualizados = {
            $set: {
                ultimoLogin: new Date(),
                armazenamentoUsado: Number(usuario?.armazenamentoUsado) - Number(arquivo.tamanhoArquivo)
            }
        };
        console.log(usuario);
        console.log(arquivo);

        const res = await atualizarEspacoUtilizadoCliente(usuario._id.toString(), dadosAtualizados);
        return res;
    } catch (error) {
        console.log(error);
        throw new Error('Erro ao deletar arquivo.');
    }
}

export const excluirArquivosTemporarios = async (arquivos: Express.Multer.File[]) => {
    try {
        const pastaOrigem = path.join(__dirname, '../../uploads');
        await Promise.all(arquivos.map((arquivo) => {
            const caminhoOrigem = path.join(pastaOrigem, arquivo.filename);
            fs.unlink(caminhoOrigem, (err) => {
                if (err) {
                    console.error(`Erro ao excluir o arquivo '${arquivo}':`, err);
                }
            });
        }));
    } catch (error: any) {
        console.log("Erro na função excluirArquivosTemporarios", error);
        throw new Error(error.message);
    }
}

export const excluirArquivosSalvos = async (arquivo: any) => {
    try {
        const pastaOrigem = path.join(__dirname, '../../database');
        const extensaoArquivo = arquivo.tipoMIME.split('/')[1];
        const caminhoOrigem = path.join(pastaOrigem, arquivo.idUsuario, `${arquivo._id.toString()}.${extensaoArquivo}`);
        fs.unlink(caminhoOrigem, (err) => {
            if (err) {
                console.error(`Erro ao excluir o arquivo '${arquivo}':`, err);
            }
        });
    } catch (error: any) {
        console.log("Erro na função excluirArquivosSalvos", error);
        throw new Error(error.message);
    }
}

export const validaSeUsuarioTemEspacoDisponivel = async (usuario: any, arquivos: Express.Multer.File[]) => {
    try {
        const todosPlanos: any = await buscaTodosPlanos();
        const planoUsuario = todosPlanos.filter((plano: any) => {
            return usuario.idPlano === plano._id.toString();
        });

        let tamanhoArquivos = 0;
        arquivos.map((arquivo: any) => {
            tamanhoArquivos += arquivo.size
        });

        if ((usuario.armazenamentoUsado + tamanhoArquivos) >= planoUsuario[0].size) {
            return false;
        }

        return true;
    } catch (error) {
        console.log(error);
        return false;
    }
}