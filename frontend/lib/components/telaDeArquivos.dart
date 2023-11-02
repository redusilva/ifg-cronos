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
import 'menuCores.dart';
import '../providers/customizationProvider.dart';
import 'package:provider/provider.dart';



class TelaDeArquivos extends StatelessWidget {
  final String _tokenLogin;
  final String _idUsuario;
  final List<dynamic> _listaArquivos;
  final double _espacoTotal;

  TelaDeArquivos(
      this._tokenLogin, this._idUsuario, this._listaArquivos, this._espacoTotal,
      {Key? key})
      : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MyHomePage(_tokenLogin, _idUsuario, _listaArquivos, _espacoTotal);
  }
}

class MyHomePage extends StatefulWidget {
  final String _tokenLogin;
  final String _idUsuario;
  List<dynamic> _listaArquivos;
  final double _espacoTotal;

  MyHomePage(
      this._tokenLogin, this._idUsuario, this._listaArquivos, this._espacoTotal,
      {Key? key})
      : super(key: key);

  List<dynamic> getListaArquivos() {
    return _listaArquivos;
  }

  double getEspacoTotal() {
    return _espacoTotal;
  }

  void setListaArquivos(List<dynamic> lA) {
    _listaArquivos = lA;
  }

  String getTokenLogin() {
    return _tokenLogin;
  }

  String getIdUsuario() {
    return _idUsuario;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<Transaction> _transactions = [];

  void _resetTransations() {
    _transactions = [];
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
      _transactions.add(newTransaction);
    });
  }

  _removeTransaction(String id) async {
    dynamic resposta =
        await pegaArquivos(widget.getTokenLogin(), widget.getIdUsuario());
    widget.setListaArquivos(resposta['arquivos']);
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      _resetTransations();

      for (dynamic i in widget.getListaArquivos()) {
        _addTransaction(
            i['_id'],
            i['nomeArquivo'],
            i['tamanhoArquivo'] + 0.0,
            DateTime.parse(i['dataModificacao']),
            _getFileIcon(i['nomeArquivo'].split('.').last));
      }
    });
  }

  // Mapeamento de extensão de arquivo para ícone
  final Map<String, IconData> _fileIconMapping = {
    'txt': Icons.description,
    'doc': Icons.book,
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
        bool enviou = await uploadFile(
            widget.getTokenLogin(), widget.getIdUsuario(), file);
        if (enviou) {
          dynamic resposta =
              await pegaArquivos(widget.getTokenLogin(), widget.getIdUsuario());
          widget.setListaArquivos(resposta['arquivos']);
          setState(() {
            _resetTransations();
          });
          Alerta(context, "Sucesso!", "O arquivo foi enviado!");
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
            onPressed: () async => await function(),
          );
  }

  final ThemeData tema = ThemeData();
  @override
  Widget build(BuildContext context) {
    print("a");
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _resetTransations();

    for (dynamic i in widget.getListaArquivos()) {
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
                      backgroundColor: Provider.of<CustomProvider>(context).corTema,
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
            icon: const Icon(Icons.account_circle),
            onPressed: () => {_scaffoldKey.currentState!.openEndDrawer()})
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
                child: Chart(_transactions, widget.getEspacoTotal())),
            Container(
                height: avaliableHeigh * 0.7,
                child: TransactionList(
                    _transactions, widget.getTokenLogin(), _removeTransaction)),
          ],
        ),
      ),
    );
    var drawer = Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("Usuário"),
            accountEmail: Row(
              children: [
                const Text("usuario@exemplo.com"),
                IconButton(
                    icon: const Icon(
                        Icons.edit), // Ícone que será exibido no botão
                    onPressed: () => {})
              ],
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Ação quando o Item 1 é selecionado
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Ação quando o Item 2 é selecionado
                },
              ),
              PopupMenuButtonWidget()
            ],
          )
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: appBar,
            ),
            child: page,
          )
        : Scaffold(
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
  }
}
