import 'package:expenses/components/telaDeConfiguracao.dart';
import 'package:expenses/providers/UserProvider.dart';

import 'Alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:flutter/Services.dart';
import '../conexãoComBack/conexãoComBack.dart';
import '../components/transaction_list.dart';
import 'chart.dart';
import '../models/transaction.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/customizationProvider.dart';
import 'package:provider/provider.dart';

class TelaDeArquivos extends StatefulWidget {
  final String _tokenLogin;
  final String _idUsuario;
  final List<dynamic> _listaArquivos;
  final double _espacoTotal;

  const TelaDeArquivos(
      this._tokenLogin, this._idUsuario, this._listaArquivos, this._espacoTotal,
      {Key? key})
      : super(key: key);

  @override
  State<TelaDeArquivos> createState() => _EstadoDaTela(_listaArquivos);
}

class _EstadoDaTela extends State<TelaDeArquivos> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<Transaction> _transactions = [];
  List<dynamic> _listaArquivos = [];

  _EstadoDaTela(final dynamic arquivos) {
    _listaArquivos = arquivos;
    print(_listaArquivos);
  }

  void _resetTransations() {
    _transactions = [];
  }

  _atualizaArquivos() async {
    dynamic resposta =
        await pegaArquivos(widget._tokenLogin, widget._idUsuario);
    setState(() {
      _listaArquivos = resposta["arquivos"];
    });
  }

  _addTransaction(String idExterno, String title, double value, DateTime date,
      IconData icon) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      idExterno: idExterno,
      title: title,
      value: value,
      date: date,
      icon: icon,
    );

    setState(() {
      _transactions.insert(0, newTransaction);
    });
  }

  _removeTransaction(String id) async {
    _transactions.removeWhere((tr) => tr.id == id);

    await _atualizaArquivos();
  }

  // Mapeamento de extensão de arquivo para ícone
  final Map<String, IconData> _fileIconMapping = {
    'txt': Icons.description,
    'docx': Icons.book,
    'pdf': Icons.picture_as_pdf,
    'jpg': Icons.image,
    'png': Icons.image,
    'mp3': Icons.music_note,
    'mp4': Icons.video_call,

    // Adicione mais extensões e ícones conforme necessário
  };

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return _fileIconMapping[extension] ??
        Icons.insert_drive_file; // Ícone padrão para tipos desconhecidos
  }

  _abreNavegadorDeArquivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // O usuário selecionou um ou mais arquivos.
      List<File> files = result.files.map((file) => File(file.path!)).toList();

      // Faça algo com os arquivos selecionados, como exibir seus caminhos.
      for (var file in files) {
        bool enviou =
            await uploadFile(widget._tokenLogin, widget._idUsuario, file);
        if (enviou) {
          Alerta(context, "Sucesso!", "O arquivo foi enviado!");
          await _atualizaArquivos();
          return;
        }
        Alerta(context, "Erro ao enviar o arquivo! ",
            "Verifique sua conexão com a internet");
      }
    } else {
      // O usuário cancelou a seleção de arquivos.
    }
  }

  Widget _getIconButtom(IconData icon, Function() function) {
    return Platform.isIOS
        ? GestureDetector(onTap: () async => function(), child: Icon(icon))
        : FloatingActionButton(
            child: Icon(icon),
            backgroundColor: Provider.of<CustomProvider>(context).corTema,
            onPressed: () async => await function(),
          );
  }

  @override
  Widget build(BuildContext context) {
    print("a");
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _resetTransations();

    for (dynamic i in _listaArquivos) {
      _addTransaction(
          i['_id'],
          i['nomeArquivo'],
          i['tamanhoArquivo'] + 0.0,
          DateTime.parse(i['dataModificacao']),
          _getFileIcon(i['nomeArquivo'].split('.').last));
    }

    bool isLandScape =
        (MediaQuery.of(context).orientation == Orientation.landscape);
    final appBar = AppBar(
      backgroundColor: Provider.of<CustomProvider>(context).corTema,
      title: Text(
        'Meus Arquivos',
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Modifique o ícone aqui
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirmação"),
                content: const Text("Deseja sair?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Provider.of<CustomProvider>(context).corTema,
                    ),
                    child: const Text('Não'),
                    onPressed: () {
                      Navigator.of(context).pop(false); // Fecha o alerta
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                    ),
                    child: const Text('Sim'),
                    onPressed: () {
                      Navigator.of(context).pop(true); // Fecha o alerta
                    },
                  )
                ],
              );
            },
          ).then((value) => {
                if (value != null)
                  {
                    if (value) {Navigator.of(context).pop()}
                  }
              });
        },
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => {_scaffoldKey.currentState?.openEndDrawer()})
      ],
    );
    final avaliableHeigh = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final page = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: avaliableHeigh * (isLandScape ? 0.3 : 0.3),
                child: Chart(_transactions, widget._espacoTotal)),
            Container(
                height: avaliableHeigh * 0.7,
                child: TransactionList(
                    _transactions, widget._tokenLogin, _removeTransaction)),
          ],
        ),
      ),
    );
    var drawer = Drawer(
      child: TelaDeConfiguracao(),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: appBar,
            ),
            child: page,
          )
        : Builder(
            builder: (context) =>
                Consumer<CustomProvider>(builder: (context, provider, child) {
              return Scaffold(
                appBar: appBar,
                body: page,
                key: _scaffoldKey,
                endDrawer: drawer,
                floatingActionButton: _getIconButtom(
                  Platform.isIOS ? CupertinoIcons.cloud_upload : Icons.upload,
                  _abreNavegadorDeArquivos,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }),
          );
  }
}
