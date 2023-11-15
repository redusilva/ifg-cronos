import express, { Request, Response } from 'express';
import middleware from '../config/middleware';
import { FileController } from '../controllers/FileController';

const router = express.Router();

// Rota para upload de arquivos
router.post('/', middleware, FileController.enviarArquivo);

router.delete('/:id', middleware, FileController.excluirArquivos);

router.get('/:id', middleware, FileController.arquivosCliente);

router.get('/download/:id', middleware, FileController.baixarArquivo);

export default router;