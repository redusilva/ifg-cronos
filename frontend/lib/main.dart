import 'package:flutter/material.dart';
import 'package:flutter/Services.dart';
import "dart:convert";
import "providers/UserProvider.dart";
import 'providers/customizationProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'telas/telaInicial/telaInicial.dart';

void main() async {
  Color? corPricipal;
  String savedData = "";

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  savedData = _prefs.getString("corPrincipal") ?? "";

  if (savedData != "") {
    String valorHexadecimal = json.decode(savedData);

    int valorInteiro = int.parse(valorHexadecimal.replaceFirst('#', ''),
        radix: 16); 

    corPricipal = Color(valorInteiro);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomProvider>(
          create: (context) => CustomProvider(corPricipal ?? Colors.green),
        ),
        ChangeNotifierProvider<EmailProvider>(
          create: (context) => EmailProvider(),
        ),

      ],
      child: CRONOS(),
    ),
  );
}

class CRONOS extends StatelessWidget {
  CRONOS({Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Builder(
      builder: (context) =>
          Consumer<CustomProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'CRONOS',
          initialRoute: '/',
          routes: {
            '/': (context) => const TelaInicial(),
          },
          debugShowCheckedModeBanner: false,
          theme: tema.copyWith(
            colorScheme: tema.colorScheme.copyWith(
                primary: Provider.of<CustomProvider>(context).corTema,
                secondary: Provider.of<CustomProvider>(context).corTema),
            textTheme: tema.textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelLarge: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }),
    );
  }
}
