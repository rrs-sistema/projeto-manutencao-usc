import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './../view/ordem_servico/ordem_servico_persiste_page.dart';
import './../view/menu/menu_titulo_grupo_menu_interno.dart';
import './../database/tabelas/ordem_servico.dart';
import './../view/shared/custom_background.dart';
import './../view/shared/gradiente_app.dart';
import './../view/shared/profile_tile.dart';
import './../database/app_db.dart';
import './../infra/sessao.dart';
import './../infra/infra.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  OrdemServico lastOrdeService = OrdemServico();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getLastOrdeService());
  }

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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrdemServicoPersistePage(
                                            ordemServicoMontado:
                                                OrdemServicoMontada(
                                                    ordemServico:
                                                        OrdemServico(),
                                                    categoria: Categoria(),
                                                    local: Local(),
                                                    localSub: LocalSub(),
                                                    statusOrdemServico:
                                                        StatusOrdemServico()),
                                            title:
                                                'Ordem de Serviço - Inserindo',
                                            operacao: 'I')));
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
                              onTap: lastOrdeService.codigo != null
                                  ? () async {
                                      var ordemServicoMontada = await Sessao
                                          .db.ordemServicoDao
                                          .consultarListaMontado(
                                              codigo: lastOrdeService.codigo);

                                      if (!mounted) return;
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  OrdemServicoPersistePage(
                                                      ordemServicoMontado:
                                                          ordemServicoMontada![
                                                              0],
                                                      title:
                                                          'Ordem de Serviço - Editando',
                                                      operacao: 'A')))
                                          .then((_) async {});
                                    }
                                  : null,
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
                                                            '${lastOrdeService.codigo != null ? lastOrdeService.descricaoProblema : 'Ordem de Serviço não cadastrada'}',
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
                                                                  lastOrdeService
                                                                              .codigo !=
                                                                          null
                                                                      ? Biblioteca.formatarDataHora(
                                                                          lastOrdeService
                                                                              .dataAbertura)
                                                                      : 'XX:XX',
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

  Future _getLastOrdeService() async {
    var ultimaOs = await Sessao.db.ordemServicoDao.pegaUltimaOrdemServico();
    if (ultimaOs != null) {
      lastOrdeService = ultimaOs;
    }
    setState(() {});
  }
}
