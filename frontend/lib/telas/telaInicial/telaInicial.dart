import '../../reutilizáveis/botãoAdaptativo.dart';
import 'componentes/formulárioCadastro.dart';
import '../../serviços/APIs/API_Cliente-Servidor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/Services.dart';
import '../telaDeArquivos/telaDeArquivos.dart';
import 'componentes/formulárioLogin.dart';
import '../../reutilizáveis/Alerta.dart';
import 'componentes/planos.dart';
import "dart:convert";
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../../serviços/variaveisDeEstado/CorTema.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final barraSuperior = AppBar(
      title: Text(
        'Bem-vindo ao CRONOS',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );
    barraSuperior.preferredSize.height - MediaQuery.of(context).padding.top;
    final paginaCentral = SafeArea(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdaptativeButton(
                    "Cadastrar",
                    Provider.of<CorPrincipal>(context).corTema,
                    () async => await _abrirCadastro()),
                const SizedBox(height: 35.0),
                AdaptativeButton(
                    "Login",
                    const Color.fromARGB(255, 209, 180, 95),
                    () async => await _abrirLogin())
              ],
            ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: barraSuperior,
            ),
            child: paginaCentral,
          )
        : Scaffold(
            appBar: barraSuperior,
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
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: _abrirModal,
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

  _abrirModal(int index) async {
    switch (index) {
      case 1:
        await _abrirCadastro();
        break;
      default:
        await _abrirLogin();
        break;
    }
  }

  _abrirLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    bool _lembrar = _prefs.getBool("lembrar") ?? false;

    String _emailSalvo = _prefs.getString("email") ?? "";

    String _senhaSalvo = _prefs.getString("senha") ?? "";

    if (_emailSalvo != "") {
      _emailSalvo = json.decode(_emailSalvo);
    }

    if (_senhaSalvo != "") {
      _senhaSalvo = json.decode(_senhaSalvo);
    }

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (_) {
        return FormularioLogin(
            _lembrar, _emailSalvo, _senhaSalvo, _prefs, _realizaLogin, context);
      },
    );
  }

  _realizaLogin(String email, String senha, BuildContext context) async {
    dynamic resposta = await login(email, senha);
    if (resposta == false) {
      Alerta(context, "Atenção!", "Não foi possível conectar com o servidor!");
      return;
    }
    if (resposta.body[0] == '{') {
      dynamic decode = json.decode(resposta.body);
      if (decode["usuarioLogado"] == true) {
        resposta = await pegaArquivos(decode['token'], decode['idUsuario']);

        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  TelaDeArquivos(
                    decode['token'],
                    decode['idUsuario'],
                    resposta['arquivos'],
                    (resposta['espacoTotal']) + 0.0,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                var tween = Tween(begin: begin, end: end);
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 700)),
        ).then((value) => Navigator.of(context).pop());
        return;
      }
      Alerta(context, "Atenção!", decode["mensagem"]);
      return;
    }
    Alerta(context, "Atenção!", resposta.body);
  }

  _abrirCadastro() async {
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
            _realizaCadastro, mapPlanos, context, Planos(mapPlanos));
      },
    );
  }

  _realizaCadastro(
      String email, String senha, String idPlano, BuildContext context) async {
    dynamic resposta = await criaConta(email, senha, idPlano);

    if (resposta.statusCode != 201) {
      if (resposta.body[0] == '{') {
        Alerta(context, "Erro ao criar conta!",
            json.decode(resposta.body)["mensagem"]);
        return;
      }
      Alerta(context, "Erro ao criar conta!", resposta.body.toString());
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
                backgroundColor: Provider.of<CorPrincipal>(context).corTema,
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((value) => Navigator.of(context).pop());
  }
}
