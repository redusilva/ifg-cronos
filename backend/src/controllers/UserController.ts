import { Request, Response } from 'express';
import dotenv from 'dotenv';
import { cadastraNovoUsuario, logaUsuario, validaDadosUsuario, verificaSeUsuarioExiste } from '../helpers/user';

dotenv.config();

export class UserController {

    static async login(req: Request, res: Response) {
        try {
            const { email, senha } = req.body;

            if (!email || !senha) {
                return res.status(400).send('Dados incompletos!');
            }

            const validacao = validaDadosUsuario(email, senha);
            if (validacao.dadosValidos === false) {
                return res.status(400).send(validacao.mensagem);
            }

            const login = await logaUsuario(email, senha);

            return res.send({
                token: login.token,
                idUsuario: login.idUsuario,
                mensagem: login.mensagem,
                usuarioLogado: !login.token ? false : true
            });
        } catch (error: any) {
            return res.send({
                token: null,
                mensagem: "Não foi possível realizar login no sistema!",
                usuarioLogado: false
            });
        }
    }

    static async criaUsuario(req: Request, res: Response) {
        try {
            const { email, senha, idPlano } = req.body;

            if (!email || !senha || !idPlano) {
                return res.status(400).send('Dados incompletos!');
            }

            const validacao = validaDadosUsuario(email, senha, idPlano);
            if (validacao.dadosValidos === false) {
                return res.status(400).send(validacao.mensagem);
            }

            const usuárioExiste = await verificaSeUsuarioExiste(email);

            if (usuárioExiste) {
                return res.status(400).send({
                    mensagem: 'Usuário já cadastrado no sistema!'
                });
            }

            const novoUsuário = await cadastraNovoUsuario({ email, senha, idPlano });

            return res.status(201).send({
                mensagem: 'Usuário criado com sucesso!',
                idNovoUsuário: novoUsuário,
                usuarioCriado: !novoUsuário ? false : true
            });
        } catch (error: any) {
            return res.status(500).send(error.message);
        }
    }

}
