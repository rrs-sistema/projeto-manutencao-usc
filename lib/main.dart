import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:desktop_window/desktop_window.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:catcher/catcher.dart';
// ignore: depend_on_referenced_packages
import 'package:sqlite3/open.dart';
import 'dart:ffi' hide Size;
import 'dart:io';

import './src/view/shared/page/splash_screen_pagev.dart';
import './src/view/shared/custom_animation.dart';
import './src/database/app_db.dart';
import './src/view/home_page.dart';
import './src/infra/sessao.dart';
import './src/infra/infra.dart';

// adicionado para corrigir o problema de navegação da paginatedDataTable na Horizontal
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() async {
  if (Platform.isWindows) {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
  }

  ///Inicia o Catcher e então inicia a aplicação.
  ///O Catcher vai pegar e reportar os erros de forma global
  Catcher(
    runAppFunction: () {
      runApp(const UscApp());
    },
    debugConfig: Constantes.debugOptionsPagina,
    releaseConfig: Constantes.releaseOptionsPagina,
  );
  //runApp(const UscApp());
  configLoading();
}

DynamicLibrary _openOnWindows() {
  try {
    final libraryNextToScript = File('sqlite3.dll');
    return DynamicLibrary.open(libraryNextToScript.path);
  } catch (e) {
    debugPrint(e.toString());
    throw 'Erro: ${DateTime.now().toIso8601String()} - Exceção: $e';
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..backgroundColor = Colors.blueGrey[900]
    ..userInteractions = true
    ..dismissOnTap = true
    ..userInteractions = false
    ..customAnimation = CustomAnimation();
}

class UscApp extends StatefulWidget {
  const UscApp({Key? key}) : super(key: key);

  @override
  UscAppState createState() => UscAppState();
}

class UscAppState extends State<UscApp> {
  @override
  Widget build(BuildContext context) {
    return Provider<AppDb>(
        create: (context) => AppDb(),
        dispose: (context, db) => db.close(),
        builder: (context, value) {
          return FutureBuilder(
            future: Future.delayed(const Duration(seconds: 3), () async {
              await Sessao.popularObjetosPrincipais(context);
              if (Biblioteca.isDesktop()) {
                await DesktopWindow.setMinWindowSize(const Size(800, 600));
                await DesktopWindow.resetMaxWindowSize();
                await DesktopWindow.toggleFullScreen();
              }
            }),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _materialApp(splash: true);
              } else {
                return _materialApp(splash: false);
              }
            },
          );
        });
  }
}

Widget _materialApp({bool? splash}) {
  return MaterialApp(
    scrollBehavior: MyCustomScrollBehavior(),
    navigatorKey: Catcher.navigatorKey,
    localizationsDelegates: const [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('pt', 'BR'),
    ],
    debugShowCheckedModeBanner: false,
    title: Constantes.nomeApp,
    onGenerateRoute: Rotas.definirRotas,
    theme: ThemeData(),
    home: splash == true ? const SplashScreenPage() : const HomePage(),
    //home: splash == true ? const SplashScreenPage() : const UsuarioPage(),
    builder: EasyLoading.init(),
  );
}
