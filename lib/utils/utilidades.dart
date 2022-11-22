import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/view/transaction_form_funcionario.dart';
import '../view/transaction_form_equipe.dart';
import '../view/transaction_form_seguradora.dart';

class Utilidades {
  static String customTrim(pTexto) {
    var letra = pTexto[0];

    if (pTexto.length > 0) {
      while (letra == '') {
        if (pTexto.length == 1) pTexto = '';

        pTexto = pTexto.substr(1);
        letra = pTexto[0];
      }

      if (pTexto.length > 0) {
        letra = pTexto[pTexto.length - 1];
        while (letra == '') {
          if (pTexto.length == 1) pTexto = '';

          pTexto = pTexto.substr(0, pTexto.length - 2);
          letra = pTexto[pTexto.length - 1];
        }
      }
    }

    return pTexto;
  }


  static Future<void> openTransactionFormModalEquipe(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return const TransactionForm();
        });
  }

  static Future<void> openTransactionFormModalFuncionario(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return const TransactionFormFuncionario();
        });
  }

  static Future<void> openTransactionFormModalSeguradora(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return const TransactionFormSeguradora();
        });
  }

  static void mensagemSnackBar(BuildContext contextParam, String mensagem, Color colorParam) {
    final snackBarCodSeu = SnackBar(
      backgroundColor: colorParam,
        content: Text(mensagem,
            style: const TextStyle(fontSize: 14, color: Colors.black)));

    ScaffoldMessenger.of(contextParam).showSnackBar(snackBarCodSeu);
  }

  static Future<String> showMessageDialog(
      BuildContext context, String title, String message) async {
    late String retorno;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                title,
              ),
              content: Text(
                message,
              ),
              actions: [
                TextButton(
                    child: const Text(
                      "SIM",
                    ),
                    onPressed: () {
                      // setState(() {
                      //   _confirmaExclusao = "S";
                      // });
                      retorno = "S";

                      Navigator.of(context).pop();
                      //return "S";
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  child: const Text(
                    "NÃO",
                  ),
                  onPressed: () {
                    // setState(() {
                    //   _confirmaExclusao = "N";
                    retorno = "N";
                    // });

                    Navigator.of(context).pop();
                    // return "N";
                  },
                )
              ],
            ));
    return retorno;
  }

  static Future<String> showMessageDialogAlert(
      BuildContext context, String title, String message) async {
    late String retorno;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
                child: const Text(
                  "OK",
                ),
                onPressed: () {
                  // setState(() {
                  //   _confirmaExclusao = "S";
                  // });
                  retorno = "S";

                  Navigator.of(context).pop();
                  //return "S";
                }),

          ],
        ));
    return retorno;
  }

}
