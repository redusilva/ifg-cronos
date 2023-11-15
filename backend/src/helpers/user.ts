import { client } from '../config/db';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import { ObjectId } from 'mongodb';
import { buscaTodosPlanos } from './planos';

dotenv.config();

interface Usuario {
    _id?: string;
    email: string;
    senha: string;
    idPlano: string;
    criadoEm?: Date;
    armazenamentoUsado?: number;
}

interface Token {
    id: string;
    email: string;
    idPlano: string;
    iat: number;
    exp: number;
}

const saltosBCrypt = 14;
const database = client.db('clientes');
const collection = database.collection('usuarios');

const buscaUsuarioPorId = async (id: string) => {
    try {
        const auxId = new ObjectId(id);
        const resultado = await collection.findOne({ _id: auxId });
        return resultado;
    } catch (error) {
        console.log(error);
        return null;
    }
}

const verificaSeUsuarioExiste = async (email: string) => {
    try {
        const consulta = { email: email };
        const resultado = await collection.findOne(consulta);

        if (!resultado) {
            return false;
        }

        return true;
    } catch (error) {
        console.log(error);
        throw new Error('Erro ao verificar se o usuário existe.');
    }
}

const criptografaSenha = async (senha: string) => {
    try {
        const salt = await bcrypt.genSalt(saltosBCrypt);
        const hash = await bcrypt.hash(senha, salt);
        return hash;
    } catch (error: any) {
        throw new Error('Erro ao criar hash da senha: ' + error.message);
    }
}

const validaSenhaUsuario = async (email: string, senha: string) => {
    try {
        const usuario = await collection.findOne<Usuario>({ email });
        const senhaValida = await bcrypt.compare(senha, String(usuario?.senha));
        return senhaValida;
    } catch (error: any) {
        throw new Error('Erro ao verificar senha: ' + error.message);
    }
}

const criaJwt = (usuario: Usuario) => {
    try {
        const token = jwt.sign({
            id: usuario._id,
            email: usuario.email,
            idPlano: usuario.idPlano
        }, String(process.env.SECRET), { expiresIn: '12h' });
        return token;
    } catch (error: any) {
        throw new Error('Erro ao criar token: ' + error.message);
    }
}

const logaUsuario = async (email: string, senha: string) => {
    try {
        const usuario = await collection.findOne<Usuario>({ email });
        const senhaValida = await bcrypt.compare(senha, String(usuario?.senha));

        if (!senhaValida) {
            return { token: null, mensagem: 'Senha inválida!' };
        }

        const token = criaJwt(usuario as Usuario);
        const filtro = { _id: new ObjectId(usuario?._id) };
        const dadosAtualizados = {
            $set: {
                ultimaSessao: new Date(),
                token: token
            }
        }
        const atualizaSessao = await collection.updateOne(filtro, dadosAtualizados);

        if (!token || !atualizaSessao) {
            return { token: null, mensagem: 'Erro ao atualizar sessão!' };
        }

        return { token, idUsuario: usuario?._id, mensagem: 'Login efetuado com sucesso!' };
    } catch (error: any) {
        throw new Error('Erro ao tentar fazer o login do usuário: ' + error.message);
    }
}

const cadastraNovoUsuario = async (props: Usuario) => {
    try {
        const usuario = await collection.insertOne({
            email: props.email,
            senha: await criptografaSenha(props.senha),
            idPlano: props.idPlano,
            criadoEm: new Date(),
            armazenamentoUsado: 0,
            ultimoLogin: null,
            token: null
        });
        return usuario.insertedId;
    } catch (error: any) {
        console.log(error.message);
        throw new Error('Erro ao cadastrar novo usuário! ');
    }
}

const validaDadosUsuario = (email: string, senha: string, idPlano: string = "123") => {
    try {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return { dadosValidos: false, mensagem: 'E-mail inválido!' };
        }

        // Validação da senha - você pode adicionar suas próprias regras aqui (por exemplo, comprimento mínimo)
        if (senha.length < 8 || senha.length > 32) {
            return { dadosValidos: false, mensagem: 'A  senha deve ter entre 8 e 32 caracteres!' };
        }

        // Validação do ID do plano - exemplo básico para verificar se é uma string não vazia
        if (!idPlano || idPlano.trim() === "") {
            return { dadosValidos: false, mensagem: 'ID do plano inválido!' };
        }

        return { dadosValidos: true, mensagem: "" };
    } catch (error: any) {
        return { dadosValidos: false, mensagem: error.message };
    }
}

const calculaDiferencaEmHoras = (dataInicial: Date, dataFinal: Date) => {
    const d1 = new Date(dataInicial);
    const d2 = new Date(dataFinal);
    const subtracao = d2.getHours() - d1.getHours();
    const resultadoFinal = subtracao < 0 ? subtracao * (-1) : subtracao;
    return resultadoFinal;
}

const descriptografaToken = (token: string) => {
    try {
        const tokenDescriptografado = jwt.verify(token, String(process.env.SECRET)) as Token;
        return tokenDescriptografado;
    } catch (error: any) {
        return null;
    }
}

const validaSessaoUsuario = async (token: string) => {
    try {
        const tokenDescriptografado = jwt.verify(token, String(process.env.SECRET)) as Token;
        const idUsuario = new ObjectId(tokenDescriptografado.id);
        const resultado = await collection.findOne({ _id: idUsuario });

        if (resultado?.token !== token) {
            return false;
        }

        if (calculaDiferencaEmHoras(new Date(), resultado?.ultimaSessao) >= 12) {
            return false;
        }

        return true;
    } catch (error: any) {
        return false;
    }
}

const atualizarEspacoUtilizadoCliente = async (idUsuario: string, query: any) => {
    try {
        const filtro = { _id: new ObjectId(idUsuario) };
        await collection.updateOne(filtro, query);

        const armazenamento = await buscaArmazenamentoCliente(idUsuario);
        return armazenamento;

    } catch (error: any) {
        throw new Error('Erro ao tentar fazer o login do usuário: ' + error.message);
    }
}

const buscaArmazenamentoCliente = async (idUsuario: string) => {
    const usuario: any = await buscaUsuarioPorId(idUsuario);
    const todosPlanos = await buscaTodosPlanos();
    const planoUsuario = todosPlanos.filter((plano: any) => {
        return usuario.idPlano === plano._id.toString();
    });

    return {
        armazenamentoUsado: usuario.armazenamentoUsado,
        espacoTotal: planoUsuario[0].size
    }
}

export {
    verificaSeUsuarioExiste,
    criptografaSenha,
    validaSenhaUsuario,
    cadastraNovoUsuario,
    validaDadosUsuario,
    logaUsuario,
    buscaUsuarioPorId,
    validaSessaoUsuario,
    atualizarEspacoUtilizadoCliente,
    buscaArmazenamentoCliente,
    descriptografaToken
}
