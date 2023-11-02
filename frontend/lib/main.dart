import 'components/adaptative_button.dart';
import "components/formulárioCadastro.dart";
import "conexãoComBack/conexãoComBack.dart";
import 'package:flutter/material.dart';
import 'package:flutter/Services.dart';
import 'components/telaDeArquivos.dart';
import 'components/formulárioLogin.dart';
import 'components/Alerta.dart';
import 'components/planos_DropDown.dart';
import "dart:convert";
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'providers/customizationProvider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CustomProvider(),
      child: ExpensesApp(),
    ),
  );
}


class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Provider.of<CustomProvider>(context).corTema,
          secondary: Provider.of<CustomProvider>(context).corTema,
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
      ),
    );
  }
}

_abrirLogin(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (_) {
      return FormularioLogin(_dadosLogin, context);
    },
  );
}

_abrirCadastro(BuildContext context) async {
  dynamic planos = await pegaPlanos();
  if (planos == false) {
    Alerta(context, "Não foi possível acessar o servidor",
        "Verifique sua conexão e tente novamente");
    return;
  }
  Map<String, String> mapPlanos = {};
  for (dynamic i in planos) {
    mapPlanos[i['name']] = i['_id'];
  }

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (_) {
      return FormularioCadastro(
          _dadosCadastro, mapPlanos, context, Dropdown(mapPlanos));
    },
  );
}

_dadosCadastro(
    String email, String senha, String idPlano, BuildContext context) async {
  //print(email + " " + senha + " " + idPlano);
  dynamic b = await criaConta(email, senha, idPlano);

  if (b.statusCode != 201) {
    if (b.body[0] == '{') {
      Alerta(context, "Erro ao criar conta!", json.decode(b.body)["mensagem"]);
      return;
    }
    Alerta(context, "Erro ao criar conta!", b.body.toString());
    return;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Sucesso!"),
        content: const Text("Sua conta foi criada!"),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
            ),
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

_dadosLogin(String email, String senha, BuildContext context) async {
  dynamic resposta = await login(email, senha);
  if (resposta == false) {
    Alerta(context, "Atenção!", "Não foi possível conectar com o servidor!");
    return;
  }
  if (resposta.body[0] == '{') {
    dynamic decode = json.decode(resposta.body);
    if (decode["usuarioLogado"] == true) {
      dynamic resposta =
          await pegaArquivos(decode['token'], decode['idUsuario']);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TelaDeArquivos(
                decode['token'],
                decode['idUsuario'],
                resposta['arquivos'],
                (resposta['espacoTotal']) + 0.0)),
      ).then((value) => {Navigator.of(context).pop()});
      return;
    }
    Alerta(context, "Atenção!", decode["mensagem"]);
    return;
  }
  Alerta(context, "Atenção!", resposta.body);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _abriModal(int index) async {
    switch (index) {
      case 1:
        await _abrirCadastro(context);
        break;
      default:
        await _abrirLogin(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final appBar = AppBar(
      title: Text(
        'Bem-vindo ao CRONOS',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );
    appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    final page = SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                'Bem vindo ao CRONOS!',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Seu repositório online atemporal!',
              style: TextStyle(
                  fontSize: 25.0, color: Color.fromARGB(255, 68, 67, 67)),
            ),
            const SizedBox(height: 60.0),
            // Espaçamento entre o título e os botões
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdaptativeButton("Cadastrar", Colors.green,
                    () async => await _abrirCadastro(context)),
                const SizedBox(height: 35.0), // Espaçamento entre os botões
                AdaptativeButton(
                    "Login",
                    const Color.fromARGB(255, 209, 180, 95),
                    () async => await _abrirLogin(context))
              ],
            ),
          ],
        ),
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
            body: const SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Bem vindo ao CRONOS!',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Seu repositório online atemporal!',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color.fromARGB(255, 68, 67, 67)),
                    ),
                    SizedBox(height: 60.0),
                    // Espaçamento entre o título e os botões
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: _abriModal,
              backgroundColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              currentIndex: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.login),
                  label: 'Login',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'Cadastrar',
                ),
              ],
            ));
  }
}
