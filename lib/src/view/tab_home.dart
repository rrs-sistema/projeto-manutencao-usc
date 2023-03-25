import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:manutencao_usc/src/infra/infra.dart';
import 'package:manutencao_usc/src/view/menu/menu_titulo_grupo_menu_interno.dart';
import 'package:manutencao_usc/src/view/shared/caixas_de_dialogo.dart';

import 'package:manutencao_usc/src/view/shared/custom_background.dart';
import 'package:manutencao_usc/src/view/shared/gradiente_app.dart';
import 'package:manutencao_usc/src/view/shared/profile_tile.dart';

class TabHome extends StatelessWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? telaPequena = Biblioteca.isTelaPequena(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('${Constantes.nomeApp} - Home'),
        centerTitle: telaPequena! ? true : false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradienteApp(),
          ),
        ),
      ),
      backgroundColor: Constantes.secondaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }

  Widget allCards(BuildContext context) => Scrollbar(
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              appBarColumn(context),
              actionBotoes(context),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Widget appBarColumn(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
        child: Container(
          height: 65.0,
          color: Constantes.primaryColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  ProfileTile(
                    title: "Manutenção - USC",
                    subtitle: "Tela Principal",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget actionBotoes(BuildContext context) => SingleChildScrollView(
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(
                      titulo: "Funções principais do app"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Card(
                            color: Constantes.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(
                                    width: 3, color: Colors.white)),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                showInSnackBar(
                                    'Redirecionar para a tela de novo chamado',
                                    corTexto: Colors.black,
                                    context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 175,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset(
                                                'assets/coolicon-2.png',
                                                fit: BoxFit.fill,
                                                color: Colors.white,
                                                width: 25,
                                                height: 25,
                                              ),
                                              const Text(
                                                'Novo chamado',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      InkWell(
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    width: 3,
                                    color: Constantes.secondaryColor!)),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                showInSnackBar(
                                    'Redirecionar para a tela do  ultimo chamado',
                                    corTexto: Colors.black,
                                    context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 175,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset(
                                                'assets/coolicon.png',
                                                fit: BoxFit.fill,
                                                color:
                                                    Constantes.secondaryColor,
                                                width: 25,
                                                height: 25,
                                              ),
                                              Text(
                                                'Ultimo chamado',
                                                style: TextStyle(
                                                    color: Constantes
                                                        .secondaryColor,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 20.0,
                                                        child: Text(
                                                            'Goteira dentro da sala 307',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .amber[900],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16.0,
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 10.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              'assets/coolicon-1.png',
                                                              color: Constantes
                                                                  .secondaryColor,
                                                              fit: BoxFit.fill,
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 7,
                                                              ),
                                                              child: Text(
                                                                  '21:45',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Constantes
                                                                        .secondaryColor,
                                                                    fontSize:
                                                                        14.0,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
