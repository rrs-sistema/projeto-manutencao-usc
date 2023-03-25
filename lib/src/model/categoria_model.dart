import 'dart:developer';

class CategoriaModel {
  String nome = '';
  int codigo = 0;

  CategoriaModel(String codigo, String nome) {
    codigo = codigo;
    nome = nome;
  }

  void cadastrar() {
    log('Categoria cadastrado com sucesso!');
  }
}
