import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/view/usuario/login/login_screen.dart';

import './../view/cadastros/status_ordem_servico/status_ordem_servico_lista_page.dart';
import './../view/cadastros/permissao/permissao_lista_page.dart';
import './../view/cadastros/categoria/categoria_lista_page.dart';
import './../view/cadastros/local/local_sub_lista_page.dart';
import './../view/cadastros/usuario/usuario_lista_page.dart';
import './../view/cadastros/local/local_lista_page.dart';
import './../view/home_page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      // Home
      case '/':
        //return MaterialPageRoute(builder: (_) => const HomePage());
        return MaterialPageRoute(builder: (context) => const HomePage());
      // Categoria
      case '/categoriaLista':
        return MaterialPageRoute(
            builder: (context) => const CategoriaListaPage());
      // Local
      case '/localLista':
        return MaterialPageRoute(builder: (context) => const LocalListaPage());
      // Sub Local
      case '/localSubLista':
        return MaterialPageRoute(
            builder: (context) => const LocalSubListaPage());
      // Status da ordem
      case '/statusOrdemServicoLista':
        return MaterialPageRoute(
            builder: (context) => const StatusOrdemServicoListaPage());
      // Permissão do usuário
      case '/permissaoLista':
        return MaterialPageRoute(
            builder: (context) => const PermissaoListaPage());
      // Permissão do usuário
      case '/usuarioLista':
        return MaterialPageRoute(
            builder: (context) => const UsuarioListaPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      // default
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
              body: Center(
            child: Text('Nenhuma rota definida para {$settings.name}'),
          )),
        );
    }
  }

  static dynamic definirRotasWidget(String rota) {
    switch (rota) {
      case '/':
        return const HomePage();
      case '/categoriaLista':
        return const CategoriaListaPage();
      case '/localLista':
        return const LocalListaPage();
      case '/localSubLista':
        return const LocalSubListaPage();
      case '/statusOrdemServicoLista':
        return const StatusOrdemServicoListaPage();
      case '/usuarioLista':
        return const UsuarioListaPage();
      case '/permissaoLista':
        return const PermissaoListaPage();
      case '/login':
        return const LoginScreen();
      default:
        null;
    }
  }
}
