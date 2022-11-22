import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/funcionario_controller.dart';
import 'package:remarcacao_chassi/model/funcionario.dart';
import 'package:remarcacao_chassi/model/seguradoras.dart';
import 'package:remarcacao_chassi/view/progress_screen.dart';
import 'package:remarcacao_chassi/widget/image_input.dart';
import '../controller/equipe_controller.dart';
import '../controller/formulario_step_rem_controller.dart';
import '../controller/seguradora_controller.dart';
import '../model/equipes.dart';
import '../model/remarcacao.dart';
import '../utils/validacoes_campos.dart';
import '../widget/text_field_custom_widget.dart';

class FormStepNovaRemScreen extends StatefulWidget {
  const FormStepNovaRemScreen({Key? key}) : super(key: key);

  @override
  State<FormStepNovaRemScreen> createState() => _FormStepNovaRemScreenState();
}

class _FormStepNovaRemScreenState extends State<FormStepNovaRemScreen> {
  String? inputTipoVeiculo = "Moto";
  String? inputLocal = "Remarcadora Atlântica";
  String? inputSeguradora = "Porto Seguro";
  String? inputEquipe = "";
  String? inputExecutor = "Não Cadastrado";
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
  late List<Funcionario> funcionariosSalvos;

  int stepAtual = 0;

  // Checkbox
  bool? isChassi = true;
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

  Future<void> buscarDadosConfiguracao(BuildContext context) async {
    List<Equipes> equipeSalvos =
        Provider.of<EquipeController>(context, listen: false).itemsEquipeConfig;

    funcionariosSalvos =
        Provider.of<FuncionarioController>(context, listen: false)
            .itemsFuncionariosConfig;

    List<Seguradoras> seguradorasSalvos =
        Provider.of<SeguradoraController>(context, listen: false)
            .itemsSeguradorasConfig;

    equipeSalvos.forEach((element) {
      _equipeConst.add(element.descricaoEquipe);
      inputEquipe = element.descricaoEquipe;
    });

    funcionariosSalvos.forEach((element) {
      if (inputEquipe == element.descricaoEquipe) {
        _executorConst.add(element.descricaoFuncionario);
        //_executorConstBackup.add(element.descricaoFuncionario);
        inputExecutor = element.descricaoFuncionario;
      }
    });

    funcionariosSalvos.forEach((element) {
      // _executorConst.add(element.descricaoFuncionario);
      _executorConstBackup.add(element.descricaoFuncionario);
      //inputExecutor = element.descricaoFuncionario;
    });

    seguradorasSalvos.forEach((element) {
      _seguradorConst.add(element.descricaoSeguradora);
      inputSeguradora = element.descricaoSeguradora;
    });
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    buscarDadosConfiguracao(context);
    // _executorConst.addAll(_executor1Const);
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
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded),
            onPressed: () {
              _showMessageDialogProgress(context);
              FormularioStepRemController.lerArquivoPdf().then((value) {
                // Atribuir aqui os valores pra tela
                setState(() {
                  inputProprietario.text = value.textProprietario;
                  inputMarcaModelo.text = value.textMarca;
                  inputPlaca.text = value.textPlaca;
                  inputChassi.text = value.textChassi;
                  inputOficio.text = value.textOficio;
                  inputProtocolo.text = value.textProtocolo;
                  inputMotor.text = value.textMotor;

                  // Tirar espaço do inicio do campo
                  inputPlaca.text = inputPlaca.text.trim().toUpperCase();
                  inputChassi.text = inputChassi.text.trim().toUpperCase();
                  inputOficio.text = inputOficio.text.trim().toUpperCase();
                  inputProtocolo.text =
                      inputProtocolo.text.trim().toUpperCase();

                  switch (value.textTipo) {
                    case "AUTOMOVEL":
                      inputTipoVeiculo = "Outros";
                      break;
                    case "MOTO":
                      inputTipoVeiculo = "Moto";
                      break;
                    default:
                      inputTipoVeiculo = "Reboque ou Carroceria";
                      break;
                  }
                  Navigator.of(context).pop();
                });
              }).onError((error, stackTrace) {
                Navigator.of(context).pop();
              });
            },
          ),
        ],
        title: Text(
          AppLocalizations.of(context)!.novaRemarcacao,
          style: const TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stepper(
            elevation: 12.0,
            physics: const ClampingScrollPhysics(),
            type: StepperType.vertical,
            currentStep: stepAtual,
            onStepContinue: () {
              setState(() {
                if (stepAtual <= 5) {
                  // Validação da Placa
                  if (stepAtual == 0 || stepAtual == 5) {
                    if (formKey.currentState!.validate()) {
                      stepAtual += 1;
                      jaValidouPlaca = true;
                    }
                  } else {
                    if (stepAtual == 4 &&
                        (isMotor == false &&
                            isVidros == false &&
                            isChassi == false)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Obrigatório escolher um dos serviço")));
                      // stepAtual += 1;
                    } else {
                      stepAtual += 1;
                    }
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (stepAtual >= 1) {
                  stepAtual -= 1;
                }
              });
            },
            steps: [
              Step(
                title: Text(AppLocalizations.of(context)!.placaVeiculo),
                content: TextFieldCustom(
                  inputPlaca,
                  AppLocalizations.of(context)!.placa,
                  validatorObj: ValidacoesCampos.validaPlaca,
                  // validatorObj: Placa(inputPlaca.text.toString()).validator,
                ),
                // isActive: step1,
              ),
              Step(
                title: Text(AppLocalizations.of(context)!.tipoVeiculo),
                content: DropdownButton(
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
              ),
              Step(
                title: Text(AppLocalizations.of(context)!.local),
                content: DropdownButton(
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
              ),
              Step(
                title: inputLocal != "Pátio"
                    ? Text(AppLocalizations.of(context)!.equipe)
                    : Text(AppLocalizations.of(context)!.segEquipe),
                content: Column(
                  children: [
                    if (inputLocal == "Pátio")
                      DropdownButton(
                        value: inputSeguradora,
                        style: const TextStyle(
                            fontFamily: "Abel", color: Colors.white),
                        hint: Text(
                            AppLocalizations.of(context)!.escolhaSeguradora),
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
                      style: const TextStyle(
                          fontFamily: "Abel", color: Colors.white),
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
                      style: const TextStyle(
                          fontFamily: "Abel", color: Colors.white),
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
                  ],
                ),
                // isActive: step3,
              ),
              Step(
                title: Text(AppLocalizations.of(context)!.servico),
                content: Column(
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
              ),
              Step(
                title: Text(AppLocalizations.of(context)!.dadosCabecalho),
                content: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputProprietario,
                      AppLocalizations.of(context)!.proprietario,
                      validatorObj: jaValidouPlaca
                          ? ValidacoesCampos.validaProprietario
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputMarcaModelo,
                      AppLocalizations.of(context)!.marcaModelo,
                      validatorObj: jaValidouPlaca
                          ? ValidacoesCampos.validaMarcaModelo
                          : null,
                    ),
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
              ),
              // Etapa de fotos
              Step(
                title: const Text("Fotos"),
                content: Column(
                  children: [
                    TextFieldCustom(
                      inputDescricaoFoto1,
                      "Descrição da Foto 1",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 1, _pickedImageFoto1, "N"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto2,
                      "Descrição da Foto 2",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 2, _pickedImageFoto2, "N"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto3,
                      "Descrição da Foto 3",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 3, _pickedImageFoto3, "N"),
                    const SizedBox(height: 12),
                    TextFieldCustom(
                      inputDescricaoFoto4,
                      "Descrição da Foto 4",
                    ),
                    const SizedBox(height: 12),
                    ImageInput(_selectImage, 4, _pickedImageFoto4, "N"),
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

                              // Random numeroAleatorio = Random();
                              int chaveAleatoria = 0;
                                  // numeroAleatorio.nextInt(4294967296);

                              var objRemarcacao = Remarcacao(
                                  id: chaveAleatoria,
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
                                  tipoGravacao: "N",
                                  aprovado: false);

                              FormularioStepRemController.salvarRemarcacao(
                                  objRemarcacao, context);
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
