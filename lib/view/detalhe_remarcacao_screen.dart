import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/utils/utilidades.dart';
import 'package:remarcacao_chassi/view/progress_screen.dart';
import 'package:remarcacao_chassi/widget/image_input.dart';
import '../controller/equipe_controller.dart';
import '../controller/formulario_step_rem_controller.dart';
import '../controller/funcionario_controller.dart';
import '../controller/seguradora_controller.dart';
import '../model/equipes.dart';
import '../model/funcionario.dart';
import '../model/remarcacao.dart';
import '../model/seguradoras.dart';
import '../utils/validacoes_campos.dart';
import '../widget/text_field_custom_widget.dart';

class DetalheRemarcacao extends StatefulWidget {
  Remarcacao remarcacao;

  DetalheRemarcacao({required this.remarcacao});

  @override
  State<DetalheRemarcacao> createState() => _DetalheRemarcacaoState();
}

class _DetalheRemarcacaoState extends State<DetalheRemarcacao> {
  String? inputTipoVeiculo = "Moto";
  String? inputLocal = "Remarcadora Atlântica";
  String? inputSeguradora = "";
  String? inputEquipe = "";
  String? inputExecutor = "";
  final inputProprietario = TextEditingController();
  final inputMarcaModelo = TextEditingController();
  final inputPlaca = TextEditingController();
  final inputChassi = TextEditingController();
  final inputMotor = TextEditingController();
  final inputVidro = TextEditingController();
  final inputOficio = TextEditingController();
  final inputProtocolo = TextEditingController();

  // Descrição das Fotos
  final inputDescricaoFoto1 = TextEditingController();
  final inputDescricaoFoto2 = TextEditingController();
  final inputDescricaoFoto3 = TextEditingController();
  final inputDescricaoFoto4 = TextEditingController();
  int stepAtual = 0;
  String _confirmaExclusao = "";
  late List<Funcionario> funcionariosSalvos;

  // Checkbox
  bool? isChassi = false;
  bool? isMotor = false;
  bool? isVidros = false;
  bool jaValidouPlaca = false;
  late int _valueGroup = 1;

  final _tipoVeiculoConst = ["Moto", "Reboque ou Carroceria", "Outros"];
  final _localConst = ["Remarcadora Atlântica", "Pátio"];
  final _seguradorConst = [];
  final _equipeConst = [];
  final _executorConst = [];
  final _executorConstBackup = [];
  // final _executor1Const = ["Luis Felipe", "Pedro", "José", "Não Cadastrado"];
  // final _executor2Const = ["Eric", "Jorge", "Fábio", "Não Cadastrado"];
  final formKey = GlobalKey<FormState>();

  // Fotos
  File? _pickedImageFoto1;
  File? _pickedImageFoto2;
  File? _pickedImageFoto3;
  File? _pickedImageFoto4;

  void _selectImage(File pickedImage, int num) {
    switch (num) {
      case 1:
        setState(() {
          _pickedImageFoto1 = pickedImage;
        });
        break;
      case 2:
        setState(() {
          _pickedImageFoto2 = pickedImage;
        });
        break;
      case 3:
        setState(() {
          _pickedImageFoto3 = pickedImage;
        });
        break;
      case 4:
        setState(() {
          _pickedImageFoto4 = pickedImage;
        });
        break;
    }
    //}
  }

  void buscarDadosConfiguracao(BuildContext context) {
    List<Equipes> equipeSalvos =
        Provider
            .of<EquipeController>(context, listen: false)
            .itemsEquipeConfig;

    // List<Funcionario> funcionariosSalvos =
    funcionariosSalvos =
        Provider
            .of<FuncionarioController>(context, listen: false)
            .itemsFuncionariosConfig;

    List<Seguradoras> seguradorasSalvos =
        Provider
            .of<SeguradoraController>(context, listen: false)
            .itemsSeguradorasConfig;

    equipeSalvos.forEach((element) {
      _equipeConst.add(element.descricaoEquipe);
      // inputEquipe = element.descricaoEquipe;
    });

    funcionariosSalvos.forEach((element) {
      if (inputEquipe == element.descricaoEquipe) {
        _executorConst.add(element.descricaoFuncionario);
        //_executorConstBackup.add(element.descricaoFuncionario);
        // inputExecutor = element.descricaoFuncionario;
      }
    });

    funcionariosSalvos.forEach((element) {
      // _executorConst.add(element.descricaoFuncionario);
      _executorConstBackup.add(element.descricaoFuncionario);
      //inputExecutor = element.descricaoFuncionario;
    });

    seguradorasSalvos.forEach((element) {
      _seguradorConst.add(element.descricaoSeguradora);
      // inputSeguradora = element.descricaoSeguradora;
    });
  }

  @override
  void initState() {
    // implement initState
    super.initState();

    // if (widget.remarcacao.equipe == "Equipe Florenice") {
    //   _executorConst.addAll(_executor2Const);
    // } else {
    //   _executorConst.addAll(_executor1Const);
    // }

    // Remarcacao? remarcacaoLista = ModalRoute.of(context)?.settings.arguments as Remarcacao?;
    //
    if (widget.remarcacao.nChassi.isNotEmpty) {
      isChassi = true;
      _valueGroup = 1;
    }
    if (widget.remarcacao.nVidro.isNotEmpty) {
      isVidros = true;
      _valueGroup = 3;
    }
    if (widget.remarcacao.nMotor.isNotEmpty) {
      isMotor = true;
      _valueGroup = 2;
    }

    inputPlaca.text = widget.remarcacao.placa;
    inputTipoVeiculo = widget.remarcacao.tipoVeiculo;
    inputLocal = widget.remarcacao.local;
    inputSeguradora = widget.remarcacao.seguradora;
    inputEquipe = widget.remarcacao.equipe;
    inputExecutor = widget.remarcacao.idUsuario;
    inputProprietario.text = widget.remarcacao.proprietario;
    inputMarcaModelo.text = widget.remarcacao.marcaModelo;
    inputChassi.text = widget.remarcacao.nChassi;
    inputMotor.text = widget.remarcacao.nMotor;
    inputVidro.text = widget.remarcacao.nVidro;
    inputOficio.text = widget.remarcacao.oficioNum;
    inputProtocolo.text = widget.remarcacao.numProtocolo;
    inputDescricaoFoto1.text = widget.remarcacao.descricaoFoto1;
    inputDescricaoFoto2.text = widget.remarcacao.descricaoFoto2;
    inputDescricaoFoto3.text = widget.remarcacao.descricaoFoto3;
    inputDescricaoFoto4.text = widget.remarcacao.descricaoFoto4;

    buscarDadosConfiguracao(context);

    // Colocar as fotos salvas
    _pickedImageFoto1 = File(widget.remarcacao.foto1);
    _pickedImageFoto2 = File(widget.remarcacao.foto2);
    _pickedImageFoto3 = File(widget.remarcacao.foto3);
    _pickedImageFoto4 = File(widget.remarcacao.foto4);
  }

// Help
  _showMessageDialogProgress(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          // actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          title: Text(
            "Lendo o arquivo PDF...",
            style: TextStyle(fontSize: 14),
          ),
          content: ProgressScreen(),
        ),
      );

  @override
  void dispose() {
    //implement dispose
    inputProprietario.dispose();
    inputMarcaModelo.dispose();
    inputPlaca.dispose();
    inputChassi.dispose();
    inputMotor.dispose();
    inputVidro.dispose();
    inputOficio.dispose();
    inputProtocolo.dispose();
    inputDescricaoFoto1.dispose();
    inputDescricaoFoto2.dispose();
    inputDescricaoFoto3.dispose();
    inputDescricaoFoto4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_pickedImageFoto1!.path.toString() != "" &&
              _pickedImageFoto2!.path.toString() != "" &&
              _pickedImageFoto3!.path.toString() != "" &&
              _pickedImageFoto4!.path.toString() != "" )
            IconButton(
              onPressed: () async {
                await FormularioStepRemController.gerarImpressaoPdf(
                    widget.remarcacao, context).then((value) {

                  _pickedImageFoto1 ??= File("");
                  _pickedImageFoto2 ??= File("");
                  _pickedImageFoto3 ??= File("");
                  _pickedImageFoto4 ??= File("");

                  String placaSemEspaco = inputPlaca.text;
                  placaSemEspaco =
                      placaSemEspaco.replaceAll(" ", "");
                  placaSemEspaco = placaSemEspaco.replaceAll(
                      RegExp('[^A-Za-z0-9]'), '');

                  var objRemarcacao = Remarcacao(
                      id: widget.remarcacao.id,
                      tipoVeiculo: inputTipoVeiculo.toString(),
                      proprietario: inputProprietario.text
                          .trim()
                          .toUpperCase(),
                      marcaModelo: inputMarcaModelo.text
                          .trim()
                          .toUpperCase(),
                      placa: placaSemEspaco.trim().toUpperCase(),
                      nChassi:
                      inputChassi.text.trim().toUpperCase(),
                      nMotor: inputMotor.text.trim().toUpperCase(),
                      nVidro: inputVidro.text.trim().toUpperCase(),
                      oficioNum:
                      inputOficio.text.trim().toUpperCase(),
                      numProtocolo:
                      inputProtocolo.text.trim().toUpperCase(),
                      local: inputLocal as String,
                      seguradora: inputSeguradora as String,
                      equipe: inputEquipe as String,
                      foto1: _pickedImageFoto1!.path.toString(),
                      foto2: _pickedImageFoto2!.path.toString(),
                      foto3: _pickedImageFoto3!.path.toString(),
                      foto4: _pickedImageFoto4!.path.toString(),
                      descricaoFoto1: inputDescricaoFoto1.text,
                      descricaoFoto2: inputDescricaoFoto2.text,
                      descricaoFoto3: inputDescricaoFoto3.text,
                      descricaoFoto4: inputDescricaoFoto4.text,
                      idUsuario: inputExecutor as String,
                      tipoGravacao: "A",
                      aprovado: false);

                  objRemarcacao.dtGravacao =
                      widget.remarcacao.dtGravacao;
                  objRemarcacao.dtVerificacao =
                      widget.remarcacao.dtVerificacao;
                  objRemarcacao.usuarioCriou =
                      widget.remarcacao.usuarioCriou;
                  objRemarcacao.usuarioModificou =
                      widget.remarcacao.usuarioModificou;
                  objRemarcacao.usuarioVerificou =
                      widget.remarcacao.usuarioVerificou;

                  // mudar para Update
                  FormularioStepRemController.modifyRemarcacao(
                      objRemarcacao, context);

                });
              },
              icon: const Icon(Icons.print),
            ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Utilidades.showMessageDialog(
                context,
                "CONFIRMAR EXCLUSÃO",
                "Deseja apagar este cadastro de remarcação?",
              ).then((value) {
                switch (value) {
                  case "S":
                    // mudar para Update
                    FormularioStepRemController.deletarRemarcacao(
                        widget.remarcacao, context);
                    break;
                  case "N":
                    break;
                }
              });
            },
          ),
        ],
        title: const Text(
          // AppLocalizations.of(context)!.novaRemarcacao,
          "Editar Remarcação",
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Dados do Veículo",
                  style: TextStyle(
                      fontFamily: "Abel", fontSize: 20, color: Colors.yellow),
                ),
                const SizedBox(height: 12),
                TextFieldCustom(
                  inputMarcaModelo,
                  AppLocalizations.of(context)!.marcaModelo,
                  validatorObj: jaValidouPlaca
                      ? ValidacoesCampos.validaMarcaModelo
                      : null,
                ),
                const SizedBox(height: 12),
                TextFieldCustom(
                  inputPlaca,
                  AppLocalizations.of(context)!.placa,
                  validatorObj: ValidacoesCampos.validaPlaca,
                  // validatorObj: Placa(inputPlaca.text.toString()).validator,
                ),
                const SizedBox(height: 12),
                TextFieldCustom(
                  inputProprietario,
                  AppLocalizations.of(context)!.proprietario,
                  validatorObj: jaValidouPlaca
                      ? ValidacoesCampos.validaProprietario
                      : null,
                ),
                const SizedBox(height: 12),
                // isActive: step1,
                DropdownButton(
                  // alignment: AlignmentDirectional.bottomStart,
                  value: inputTipoVeiculo,
                  style:
                      const TextStyle(fontFamily: "Abel", color: Colors.white),
                  hint: Text(AppLocalizations.of(context)!.escolhaTipoVeiculo),
                  items: _tipoVeiculoConst.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      inputTipoVeiculo = val as String;
                    });
                  },
                ),
                // isActive: step2,
                const SizedBox(height: 22),
                const Text(
                  "Dados do DETRAN",
                  style: TextStyle(
                      fontFamily: "Abel", fontSize: 20, color: Colors.yellow),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: _valueGroup,
                            onChanged: (value) {
                              setState(() {
                                _valueGroup = value as int;
                                isChassi = true;
                                isMotor = false;
                                isVidros = false;
                                // isChassi = value as bool?;
                              });
                            }),
                        Text(AppLocalizations.of(context)!.chassi)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: _valueGroup,
                            onChanged: (value) {
                              setState(() {
                                _valueGroup = value as int;
                                isChassi = false;
                                isMotor = true;
                                isVidros = false;
                              });
                            }),
                        Text(AppLocalizations.of(context)!.motor)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 3,
                            groupValue: _valueGroup,
                            onChanged: (value) {
                              setState(() {
                                _valueGroup = value as int;
                                isChassi = false;
                                isMotor = false;
                                isVidros = true;
                              });
                            }),
                        Text(AppLocalizations.of(context)!.vidros)
                      ],
                    ),
                  ],
                ),

                Column(
                  children: [
                    if (isChassi as bool) const SizedBox(height: 12),
                    if (isChassi as bool)
                      TextFieldCustom(
                        inputChassi,
                        AppLocalizations.of(context)!.nChassi,
                        validatorObj: jaValidouPlaca
                            ? ValidacoesCampos.validaChassi
                            : null,
                      ),
                    if (isMotor as bool) const SizedBox(height: 12),
                    if (isMotor as bool)
                      TextFieldCustom(
                        inputMotor,
                        AppLocalizations.of(context)!.nMotor,
                        validatorObj: jaValidouPlaca
                            ? ValidacoesCampos.validaChassiMotor
                            : null,
                      ),
                    if (isVidros as bool) const SizedBox(height: 12),
                    if (isVidros as bool)
                      TextFieldCustom(
                          inputVidro, AppLocalizations.of(context)!.nVidro),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputOficio,
                      AppLocalizations.of(context)!.oficio,
                      validatorObj:
                          jaValidouPlaca ? ValidacoesCampos.validaOficio : null,
                    ),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputProtocolo,
                      AppLocalizations.of(context)!.nProtocolo,
                      validatorObj: jaValidouPlaca
                          ? ValidacoesCampos.validaProtocolo
                          : null,
                    ),
                  ],
                ),

                const SizedBox(height: 22),
                const Text(
                  "Dados da Remarcadora",
                  style: TextStyle(
                      fontFamily: "Abel", fontSize: 20, color: Colors.yellow),
                ),
                DropdownButton(
                  value: inputLocal,
                  style:
                      const TextStyle(fontFamily: "Abel", color: Colors.white),
                  hint: Text(AppLocalizations.of(context)!.escolhaLocal),
                  items: _localConst.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      inputLocal = val as String;
                    });
                  },
                ),
                // isActive: step3,

                if (inputLocal == "Pátio")
                  DropdownButton(
                    value: inputSeguradora,
                    style: const TextStyle(
                        fontFamily: "Abel", color: Colors.white),
                    hint: Text(AppLocalizations.of(context)!.escolhaSeguradora),
                    items: _seguradorConst.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        inputSeguradora = val as String;
                      });
                    },
                  ),
                DropdownButton(
                  value: inputEquipe,
                  style:
                      const TextStyle(fontFamily: "Abel", color: Colors.white),
                  hint: Text(AppLocalizations.of(context)!.escolhaEquipe),
                  items: _equipeConst.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      inputEquipe = val as String;
                      _executorConst.clear();
                      funcionariosSalvos.forEach((element) {
                        if (inputEquipe == element.descricaoEquipe) {
                          _executorConst.add(element.descricaoFuncionario);
                          //_executorConstBackup.add(element.descricaoFuncionario);
                          inputExecutor = element.descricaoFuncionario;
                        }
                      });
                    });

                  },
                ),
                DropdownButton(
                  value: inputExecutor,
                  style:
                      const TextStyle(fontFamily: "Abel", color: Colors.white),
                  hint: Text(AppLocalizations.of(context)!.escolhaExecutor),
                  items: _executorConst.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      inputExecutor = val as String;
                    });
                  },
                ),
                // isActive: step3,

                // isActive: step3,
                const SizedBox(height: 22),
                const Text(
                  "Fotos",
                  style: TextStyle(
                      fontFamily: "Abel", fontSize: 20, color: Colors.yellow),
                ),
                // Etapa de fotos
                Column(
                  children: [
                    TextFieldCustom(
                      inputDescricaoFoto1,
                      "Descrição da Foto 1",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 1, _pickedImageFoto1, "D"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto2,
                      "Descrição da Foto 2",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 2, _pickedImageFoto2, "D"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto3,
                      "Descrição da Foto 3",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 3, _pickedImageFoto3, "D"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto4,
                      "Descrição da Foto 4",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 4, _pickedImageFoto4, "D"),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child:
                                Text(AppLocalizations.of(context)!.salvarForm),
                            onPressed: () {
                              _pickedImageFoto1 ??= File("");
                              _pickedImageFoto2 ??= File("");
                              _pickedImageFoto3 ??= File("");
                              _pickedImageFoto4 ??= File("");

                              String placaSemEspaco = inputPlaca.text;
                              placaSemEspaco =
                                  placaSemEspaco.replaceAll(" ", "");
                              placaSemEspaco = placaSemEspaco.replaceAll(
                                  RegExp('[^A-Za-z0-9]'), '');

                              var objRemarcacao = Remarcacao(
                                  id: widget.remarcacao.id,
                                  tipoVeiculo: inputTipoVeiculo.toString(),
                                  proprietario: inputProprietario.text
                                      .trim()
                                      .toUpperCase(),
                                  marcaModelo: inputMarcaModelo.text
                                      .trim()
                                      .toUpperCase(),
                                  placa: placaSemEspaco.trim().toUpperCase(),
                                  nChassi:
                                      inputChassi.text.trim().toUpperCase(),
                                  nMotor: inputMotor.text.trim().toUpperCase(),
                                  nVidro: inputVidro.text.trim().toUpperCase(),
                                  oficioNum:
                                      inputOficio.text.trim().toUpperCase(),
                                  numProtocolo:
                                      inputProtocolo.text.trim().toUpperCase(),
                                  local: inputLocal as String,
                                  seguradora: inputSeguradora as String,
                                  equipe: inputEquipe as String,
                                  foto1: _pickedImageFoto1!.path.toString(),
                                  foto2: _pickedImageFoto2!.path.toString(),
                                  foto3: _pickedImageFoto3!.path.toString(),
                                  foto4: _pickedImageFoto4!.path.toString(),
                                  descricaoFoto1: inputDescricaoFoto1.text,
                                  descricaoFoto2: inputDescricaoFoto2.text,
                                  descricaoFoto3: inputDescricaoFoto3.text,
                                  descricaoFoto4: inputDescricaoFoto4.text,
                                  idUsuario: inputExecutor as String,
                                  tipoGravacao: "M",
                                  aprovado: false);

                              objRemarcacao.dtGravacao =
                                  widget.remarcacao.dtGravacao;
                              objRemarcacao.dtVerificacao =
                                  widget.remarcacao.dtVerificacao;
                              objRemarcacao.usuarioCriou =
                                  widget.remarcacao.usuarioCriou;
                              objRemarcacao.usuarioModificou =
                                  widget.remarcacao.usuarioModificou;
                              objRemarcacao.usuarioVerificou =
                                  widget.remarcacao.usuarioVerificou;

                              // mudar para Update
                              FormularioStepRemController.modifyRemarcacao(
                                  objRemarcacao, context);
                            },
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
