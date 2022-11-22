import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/model/equipes.dart';
import '../controller/equipe_controller.dart';
import '../widget/text_field_custom_widget.dart';

class TransactionForm extends StatefulWidget {
  //final void Function(String, double, String) onSubmit;
  // List<String> _listIngredientesDrop;
  // List<String> _listUnidadeDrop;

  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}


class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _unidadeController = TextEditingController();
  final inputEquipe = TextEditingController();

  List<String> _listUnidadeDropLocal = [];

  _submitForm([String? textParam, BuildContext? contextParam]) async {
    if(textParam != "" && textParam != null){
      Equipes equipes = Equipes(0, textParam as String);
      await Provider.of<EquipeController>(context, listen: false).addEquipe(equipes);
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
                  inputEquipe,
                 "Equipe",
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
                      "Adicionar Equipe",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onPressed: () {
                      _submitForm(inputEquipe.text, context);
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
