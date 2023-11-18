import 'package:expenses/telas/telaDeConfiguracaoes/telaDeConfiguracao.dart';
import '../../reutilizáveis/Alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:flutter/Services.dart';
import '../../serviços/APIs/API_Cliente-Servidor.dart';
import 'componentes/listaDeArquivos.dart';
import 'componentes/armazenamento.dart';
import '../../modelos/referênciaArquivo.dart';
import 'package:file_picker/file_picker.dart';
import '../../serviços/variaveisDeEstado/CorTema.dart';
import 'package:provider/provider.dart';
import '../../utilidades/MapeamentoDeIcones.dart';

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

  List<ReferenciaArquivo> _refereciasArquivos = [];
  List<dynamic> _listaArquivos = [];

  _EstadoDaTela(final dynamic arquivos) {
    _listaArquivos = arquivos;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _refereciasArquivos = [];

    // Adicionando os arquivos na tela
    for (dynamic i in _listaArquivos) {
      _adicionarReferenciaArquivo(
          i['_id'],
          i['nomeArquivo'],
          i['tamanhoArquivo'] + 0.0,
          DateTime.parse(i['dataModificacao']),
          retornaIconeArquivo(i['nomeArquivo'].split('.').last));
    }

    //Barra Superior
    final barraSuperior = AppBar(
      backgroundColor: Provider.of<CorPrincipal>(context).corTema,
      title: Text(
        'Meus Arquivos',
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
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
                          Provider.of<CorPrincipal>(context).corTema,
                    ),
                    child: const Text('Não'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                    ),
                    child: const Text('Sim'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
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

    //Tamanho da tela
    final tamanhoDaTelaDisponivel = MediaQuery.of(context).size.height -
        barraSuperior.preferredSize.height -
        MediaQuery.of(context).padding.top;

    //Página central
    final pagina = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: tamanhoDaTelaDisponivel * (0.3),
                child: MontaBarraDeArmazenamento(
                    _refereciasArquivos, widget._espacoTotal)),
            Container(
                height: tamanhoDaTelaDisponivel * 0.7,
                child: ListaDeArquivos(_refereciasArquivos, widget._tokenLogin,
                    _removerReferenciaArquivo)),
          ],
        ),
      ),
    );

    // Menu de configurações
    var menuDecConfiguracoes = Drawer(
      child: TelaDeConfiguracao(),
    );

    //Contruindo a página de forma adaptativa
    return Platform.isIOS

        // IOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: barraSuperior,
            ),
            child: pagina,
          )
        : Builder(
            builder: (context) =>
                Consumer<CorPrincipal>(builder: (context, provider, child) {
              //Android/PC:
              return Scaffold(
                appBar: barraSuperior,
                body: pagina,
                key: _scaffoldKey,
                endDrawer: menuDecConfiguracoes,
                floatingActionButton: _adicionaBotaoFlutuante(
                  Platform.isIOS ? CupertinoIcons.cloud_upload : Icons.upload,
                  _fazUploadDeArquivo,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }),
          );
  }

  // Abre a navegação de arquivos, pega um arquivo e envia para a API
  _fazUploadDeArquivo() async {
    // Usa o file picker para pegar o arquivo
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> files = result.files.map((file) => File(file.path!)).toList();

      //Envia para a API
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
    }
  }

  // Atualiza a lista de Arquivos para garantir que seja igual ao do servidor
  _atualizaArquivos() async {
    dynamic resposta =
        await pegaArquivos(widget._tokenLogin, widget._idUsuario);
    setState(() {
      _listaArquivos = resposta["arquivos"];
    });
  }

  // Adiona o arquivo na lista de visualização
  _adicionarReferenciaArquivo(String idExterno, String title, double value,
      DateTime date, IconData icon) {
    final newTransaction = ReferenciaArquivo(
      idInterno: Random().nextDouble().toString(),
      idExterno: idExterno,
      nomeDoArquivo: title,
      tamanhoEmBytes: value,
      dataDeModificacao: date,
      iconeDoArquivo: icon,
    );

    setState(() {
      _refereciasArquivos.insert(0, newTransaction);
    });
  }

  // Remove o arquivo da lista de visualização
  _removerReferenciaArquivo(String id) async {
    _refereciasArquivos.removeWhere((tr) => tr.idInterno == id);
    await _atualizaArquivos();
  }

  // Adicionado o botão futuante para download
  Widget _adicionaBotaoFlutuante(IconData icon, Function() function) {
    return Platform.isIOS
        ? GestureDetector(onTap: () async => function(), child: Icon(icon))
        : FloatingActionButton(
            child: Icon(icon),
            backgroundColor: Provider.of<CorPrincipal>(context).corTema,
            onPressed: () async => await function(),
          );
  }
}
