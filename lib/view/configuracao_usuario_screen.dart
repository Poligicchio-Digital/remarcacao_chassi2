import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/filtro_controller.dart';
import 'package:remarcacao_chassi/controller/seguradora_controller.dart';
import 'package:remarcacao_chassi/model/filtro_status.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import 'package:remarcacao_chassi/model/seguradoras.dart';
import 'package:remarcacao_chassi/utils/utilidades.dart';
import '../controller/equipe_controller.dart';
import '../controller/funcionario_controller.dart';
import '../model/equipes.dart';

class ConfiguracaoUsuarioScreen extends StatefulWidget {
  const ConfiguracaoUsuarioScreen({Key? key}) : super(key: key);

  @override
  State<ConfiguracaoUsuarioScreen> createState() =>
      _ConfiguracaoUsuarioScreenState();
}

class _ConfiguracaoUsuarioScreenState extends State<ConfiguracaoUsuarioScreen> {
  String? inputEquipe = "";
  String? inputExecutor = "";
  String? inputSeguradora = "";
  final List<String> _equipeConst = [];
  final List<String> _seguradoraConst = [];
  final _executorConst = [];
  bool _isEquipeCriada = false;
  List<Funcionario> funcionarioSalva = [];
  List<Seguradoras> seguradoraSalva = [];
  List<Equipes> equipeSalva = [];
  bool swithStatusNovo = true;
  bool swithStatusModificado = true;
  bool swithStatusImpresso = true;

  atualizarListaEquipes(BuildContext context) async {
    _equipeConst.clear();
    equipeSalva.clear();
    await Provider.of<EquipeController>(context, listen: false)
        .lerEquipes("")
        .then((value) => equipeSalva.addAll(value));
    setState(() {
      if (equipeSalva.isNotEmpty) {
        for (var element in equipeSalva) {
          _isEquipeCriada = true;
          _equipeConst.add(element.descricaoEquipe);
          inputEquipe = element.descricaoEquipe;
        }
      }
    });
  }

  atualizarListaSeguradora(BuildContext context) async {
    _seguradoraConst.clear();
    seguradoraSalva.clear();
    await Provider.of<SeguradoraController>(context, listen: false)
        .lerSeguradora("")
        .then((value) => seguradoraSalva.addAll(value));
    setState(() {
      if (seguradoraSalva.isNotEmpty) {
        for (var element in seguradoraSalva) {
          _seguradoraConst.add(element.descricaoSeguradora);
          inputSeguradora = element.descricaoSeguradora;
        }
      }
    });
  }

  atualizarListaFuncionarios(BuildContext context) async {
    _executorConst.clear();
    funcionarioSalva.clear();
    await Provider.of<FuncionarioController>(context, listen: false)
        .lerFuncionario("")
        .then((value) => funcionarioSalva.addAll(value));
    setState(() {
      if (funcionarioSalva.isNotEmpty) {
        for (var element in funcionarioSalva) {
          // if (inputEquipe == element.equipe.descricaoEquipe) {
          _executorConst.add(element.descricaoFuncionario);
          inputExecutor = element.descricaoFuncionario;
          // }
        }
      }
    });
  }

  atualizarFiltros(BuildContext context) async {
    // bool swithStatusNovo = true;
    // bool swithStatusModificado = true;
    // bool swithStatusImpresso = true;

    List<FiltroStatus> filtroSalvos = [];
    await Provider.of<FiltroStatusController>(context, listen: false)
        .lerFitros("")
        .then((value) => filtroSalvos.addAll(value));

    if (filtroSalvos.isNotEmpty) {
      var filtro = filtroSalvos[0];
      swithStatusNovo = filtro.AceitaNovo;
      swithStatusModificado = filtro.AceitaModificado;
      swithStatusImpresso = filtro.AceitaFinalizado;
    }
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    // voltar depois a descomentar
    atualizarListaEquipes(context);
    atualizarListaSeguradora(context);
    atualizarListaFuncionarios(context);
    atualizarFiltros(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(height: 0),
          const Text(
            'Configurações',
            style: TextStyle(fontFamily: "SpecialElite", fontSize: 23),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: inputEquipe,
                style: const TextStyle(fontFamily: "Abel", color: Colors.white),
                hint: const Text("Cadastro de Equipes       "),
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
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  await Utilidades.openTransactionFormModalEquipe(context)
                      .whenComplete(() {
                    atualizarListaEquipes(context);
                    _isEquipeCriada = true;
                  });
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  Utilidades.showMessageDialog(
                    context,
                    "CONFIRMAR EXCLUSÃO",
                    "Deseja apagar $inputEquipe ? Os funcionários atrelados serão eliminados",
                  ).then((value) async {
                    switch (value) {
                      case "S":
                        List<Equipes> equipeSalva =
                            Provider.of<EquipeController>(context,
                                    listen: false)
                                .itemsEquipeConfig;
                        var equipeDeletar = equipeSalva.firstWhere((element) =>
                            element.descricaoEquipe == inputEquipe);
                        if (equipeDeletar != null) {
                          await Provider.of<EquipeController>(context,
                                  listen: false)
                              .deleteEquipe(equipeDeletar.id)
                              .whenComplete(() async {
                            atualizarListaEquipes(context);
                            // Apagar funcionario da equipe apagada
                            for (var element in funcionarioSalva) {
                              if (inputEquipe == element.descricaoEquipe) {
                                await Provider.of<FuncionarioController>(
                                        context,
                                        listen: false)
                                    .deleteFuncionario(element.id)
                                    .whenComplete(() =>
                                        atualizarListaFuncionarios(context));
                              }
                            }
                          });
                        }
                        break;
                      case "N":
                        break;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: inputExecutor,
                style: const TextStyle(fontFamily: "Abel", color: Colors.white),
                hint: const Text("Cadastro de Funcionário"),
                items: _executorConst.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    if (val != null) {
                      inputExecutor = val as String?;
                    }
                  });
                },
              ),
              const SizedBox(width: 16),
              _isEquipeCriada
                  ? IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        await Utilidades.openTransactionFormModalFuncionario(
                                context)
                            .whenComplete(
                                () => atualizarListaFuncionarios(context));
                      },
                    )
                  : const SizedBox(
                      width: 44,
                    ),
              const SizedBox(width: 16),
              _isEquipeCriada
                  ? IconButton(
                      // isSelected: _isEquipeCriada,
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        Utilidades.showMessageDialog(
                          context,
                          "CONFIRMAR EXCLUSÃO",
                          "Deseja apagar o Funcionário $inputExecutor ?",
                        ).then((value) async {
                          switch (value) {
                            case "S":
                              List<Funcionario> funcionarioSalva =
                                  Provider.of<FuncionarioController>(context,
                                          listen: false)
                                      .itemsFuncionariosConfig;
                              var funcionarioDeletar =
                                  funcionarioSalva.firstWhere((element) =>
                                      element.descricaoFuncionario ==
                                      inputExecutor);
                              if (funcionarioDeletar != null) {
                                await Provider.of<FuncionarioController>(
                                        context,
                                        listen: false)
                                    .deleteFuncionario(funcionarioDeletar.id)
                                    .whenComplete(() =>
                                        atualizarListaFuncionarios(context));
                              }
                              break;
                            case "N":
                              break;
                          }
                        });
                      },
                    )
                  : const SizedBox(
                      width: 55,
                    ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: inputSeguradora,
                style: const TextStyle(fontFamily: "Abel", color: Colors.white),
                hint: const Text("Cadastro de Seguradora"),
                items: _seguradoraConst.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    if (val != null) {
                      inputSeguradora = val as String?;
                    }
                  });
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  await Utilidades.openTransactionFormModalSeguradora(context)
                      .whenComplete(() => atualizarListaSeguradora(context));
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  Utilidades.showMessageDialog(
                    context,
                    "CONFIRMAR EXCLUSÃO",
                    "Deseja apagar a Seguradora $inputSeguradora ?",
                  ).then((value) async {
                    switch (value) {
                      case "S":
                        List<Seguradoras> seguradoraSalva =
                            Provider.of<SeguradoraController>(context,
                                    listen: false)
                                .itemsSeguradorasConfig;
                        var seguradoraDeletar = seguradoraSalva.firstWhere(
                            (element) =>
                                element.descricaoSeguradora == inputSeguradora);
                        if (seguradoraDeletar != null) {
                          await Provider.of<SeguradoraController>(context,
                                  listen: false)
                              .deleteSeguradora(seguradoraDeletar.id)
                              .whenComplete(
                                  () => atualizarListaSeguradora(context));
                        }
                        break;
                      case "N":
                        break;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 52),
          const Text(
            'Filtros por Status',
            style: TextStyle(fontFamily: "SpecialElite", fontSize: 23),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remarcações Novas?",
                style: TextStyle(fontFamily: "SpecialElite"),
              ),
              Switch(
                  value: swithStatusNovo,
                  activeTrackColor: Colors.yellow.withOpacity(0.70),
                  onChanged: (value) async {
                    setState(
                      () {
                        this.swithStatusNovo = value;
                      },
                    );

                    FiltroStatus newFitro = FiltroStatus(0, swithStatusNovo,
                        swithStatusModificado, swithStatusImpresso);
                    await Provider.of<FiltroStatusController>(context,
                            listen: false)
                        .addFiltro(newFitro, context);
                    // atualizarOpcao(value);
                  }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remarcações Modificados?",
                style: TextStyle(fontFamily: "SpecialElite"),
              ),
              Switch(
                  value: swithStatusModificado,
                  activeTrackColor: Colors.orange.withOpacity(0.70),
                  onChanged: (value) async {
                    setState(() {
                      this.swithStatusModificado = value;
                    });

                    FiltroStatus newFitro = FiltroStatus(0, swithStatusNovo,
                        swithStatusModificado, swithStatusImpresso);
                    await Provider.of<FiltroStatusController>(context,
                            listen: false)
                        .addFiltro(newFitro, context);

                    // atualizarOpcao(value);
                  }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remarcações Impressas?",
                style: TextStyle(fontFamily: "SpecialElite"),
              ),
              Switch(
                  value: swithStatusImpresso,
                  onChanged: (value) async {
                    setState(() {
                      this.swithStatusImpresso = value;
                    });

                    FiltroStatus newFitro = FiltroStatus(0, swithStatusNovo,
                        swithStatusModificado, swithStatusImpresso);
                    await Provider.of<FiltroStatusController>(context,
                            listen: false)
                        .addFiltro(newFitro, context);
                    // atualizarOpcao(value);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
