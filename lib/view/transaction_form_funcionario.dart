import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/model/equipes.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import '../controller/equipe_controller.dart';
import '../controller/funcionario_controller.dart';
import '../widget/text_field_custom_widget.dart';

class TransactionFormFuncionario extends StatefulWidget {

  const TransactionFormFuncionario({Key? key}) : super(key: key);

  @override
  _TransactionFormFuncionarioState createState() => _TransactionFormFuncionarioState();
}


class _TransactionFormFuncionarioState extends State<TransactionFormFuncionario> {
  final _titleController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _unidadeController = TextEditingController();
  final inputFuncionario = TextEditingController();
  String? inputEquipe = "";
  final List<String> _equipeConst = [];


  List<String> _listUnidadeDropLocal = [];


  _submitForm([String? textParam, BuildContext? contextParam]) async {
    if(textParam != "" && textParam != null){
      List<Equipes> equipeSalva =
          Provider.of<EquipeController>(context, listen: false).itemsEquipeConfig;
      var equipeSelecionada = equipeSalva.firstWhere((element) => element.descricaoEquipe == inputEquipe);
      Funcionario funcionario = Funcionario(0, textParam as String, equipeSelecionada.id, equipeSelecionada.descricaoEquipe);
      await Provider.of<FuncionarioController>(context, listen: false).addFuncionario(funcionario);
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

  atualizarListaEquipes(BuildContext context) {
    _equipeConst.clear();
    List<Equipes> equipeSalva =
        Provider.of<EquipeController>(context, listen: false).itemsEquipeConfig;
    setState(() {
      if (equipeSalva.isNotEmpty) {
        for (var element in equipeSalva) {
          _equipeConst.add(element.descricaoEquipe);
          inputEquipe = element.descricaoEquipe;
        }
      }
    });
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    atualizarListaEquipes(context);
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
                  inputFuncionario,
                 "Funcionário",
                  // validatorObj: jaValidouPlaca
                  //     ? ValidacoesCampos.validaMarcaModelo
                  //     : null,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton(
                value: inputEquipe,
                style: const TextStyle(fontFamily: "Abel", color: Colors.white),
                hint: const Text("Cadastro de Equipes"),
                items: _equipeConst.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    if (val != null) {
                      inputEquipe = val as String?;
                    }
                  });
                },
              ),
              // Colocar aqui adaptativeDatePicker
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      "Adicionar Funcionário",
                      style: TextStyle(color: Colors.amber),
                    ),
                    onPressed: () {
                      _submitForm(inputFuncionario.text, context);
                    },
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }
}
