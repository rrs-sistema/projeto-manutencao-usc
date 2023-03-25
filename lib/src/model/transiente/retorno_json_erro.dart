class RetornoJsonErro {
  String? status;
  String? error;
  String? message;
  String? trace;
  String? tipo;

  RetornoJsonErro(
      {this.status, this.error, this.message, this.trace, this.tipo});

  RetornoJsonErro.fromJson(Map<String, dynamic> jsonDados) {
    status = jsonDados['status'];
    error = jsonDados['error'];
    message = jsonDados['message'];
    trace = jsonDados['trace'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};
    jsonDados['status'] = status;
    jsonDados['error'] = error;
    jsonDados['message'] = message;
    jsonDados['trace'] = trace;
    return jsonDados;
  }
}
