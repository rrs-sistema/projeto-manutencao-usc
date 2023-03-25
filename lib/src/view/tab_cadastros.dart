import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:manutencao_usc/src/infra/infra.dart';

import 'package:manutencao_usc/src/view/shared/custom_background.dart';
import 'package:manutencao_usc/src/view/shared/gradiente_app.dart';
import 'package:manutencao_usc/src/view/shared/profile_tile.dart';

import 'package:manutencao_usc/src/view/menu/menu_interno_botoes.dart';
import 'package:manutencao_usc/src/view/menu/menu_titulo_grupo_menu_interno.dart';

class TabCadastros extends StatelessWidget {
  const TabCadastros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? telaPequena = Biblioteca.isTelaPequena(context);
    return Scaffold(
      appBar: AppBar(
        //title: const Text('${Constantes.nomeApp} - Módulo Cadastros'),
        title: Text(Biblioteca.isDesktop()
            ? '${Constantes.nomeApp} - Módulo Cadastros'
            : '${Constantes.nomeApp} - Cadastros'),
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

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            const SizedBox(
              height: 10,
            ),
            actionMenuCadastroGerais(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: Container(
            color: Constantes.primaryColor,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    ProfileTile(
                      title: "Manutenção - USC",
                      subtitle: "Módulo de Cadastros",
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget actionMenuCadastroGerais() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const MenuTituloGrupoMenuInterno(titulo: "Cadastros Gerais"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Categoria",
                        circleColor: Colors.orange,
                        rota: "/categoriaLista"),
                    segundoBotao: BotaoMenu(
                        // ignore: deprecated_member_use
                        icon: FontAwesomeIcons.truckLoading,
                        label: "Locais",
                        circleColor: Colors.teal,
                        rota: "/localLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.idBadge,
                        label: "Status",
                        circleColor: Colors.purple,
                        rota: "/statusLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
