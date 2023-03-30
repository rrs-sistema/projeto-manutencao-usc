import 'package:flutter/material.dart';

import './../../shared/gradiente_app.dart';
import './../../../infra/infra.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: gradienteApp(),
              ),
            ),
            FittedBox(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        Constantes.logoPrincipal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Constantes.primaryColor,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    "Bem-vindo. Aguarde um momento.",
                    style: TextStyle(
                        color: Constantes.primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
