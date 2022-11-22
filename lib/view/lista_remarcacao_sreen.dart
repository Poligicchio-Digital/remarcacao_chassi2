import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/widget/linha_card_remarcacao_widget.dart';
import 'package:remarcacao_chassi/widget/linha_card_remarcacao_widget_new.dart';
import '../controller/remarcacao_controller.dart';

class ListaRemarcacaoScreen extends StatefulWidget {
  const ListaRemarcacaoScreen({Key? key}) : super(key: key);

  @override
  State<ListaRemarcacaoScreen> createState() => _ListaRemarcacaoScreenState();
}

class _ListaRemarcacaoScreenState extends State<ListaRemarcacaoScreen> {
  Key? _key;
  Key? _keyList;

  @override
  void initState() {
    // implement initState
    //Provider.of<RemarcacaoController>(context, listen: false).lerRemarcacao("", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<RemarcacaoController>(
        key: _key,
        builder: (_, data, __) => data.itemsRemarcacao.length == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 125,
                    width: 125,
                    child: Image.asset("lib/images/remarcacao_atlantica.png"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Nenhum Cadastro Efetuado!",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : ListView.builder(
                key: _keyList,
                itemCount: data.itemsRemarcacao.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // LinhaCardRemarcacaoWidget(data.itemsRemarcacao[index]),
                      LinhaCardRemarcacaoWidgetNew(data.itemsRemarcacao[index]),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
