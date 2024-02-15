import 'package:flutter/material.dart';
import 'tabBar.dart';
import 'package:flutter/services.dart';
import '/theme/texts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    return  MaterialApp(
        title: 'IFG Mobile Estudante',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green, 
          fontFamily: "Quicksand",
          textTheme: customTextTheme,
        ),
        home: HomePage(),
      
    );
  }
}