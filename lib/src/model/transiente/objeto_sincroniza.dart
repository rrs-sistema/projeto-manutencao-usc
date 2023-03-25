import 'dart:convert';

class ObjetoSincroniza {
  String? tabela;
  String? registros;

  ObjetoSincroniza({
    this.tabela,
    this.registros,
  });

  ObjetoSincroniza.fromJson(Map<String, dynamic> jsonDados) {
    tabela = jsonDados['tabela'];
    registros = jsonDados['registros'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};
    jsonDados['tabela'] = tabela;
    jsonDados['registros'] = registros;
    return jsonDados;
  }

  String objetoEncodeJson() {
    final jsonDados = toJson;
    return json.encode(jsonDados);
  }
}
