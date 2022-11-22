import 'package:flutter/material.dart';

class CircularAvatarStatusWidget extends StatefulWidget {
  String tipo;
  String tipoRemarcacao;

  CircularAvatarStatusWidget(this.tipo, this.tipoRemarcacao, {Key? key})
      : super(key: key);

  @override
  State<CircularAvatarStatusWidget> createState() =>
      _CircularAvatarStatusWidgetState();
}

class _CircularAvatarStatusWidgetState
    extends State<CircularAvatarStatusWidget> {
  Color backColor = Colors.yellow;
  String textoAvatar = "";

  @override
  void initState() {
    // implement initState
    super.initState();
    // textoAvatar = widget.tipo.toString();
    // switch (widget.tipo) {
    //   case "N":
    //     backColor = Colors.yellow;
    //     textoAvatar = "Novo";
    //     break;
    //   case "M":
    //     backColor = Colors.orange;
    //     textoAvatar = "Editado";
    //     break;
    //   case "A":
    //     backColor = Colors.green;
    //     textoAvatar = "OK";
    //     break;
    //   case "C":
    //     backColor = Colors.redAccent;
    //     textoAvatar = "Cancelado";
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    textoAvatar = widget.tipo.toString();
    switch (widget.tipo) {
      case "N":
        backColor = Colors.yellow;
        textoAvatar = "Novo";
        break;
      case "M":
        backColor = Colors.orange;
        textoAvatar = "Editado";
        break;
      case "A":
        backColor = Colors.green;
        textoAvatar = "OK";
        break;
      case "C":
        backColor = Colors.redAccent;
        textoAvatar = "Cancelado";
        break;
    }
    print("$textoAvatar");

    return CircleAvatar(
      radius: 35.0,
      child: widget.tipoRemarcacao == "C"
          ? Icon(
              Icons.car_repair,
              color: Colors.black,
            )
          : widget.tipoRemarcacao == "M"
              ? Icon(
                  Icons.engineering,
                  color: Colors.black,
                )
              : Icon(
                  Icons.window,
                  color: Colors.black,
                ),
      backgroundColor: backColor,
    );
  }
}
