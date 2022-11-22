import 'package:flutter/material.dart';
import '../model/remarcacao.dart';

class LinhaRemarcacaoWidget extends StatelessWidget {
  Remarcacao remarcacaoLista;

  LinhaRemarcacaoWidget(this.remarcacaoLista, {Key? key}) : super(key: key);

  // const LinhaRemarcacaoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      style: ListTileStyle.list,
      title: Text(remarcacaoLista.marcaModelo),
      subtitle: Text(remarcacaoLista.proprietario),
      // leading: Text("Placa: ${remarcacaoLista.placa}"),
      leading: CircleAvatar(
        radius: 30.0,
        child: Text(
          remarcacaoLista.placa.toString(),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Abel",
              color: Colors.white),
        ),

        // backgroundImage: AssetImage("lib/images/remarcacao_atlantica.png"),
        backgroundColor: Colors.white10,
      ),
      // trailing: Column(
      //   children: [
      //     // Deixar tamanho das letras maior ou menor pra caber quando tiver muito caracter linha
      //     Flexible(
      //       fit: FlexFit.loose,
      //       child: Text(
      //         "Exec.: ${remarcacaoLista.idUsuario}",
      //         overflow: TextOverflow.visible,
      //       ),
      //     ),
      //     Flexible(
      //       fit: FlexFit.loose,
      //       child: Text(
      //         "Data: ${remarcacaoLista.dtGravacao.day}/${remarcacaoLista.dtGravacao.month}/${remarcacaoLista.dtGravacao.year}",
      //         overflow: TextOverflow.visible,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
