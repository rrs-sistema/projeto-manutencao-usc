import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import './../view/chamados/ordem_servico_lista_page.dart';
import './../../src/infra/infra.dart';
import './../view/tab_cadastros.dart';
import './../view/tab_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manutenção USC - Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Manutenção USC - Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController(initialPage: 1);
  int maxCount = 3;

  final List<Widget> bottomBarPages = [
    const OrdenServicoListaPage(),
    const TabHome(),
    const TabCadastros(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constantes.primaryColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Constantes.primaryColor!,
                      Constantes.primaryColorError,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: AnimatedNotchBottomBar(
                pageController: _pageController,
                color: Constantes.secondaryColor!,
                itemLabelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.list_alt_sharp,
                      color: Colors.indigo[200],
                    ),
                    activeItem: Icon(
                      Icons.list_rounded,
                      color: Constantes.primaryColor,
                    ),
                    itemLabel: 'Lista',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_filled,
                      color: Colors.indigo[200],
                    ),
                    activeItem: Icon(
                      Icons.home_filled,
                      color: Constantes.primaryColor,
                    ),
                    itemLabel: 'Home',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.construction_sharp,
                        color: Colors.indigo[200]),
                    activeItem: Icon(
                      Icons.construction,
                      color: Constantes.primaryColor,
                    ),
                    itemLabel: 'Cadastro',
                  ),
                ],
                onTap: (int index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
              ),
            )
          : null,
    );
  }
}
