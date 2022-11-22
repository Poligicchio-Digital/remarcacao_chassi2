class ValidacoesCampos {
  static String? validaPlaca(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo placa";
    }

    if (valor.length > 7) {
      if (valor.contains("-")) {
        return "Preenchimento inválido, somente letras e números";
      } else {
        return "Preenchimento inválido, tamanho maior que 7 caracteres";
      }
    } else {
      if (valor.length < 7) {
        return "Preenchimento inválido, tamanho menor que 7 caracteres";
      } else {
        var letrasPlaca = valor.substring(0, 3).toUpperCase();
        var numerosPlaca = valor.substring(3, 7);

        // Validar caracter especial
        if (RegExp('[^a-zA-Z0-9]').hasMatch(valor)) {
          return "Placa inválida, não usar caracteres especiais";
        }
        // Validar 3 primeiros Letras e 4 ùltimos Número
        if (RegExp('[0-9]').hasMatch(letrasPlaca)) {
          return "Placa inválida, favor verificar";
        } else {
          if (RegExp('[A-Z]').hasMatch(numerosPlaca)) {
            // Verificar se é placa mercosul
            if (RegExp('[A-Z]').hasMatch(numerosPlaca.substring(0, 1)) ||
                RegExp('[A-Z]').hasMatch(numerosPlaca.substring(2, 3)) ||
                RegExp('[A-Z]').hasMatch(numerosPlaca.substring(3, 4))) {
              return "Placa inválida, favor verificar";
            } else {
              return null;
            }
          }
        }
      }
    }
    return null;
  }

  static String? validaProprietario(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo proprietário";
    }
  }

  static String? validaMarcaModelo(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo marca/modelo";
    }
  }

  // Validar Chassi =  9BD15802774946411REM
  static String? validaChassi(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo chassi";
    }

    if (valor.length != 20) {
      return "Tamanho inválido, campo deve ter 20 caracteres";
    }

    // Validar caracter especial
    if (RegExp('[^a-zA-Z0-9]').hasMatch(valor)) {
      return "Chassi inválida, não usar caracteres especiais";
    }

    // var finalChassi = valor.substring(17, 20);
    // if (finalChassi != 'REM') {
    //   return "Número de chassi de remarcação inválido";
    // }

    return null;
  }

  static String? validaChassiMotor(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo chassi do motor";
    }

    if (valor.length != 17) {
      return "Tamanho inválido, campo deve ter 20 caracteres";
    }

    // Validar caracter especial
    if (RegExp('[^a-zA-Z0-9]').hasMatch(valor)) {
      return "Chassi inválida, não usar caracteres especiais";
    }

    // var finalChassi = valor.substring(17, 20);
    // if (finalChassi != 'REM') {
    //   return "Número de chassi de remarcação inválido";
    // }

    return null;
  }

  // Validar Oficio =  OFÍCIO Nº: 1400/2022
  static String? validaOficio(String? valor) {
    if (valor!.isEmpty) {
      return "É obri  gatório o preenchimento do campo ofício";
    }

    // Validar caracter especial
    if (RegExp('[^a-zA-Z0-9/]').hasMatch(valor)) {
      return "Ofício inválida, não usar caracteres especiais";
    }

    // Validar caracter especial
    if (RegExp('[A-Z]').hasMatch(valor)) {
      return "Número de Oficio inválido";
    } else {

      // var finalOficio = valor.substring(valor.length - 4, valor.length);
      // var anoAtual = DateTime.now().year;
      // var anoPassado = DateTime.now().year - 1;
      //
      // if (finalOficio != anoAtual.toString() && finalOficio != anoPassado.toString()) {
      //   return "Número de Ofício inválido (verificar ano)";
      // }

      return null;
    }
  }

  // Validar Protocolo =  DTRAN-PRC-2022/612233
  static String? validaProtocolo(String? valor) {
    if (valor!.isEmpty) {
      return "É obrigatório o preenchimento do campo Protocolo";
    }

    // Validar caracter especial
    if (RegExp('[^a-zA-Z0-9/-]').hasMatch(valor)) {
      return "Protocolo inválido, não usar caracteres especiais";
    }

    return null;

    // Validar caracter especial
    // if (RegExp('[A-Z]').hasMatch(valor)) {
    //   return "Número de Oficio inválido";
    // } else {
    //
    //   var finalOficio = valor.substring(valor.length - 4, valor.length);
    //   var anoAtual = DateTime.now().year;
    //   var anoPassado = DateTime.now().year - 1;
    //
    //   if (finalOficio != anoAtual.toString() && finalOficio != anoPassado.toString()) {
    //     return "Número de Ofício inválido (verificar ano)";
    //   }
    //
    //   return null;
    // }
  }


}
