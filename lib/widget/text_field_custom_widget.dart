import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/vos/placa.dart';

class TextFieldCustom extends StatefulWidget {

  TextEditingController? inputProprietarioParam;
  String? labelParam;
  late final String? Function(String?)? validatorObj;

  TextFieldCustom(this.inputProprietarioParam, this.labelParam,{this.validatorObj});

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: widget.validatorObj,
      style: const TextStyle(fontFamily: "Abel"),
      controller: widget.inputProprietarioParam,
      decoration: InputDecoration(
        labelText: widget.labelParam,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
