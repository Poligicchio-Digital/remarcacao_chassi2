import 'package:flutter/material.dart';
import 'package:remarcacao_chassi/widget/circular_avatar_status_widget.dart';
import '../model/remarcacao.dart';
import '../utils/app_routes.dart';

class LinhaCardRemarcacaoWidgetNew extends StatefulWidget {
  Remarcacao remarcacaoLista;

  LinhaCardRemarcacaoWidgetNew(this.remarcacaoLista, {Key? key}) : super(key: key);

  @override
  State<LinhaCardRemarcacaoWidgetNew> createState() =>
      _LinhaCardRemarcacaoWidgetNewState();
}

class _LinhaCardRemarcacaoWidgetNewState extends State<LinhaCardRemarcacaoWidgetNew> {
  String tipoRemarcacao = "C";
  var listNumeros = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  Key? _keyCard;

  @override
  void initState() {
    // implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.remarcacaoLista.nChassi.isNotEmpty) {
      tipoRemarcacao = "C";
    }
    if (widget.remarcacaoLista.nMotor.isNotEmpty) {
      tipoRemarcacao = "M";
    }
    if (widget.remarcacaoLista.nVidro.isNotEmpty) {
      tipoRemarcacao = "V";
    }

    return GestureDetector(
      onTap: () async {
        // abri tela de detalhe
        Navigator.of(context)
            .pushNamed(AppRoutes.DETREMAR, arguments: widget.remarcacaoLista);
      },
      child: Card(
        key: _keyCard,
        color: Colors.white24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Placa
            widget.remarcacaoLista.placa
                    .toString()
                    .substring(4, 5)
                    .contains(RegExp('[A-Z]'))
                ? Stack(
                    alignment: AlignmentDirectional.topCenter,
                    // textDirection: TextDirection.rtl,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            const SizedBox(height: 17),
                            Text(
                              widget.remarcacaoLista.placa
                                      .toString()
                                      .substring(0, 3)
                                      .trim() +
                                  // "-" +
                                  widget.remarcacaoLista.placa
                                      .toString()
                                      .substring(3, 7)
                                      .trim(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              // textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: 140,
                        height: 50,
                        //color: Colors.white30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        width: 140,
                        height: 10,
                        //color: Colors.white30,
                      ),
                    ],
                  )
                : Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white70,
                        ),
                        width: 140,
                        height: 50,
                        //color: Colors.white30,
                      ),
                      Text(
                        widget.remarcacaoLista.placa
                                .toString()
                                .substring(0, 3)
                                .trim() +
                            "-" +
                            widget.remarcacaoLista.placa
                                .toString()
                                .substring(3, 7)
                                .trim(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            const SizedBox(height: 12),
            ListTile(
              isThreeLine: false,
              style: ListTileStyle.list,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.remarcacaoLista.marcaModelo,
                    overflow: TextOverflow.visible,
                  ),

                  Text(widget.remarcacaoLista.proprietario,
                      overflow: TextOverflow.visible),
                ],
              ),
              leading: CircularAvatarStatusWidget(
                  widget.remarcacaoLista.tipoGravacao.toString(),
                  tipoRemarcacao),
            ),
            const SizedBox(height: 12),
            Text(
              "Data: ${widget.remarcacaoLista.dtGravacao.day}/${widget.remarcacaoLista.dtGravacao.month}/${widget.remarcacaoLista.dtGravacao.year}",
              overflow: TextOverflow.visible,
            ),
            Text("Local: ${widget.remarcacaoLista.local}"),
            if (widget.remarcacaoLista.local == "Pátio")
              Text("Seguradora ${widget.remarcacaoLista.seguradora}"),
            Text(
              "Executor: ${widget.remarcacaoLista.idUsuario}",
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
