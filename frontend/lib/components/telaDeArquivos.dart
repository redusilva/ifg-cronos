import 'package:expenses/components/Alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:flutter/Services.dart';
import 'package:expenses/conexãoComBack/conexãoComBack.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:file_picker/file_picker.dart';

//main() => runApp(ExpensesApp());

class TelaDeArquivos extends StatelessWidget {
  final String _tokenLogin;

  TelaDeArquivos(this._tokenLogin, {Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MyHomePage(_tokenLogin);
  }
}

class MyHomePage extends StatefulWidget {
  final String _tokenLogin;
  const MyHomePage(this._tokenLogin, {Key? key}) : super(key: key);

  String getTokenLogin() {
    return _tokenLogin;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = true;
  final List<Transaction> _transactions = [];

  _addTransaction(String title, double value, DateTime date, IconData icon) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      icon: icon,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
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
        dynamic tamanhoDoArquivo = await file.length() + 0.0;
        bool sucesso = await uploadFile(widget.getTokenLogin(),file);
        
      

        return _addTransaction(
          file.uri.pathSegments.last,
          tamanhoDoArquivo,
          DateTime.now(),
          _getFileIcon(file.uri.pathSegments.last),
        );
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    bool isLandScape =
        (MediaQuery.of(context).orientation == Orientation.landscape);
    final appBar = AppBar(
      title: Text(
        'Meus Arquivos',
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => {Navigator.of(context).pop()},
        )
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
            Row(
              children: [
                Text(
                  "Exibir armazenamento",
                  style: TextStyle(
                      color: Colors.green[400], // Cor do texto
                      fontSize: 15.0, // Tamanho da fonte
                      fontWeight:
                          FontWeight.bold, // Espessura da fonte (negrito)

                      fontFamily: 'Roboto'), // Família da fonte
                ),
                Platform.isAndroid || Platform.isIOS || Platform.isWindows
                    ? Switch.adaptive(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        })
                    : const SizedBox(width: 10, height: 10)
              ],
            ),
            // Planos_DropDown(context),
            SizedBox(
              height: avaliableHeigh * 0.03,
            ),
            _showChart
                ? Container(
                    height: avaliableHeigh * (isLandScape ? 0.3 : 0.7),
                    child: Chart(_transactions))
                : SizedBox(
                    height: avaliableHeigh * 0.03,
                  ),
            Container(
                height: avaliableHeigh * 0.7,
                child: TransactionList(_transactions, _removeTransaction)),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? MaterialApp(
            home: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: appBar,
              ),
              child: page,
            ),
            theme: tema.copyWith(
              colorScheme: tema.colorScheme.copyWith(
                primary: Colors.green,
                secondary: Colors.green,
              ),
              textTheme: tema.textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                labelLarge: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
        : MaterialApp(
            home: Scaffold(
              appBar: appBar,
              body: page,
              floatingActionButton: _getIconButtom(
                Platform.isIOS ? CupertinoIcons.cloud_upload : Icons.upload,
                _abreNavegadorDeArquivos,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
            theme: tema.copyWith(
              colorScheme: tema.colorScheme.copyWith(
                primary: Colors.green,
                secondary: Colors.green,
              ),
              textTheme: tema.textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                labelLarge: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ));
  }
}
