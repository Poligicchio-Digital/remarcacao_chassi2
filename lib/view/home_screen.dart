import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/funcionario_controller.dart';
import 'package:remarcacao_chassi/controller/remarcacao_controller.dart';
import 'package:remarcacao_chassi/controller/seguradora_controller.dart';
import 'package:remarcacao_chassi/model/equipes.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import 'package:remarcacao_chassi/model/remarcacao.dart';
import 'package:remarcacao_chassi/model/seguradoras.dart';
import 'package:remarcacao_chassi/utils/app_routes.dart';
import 'package:remarcacao_chassi/utils/utilidades.dart';
import 'package:remarcacao_chassi/view/configuracao_usuario_screen.dart';
import 'package:remarcacao_chassi/view/lista_remarcacao_sreen.dart';

import '../controller/equipe_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // implement initState
    List<Remarcacao> remarcacoes =
        Provider.of<RemarcacaoController>(context, listen: false)
            .itemsRemarcacao;
    if (remarcacoes.isEmpty) {
      Provider.of<RemarcacaoController>(context, listen: false)
          .lerRemarcacao("", context);
    }

    super.initState();
  }

  int _selectedIndex = 0;
  Color colorBotaoLista = Colors.white;
  Color colorBotaoConfig = Colors.white30;
  bool isBusca = false;
  bool isDesativaLupa = true;

  static const List<Widget> _widgetOptions = <Widget>[
    ListaRemarcacaoScreen(),
    ConfiguracaoUsuarioScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        isDesativaLupa = true;
        colorBotaoLista = Colors.white;
        colorBotaoConfig = Colors.white30;
      } else {
        isDesativaLupa = false;
        colorBotaoLista = Colors.white30;
        colorBotaoConfig = Colors.white;
      }
    });
  }

  Future<bool> validarConfiguracoes(BuildContext context) async {
    bool retorno = false;
    List<Equipes> lEquipe =
        await Provider.of<EquipeController>(context, listen: false)
            .itemsEquipeConfig;
    List<Funcionario> lFuncionario =
        await Provider.of<FuncionarioController>(context, listen: false)
            .itemsFuncionariosConfig;
    List<Seguradoras> lSeguradoras =
        await Provider.of<SeguradoraController>(context, listen: false)
            .itemsSeguradorasConfig;

    if (lEquipe.isNotEmpty &&
        lFuncionario.isNotEmpty &&
        lSeguradoras.isNotEmpty) {
      retorno = true;
    }

    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isDesativaLupa
            ? Text("REM App")
            : !isBusca
                ? Text(
                    "REM App",
                    style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                : TextField(
                    onSubmitted: (valor) {
                      // eliminar - na busca da placa
                      String placaBusca = valor;
                      //late int indexTraco;
                      // indexTraco = placaBusca.indexOf("-");
                      placaBusca = placaBusca.replaceAll("-", "");
                      print("${placaBusca}");
                      Provider.of<RemarcacaoController>(context, listen: false)
                          .lerRemarcacao(
                              placaBusca.trim().toUpperCase(), context);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "Busca por Placa",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                      // backgroundColor: Colors.white,
                    ),
                  ),
        backgroundColor: Colors.yellow,
        actions: !isDesativaLupa
            ? []
            : [
                isBusca
                    ? IconButton(
                        disabledColor: Colors.black,
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isBusca = false;
                            Provider.of<RemarcacaoController>(context,
                                    listen: false)
                                .lerRemarcacao("", context);
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black,
                        ),
                      )
                    : IconButton(
                        disabledColor: Colors.black,
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isBusca = true;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
              ],
      ),
      // backgroundColor: Colors.black,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Botão Lista
            IconButton(
              color: colorBotaoLista,
              onPressed: () {
                _onItemTapped(0);
              },
              icon: const Icon(Icons.list_alt_rounded),
            ),
            const SizedBox(
              width: 20,
            ),
            // Botão Configuracao
            IconButton(
              color: colorBotaoConfig,
              onPressed: () {
                _onItemTapped(1);
              },
              icon: const Icon(Icons.manage_accounts),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Navigator.pushNamed(context, AppRoutes.NOVOCAD); // Cadastro Antigo
          // Só abrir se as configurações estiverem feitas
          // bool isValidadoConfiguracaoFeitas = false;
          await validarConfiguracoes(context).then((value) {
            // Suceso pode criar Remarcação
            if (value) {
              Navigator.pushNamed(
                  context, AppRoutes.NOVOCADSTEP); // Cadastro por Step

              // Falta configurar
            } else {
              Utilidades.showMessageDialogAlert(context, "IMPORTANTE",
                  "Só é possível criar Remarcação após fazer as configurações de Equipes, Funcionários e Seguradoras");
            }
          });
        },
        backgroundColor: Colors.yellow,
        tooltip: AppLocalizations.of(context)!.criarNovoCad,
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
