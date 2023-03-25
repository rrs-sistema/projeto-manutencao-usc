import 'dart:developer';

class Usuario {
  String matricula = '';
  String email = '';
  String senha = '';
  String celular = '';
  String codigo = '';

  Usuario(String email, String senha) {
    email = email;
    senha = senha;
  }

  void logar() {
    log('Você acabou de fazer login');
  }
}
