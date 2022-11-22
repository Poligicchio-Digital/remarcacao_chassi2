import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/seguradora_controller.dart';
import 'package:remarcacao_chassi/model/equipes.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import 'package:remarcacao_chassi/model/seguradoras.dart';
import '../controller/equipe_controller.dart';
import '../controller/funcionario_controller.dart';
import '../widget/text_field_custom_widget.dart';

class TransactionFormSeguradora extends StatefulWidget {

  const TransactionFormSeguradora({Key? key}) : super(key: key);

  @override
  _TransactionFormSeguradoraState createState() => _TransactionFormSeguradoraState();
}


class _TransactionFormSeguradoraState extends State<TransactionFormSeguradora> {
  final _titleController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _unidadeController = TextEditingController();
  final inputSeguradora = TextEditingController();

  List<String> _listUnidadeDropLocal = [];

  _submitForm([String? textParam, BuildContext? contextParam]) async {
    if(textParam != "" && textParam != null){
      Seguradoras seguradora = Seguradoras(0,textParam);
      await Provider.of<SeguradoraController>(context, listen: false).addSeguradora(seguradora);
    }


    Navigator.of(context).pop();
    if (!_isValidForm()) {
      return;
    }

  }

  bool _isValidForm() {
    return _titleController.text != "" &&
        _quantidadeController.text != "" &&
        _unidadeController.text != "";
  }

  @override
  Widget build(BuildContext context) {
    if (_listUnidadeDropLocal.isEmpty) {
      // _listUnidadeDropLocal.addAll(widget._listUnidadeDrop);
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            // parte de baixo está somando com tamanho do teclado pegaando MediaQuery
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldCustom(
                  inputSeguradora,
                 "Seguradora",
                  // validatorObj: jaValidouPlaca
                  //     ? ValidacoesCampos.validaMarcaModelo
                  //     : null,
                ),
              ),

              // Colocar aqui adaptativeDatePicker
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      "Adicionar Seguradora",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onPressed: () {
                      _submitForm(inputSeguradora.text, context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}
