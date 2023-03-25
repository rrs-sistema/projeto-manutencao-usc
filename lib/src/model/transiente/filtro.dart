import 'dart:convert';

class Filtro {
  String? campo;
  String? valor;
  String? dataInicial;
  String? dataFinal;
  String? condicao;
  String? where;
  // será utilizado quando o filtro for múltiplo, ou seja, quando mais de um filtro for enviado para o servidor

  Filtro({this.campo, this.valor, this.dataInicial, this.dataFinal});

  Filtro.fromJson(Map<String, dynamic> jsonDados) {
    campo = jsonDados['campo'];
    valor = jsonDados['valor'];
    dataInicial = jsonDados['dataInicial'];
    dataFinal = jsonDados['dataFinal'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};
    jsonDados['campo'] = campo;
    jsonDados['valor'] = valor;
    jsonDados['dataInicial'] = dataInicial;
    jsonDados['dataFinal'] = dataFinal;
    return jsonDados;
  }
}

String filtroEncodeJson(Filtro filtro) {
  final jsonDados = filtro.toJson;
  return json.encode(jsonDados);
}
