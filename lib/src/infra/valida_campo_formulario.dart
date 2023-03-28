class ValidaCampoFormulario {
  /// factory - teremos apenas uma instância de ValidaCampoFormulario - singleton
  factory ValidaCampoFormulario() {
    _this ??= ValidaCampoFormulario._();
    return _this!;
  }
  static ValidaCampoFormulario? _this;
  ValidaCampoFormulario._() : super();

  /// valida campo obrigatório
  static String? validarObrigatorio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Obrigatório informar esse campo.';
    }
    return null;
  }

  static String? validarObrigatorioTestoLongo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Obrigatório informar esse campo.';
    } else if (value.length < 15) {
      return 'Obrigatório informar esse campo com no minimo 15 caracteres.';
    }
    return null;
  }

  static String? validarObrigatorioDouble(String? value) {
    if (value == null || value == '0,00') {
      return 'Obrigatório informar esse campo.';
    }
    return null;
  }

  /// valida campos decimais como obrigatórios
  static String? validarObrigatorioDecimal(String? value) {
    if (value == '0,00') return 'Obrigatório informar esse campo.';
    return null;
  }

  /// validar se os caracteres são alfanumericos
  static String? validarAlfanumerico(String? value) {
    final RegExp nameExp =
        RegExp(r'^[A-Za-z0-9ãáàâãéèêíïóôõöúçñÃÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ\-\(\)\/ªº,. ]+$');
    if (!nameExp.hasMatch(value!)) {
      return 'Por favor, informe apenas caracteres alfanuméricos.';
    }
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são alfanumericos
  static String? validarObrigatorioAlfanumerico(String? value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarAlfanumerico(value!);
    } else {
      return campoObrigario;
    }
  }

  /// validar se os caracteres são numericos
  static String? validarNumerico(String? value) {
    if (value != null) {
      final RegExp nameExp = RegExp(r'^[0-9]+$');
      if (!nameExp.hasMatch(value)) {
        return 'Por favor, informe apenas caracteres numéricos.';
      }
    }
    return null;
  }

  /// validar se os caracteres são numericos
  static String? validarNumericoMaiorQueZero(String? value) {
    if (value != null) {
      final RegExp nameExp = RegExp(r'^[0-9]+$');
      if (!nameExp.hasMatch(value)) {
        return 'Por favor, informe apenas caracteres numéricos.';
      } else {
        if (int.tryParse(value)! <= 0) {
          return 'Por favor, informe um valor maior que zero.';
        }
      }
    }
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são numericos
  static String? validarObrigatorioNumerico(String? value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarNumerico(value);
    } else {
      return campoObrigario;
    }
  }

  /// validar se o Login é obrigatório
  static String? validarObrigatorioLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Login é obrigatório.';
    }
    if (value.length < 4) {
      return 'Esse login está muito curto';
    }
    return null;
  }

  /// validar se a Senha é obrigatória
  static String? validarObrigatorioSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória.';
    }
    if (value.length < 5) {
      return 'Essa senha está muito curta';
    }
    return null;
  }

  /// validar se a Confirmação da Senha é obrigatória
  static String? validarObrigatorioConfirmacaoSenha(
      String? senha, String? confirmacao) {
    if (senha == null || senha.isEmpty) {
      return 'Confirmação da senha é obrigatória.';
    }
    if (confirmacao == null || confirmacao.isEmpty) {
      return 'Confirmação da senha é obrigatória.';
    }
    if (senha != confirmacao) {
      return 'Confirmação não confere';
    }
    return null;
  }

  /// validar se o conteúdo do campo é um DIA válido
  static String? validarObrigatorioDIA(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarDIA(value);
    } else {
      return campoObrigario;
    }
  }

  static String? validarDIA(String? value) {
    value ??= ''; // se value for null, ponha um vazio nele

    int? dia = int.tryParse(value);
    if (dia != null) {
      if (dia >= 1 && dia <= 30) {
        return null;
      } else {
        return 'Por favor, informe um DIA válido.';
      }
    }
    return null;
  }

  static String? validarHORA(String? value) {
    value ??= ''; // se value for null, ponha um vazio nele

    // tamanho incorreto, já devolve o erro
    if (value.length != 8) {
      return 'Por favor, informe uma HORA válida.';
    }

    int? hora = int.tryParse(value.substring(0, 2));
    int? minuto = int.tryParse(value.substring(3, 5));
    int? segundo = int.tryParse(value.substring(6, 8));

    // se os valores não forem inteiros, devolve o erro
    if (hora == null || minuto == null || segundo == null) {
      return 'Por favor, informe uma HORA válida.';
    }

    // valida os valores de hora, minuto e segundo
    if ((hora < 0) ||
        (hora > 23) ||
        (minuto < 0) ||
        (minuto > 59) ||
        (segundo < 0) ||
        (segundo > 59)) {
      return 'Por favor, informe uma HORA válida.';
    }

    return null;
  }

  /// validar se o conteúdo do campo é um MÊS válido
  static String? validarObrigatorioMES(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarMES(value);
    } else {
      return campoObrigario;
    }
  }

  static String? validarMES(String value) {
    int mes = int.tryParse(value)!;
    if (mes >= 1 && mes <= 12) {
      return null;
    } else {
      return 'Por favor, informe um MÊS válido.';
    }
  }
}
