// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
// // import 'package:qrhome_administrador/service/Utilidades.dart';
// // import 'package:qrhome_administrador/service/auth_service.dart';
// // import 'package:qrhome_administrador/service/store.dart';
// // import 'package:qrhome_administrador/utils/app_routes.dart';
// // import 'package:email_validator/email_validator.dart';
//
// class AutenticacaoScreen extends StatefulWidget {
//   const AutenticacaoScreen({Key? key}) : super(key: key);
//
//
//   @override
//   State<AutenticacaoScreen> createState() => _AutenticacaoScreenState();
// }
//
// class _AutenticacaoScreenState extends State<AutenticacaoScreen> {
//   final emailController = TextEditingController();
//   final senhaController = TextEditingController();
//   final nomeController = TextEditingController();
//   final telefoneController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   bool ehLogin = true;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   late String titulo;
//   late String acaoButton;
//   late String alternarButton;
//   // late User? _userLogin;
//   late bool inicializarTextos;
//   late bool obscureTextController = true;
//   bool estaProcessando = false;
//   int selectedRadio = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     inicializarTextos = true;
//     selectedRadio = 1;
//   }
//
//   // Mudar true ou false do clique do Radio
//   setRadioSelecionado(int val) {
//     setState(() {
//       selectedRadio = val;
//       print("RADIO = $val");
//     });
//   }
//
//   @override
//   Future<void> didChangeDependencies() async {
//     setFormAction(true, "INIT");
//     if (emailController.text == "") {
//       // try {
//       //   var map = await Store.getMap('usuario');
//       //   if (map != null) {
//       //     setState(() {
//       //       if (map['email'] != null) {
//       //         emailController.text = map['email'];
//       //       }
//       //     });
//       //   }
//       // } catch (e) {
//       //   print("Erro lerSharedPreference() $e");
//       // }
//     }
//
//     super.didChangeDependencies();
//   }
//
//   void setFormAction(bool acao, String tipo) {
//     if ((inicializarTextos && tipo == "INIT") || tipo == "BT") {
//       setState(() {
//         inicializarTextos = false;
//         ehLogin = acao;
//         if (ehLogin) {
//           titulo = "Bem Vindo";
//           acaoButton = "Login";
//           alternarButton = "Ainda não tem conta? Cadastre-se agora";
//         } else {
//           titulo = "Crie sua Conta";
//           acaoButton = "Cadastrar";
//           alternarButton = "Voltar ao Login";
//         }
//       });
//     }
//   }
//
//   Future<String> login() async {
//     bool erroInternet = false;
//     // Verificar conexão com a  internet
//     Future<bool> isConectadoInternet = Utilidades.verificarConexaoInternet();
//     await isConectadoInternet.then((value) => erroInternet = value);
//
//     if (!erroInternet) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(AppLocalizations.of(context)!.erroConexaoInternet),
//       ));
//       return "E";
//     } else {
//       try {
//         await Provider.of<AuthService>(context, listen: false)
//             .login(emailController.text, senhaController.text, context)
//             .whenComplete(() {
//           _userLogin = Provider.of<AuthService>(context, listen: false).usuario;
//           if (_userLogin != null) {
//             return "S";
//           } else {
//             return "E";
//           }
//         });
//       } on AuthMessage catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("${e.message}")));
//         return "E";
//       }
//     }
//     return "S";
//   }
//
//   Future<String> registrar() async {
//     bool erroInternet = false;
//     // Verificar conexão com a  internet
//     Future<bool> isConectadoInternet = Utilidades.verificarConexaoInternet();
//     await isConectadoInternet.then((value) => erroInternet = value);
//
//     if (!erroInternet) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(AppLocalizations.of(context)!.erroConexaoInternet),
//       ));
//
//       return "E";
//     } else {
//       try {
//         await Provider.of<AuthService>(context, listen: false).registrar(
//           emailController.text,
//           senhaController.text,
//           nomeController.text,
//           telefoneController.text,
//           context,
//         );
//       } on AuthMessage catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("${e.message}")));
//
//         return "E";
//       }
//     }
//
//     return "S";
//   }
//
//   bool validarEmail(String emailParam) {
//     final bool retorno = EmailValidator.validate(emailParam);
//     return retorno;
//   }
//
//   Future<void> _inicializarAutenticacao(BuildContext contextParam) async {
//     bool tempoLimite = false;
//     AuthService auth = Provider.of<AuthService>(contextParam);
//
//     while (auth.emProcessamento || !tempoLimite) {
//       print("WHILE ${auth.emProcessamento} tempo limite $tempoLimite");
//       await Future.delayed(Duration(milliseconds: 1000));
//       tempoLimite = true;
//     }
//
//     print("FORA WHILE: auth ${auth.usuario}");
//
//     if (auth.usuario != null) {
//       Navigator.of(contextParam).pushReplacementNamed(AppRoutes.HOME);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _inicializarAutenticacao(context),
//       builder: (ctx, snapshot) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Theme.of(context).primaryColorLight, Colors.white70],
//             ),
//           ),
//           child: Scaffold(
//             key: _scaffoldKey,
//             // backgroundColor: Theme.of(context).primaryColorLight,
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               brightness: Brightness.dark,
//               backgroundColor: Theme.of(context).primaryColorDark,
//               title: Text(
//                 AppLocalizations.of(context)!.administrator,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 24),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // ******Titulo
//                       Text(
//                         titulo,
//                         style: TextStyle(
//                             fontSize: 35,
//                             fontFamily: "Baloo2",
//                             letterSpacing: -1.5),
//                       ),
//
//                       // ******Email
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 12, bottom: 12, left: 24, right: 24),
//                         child: TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: "Email",
//                             icon: Icon(Icons.email),
//                             fillColor: Theme.of(context).focusColor,
//                             filled: true,
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return AppLocalizations.of(context)!.emailCorreto;
//                             } else
//                             // Validar Email
//                             if (!validarEmail(value)) {
//                               return AppLocalizations.of(context)!
//                                   .emailInvalidoVerificar;
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       // ******Senha
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 12, bottom: 12, left: 24, right: 24),
//                         child: TextFormField(
//                           controller: senhaController,
//                           obscureText: obscureTextController,
//                           decoration: InputDecoration(
//                             icon: Icon(Icons.lock),
//                             border: OutlineInputBorder(),
//                             labelText: AppLocalizations.of(context)!.senha,
//                             fillColor: Theme.of(context).focusColor,
//                             filled: true,
//                             suffixIcon: GestureDetector(
//                               child: obscureTextController
//                                   ? Icon(Icons.visibility)
//                                   : Icon(Icons.visibility_off),
//                               onTap: () {
//                                 setState(() {
//                                   obscureTextController =
//                                       !obscureTextController;
//                                 });
//                               },
//                             ),
//                           ),
//                           keyboardType: TextInputType.text,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return AppLocalizations.of(context)!.informaSenha;
//                             } else if (value.length < 6) {
//                               return AppLocalizations.of(context)!
//                                   .minimoCaractSenha;
//                             } else
//                               return null;
//                           },
//                         ),
//                       ),
//                       // ****** Nome da Imobiliaria
//                       if (!ehLogin)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 12, bottom: 12, left: 24, right: 24),
//                           child: TextFormField(
//                             controller: nomeController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText:
//                                   AppLocalizations.of(context)!.nomeImobiliaria,
//                               fillColor: Theme.of(context).focusColor,
//                               filled: true,
//                             ),
//                             keyboardType: TextInputType.text,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return AppLocalizations.of(context)!
//                                     .campoObrigatorio;
//                               } else
//                                 return null;
//                             },
//                           ),
//                         ),
//                       // ****** Telefone
//                       if (!ehLogin)
//                         // Escolher Fixo ou Celular
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: 3, bottom: 3, left: 12, right: 12),
//                           child: ButtonBar(
//                             alignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Row(
//                                 children: [
//                                   Radio(
//                                     value: 1,
//                                     groupValue: selectedRadio,
//                                     activeColor: Colors.amber,
//                                     onChanged: (val) {
//                                       print("Radio $val");
//                                       // setRadioSelecionado(val);
//                                       setState(() {
//                                         selectedRadio = val as int;
//                                       });
//                                     },
//                                   ),
//                                   Text(AppLocalizations.of(context)!.celular),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                     value: 2,
//                                     groupValue: selectedRadio,
//                                     activeColor: Colors.amber,
//                                     onChanged: (val) {
//                                       print("Radio $val");
//                                       setRadioSelecionado(val as int);
//                                     },
//                                   ),
//                                   Text(AppLocalizations.of(context)!
//                                       .telefoneFixo),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       if (!ehLogin)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 12, bottom: 12, left: 24, right: 24),
//                           child: TextFormField(
//                             controller: telefoneController,
//                             inputFormatters: [
//                               (selectedRadio == 1)
//                                   ? TelefoneMask()
//                                   : TelefoneMaskFixo(),
//                             ],
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: AppLocalizations.of(context)!.telefone,
//                               fillColor: Theme.of(context).focusColor,
//                               filled: true,
//                             ),
//                             keyboardType: TextInputType.phone,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return AppLocalizations.of(context)!
//                                     .campoObrigatorio;
//                               } else
//                                 return null;
//                             },
//                           ),
//                         ),
//                       // ******Botão Ação
//                       InkWell(
//                         onTap: () {
//                           if (formKey.currentState!.validate()) {
//                             if (ehLogin) {
//                               setState(() {
//                                 estaProcessando = true;
//                               });
//                               login().then((value) {
//                                 if (value == "S") {
//                                   Navigator.of(context)
//                                       .pushReplacementNamed(AppRoutes.HOME);
//                                 } else {
//                                   setState(() {
//                                     estaProcessando = false;
//                                   });
//                                 }
//                               });
//                             } else {
//                               setState(() {
//                                 estaProcessando = true;
//                               });
//                               registrar().then((value) {
//                                 if (value == "S") {
//                                   Navigator.of(context)
//                                       .pushReplacementNamed(AppRoutes.HOME);
//                                 } else {
//                                   setState(() {
//                                     estaProcessando = false;
//                                   });
//                                 }
//                               });
//                               // registrar().whenComplete(() => Navigator.of(context)
//                               //     .pushReplacementNamed(AppRoutes.HOME));
//                             }
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               top: 24, bottom: 12, left: 24, right: 24),
//                           child: Container(
//                             height: 50,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (!estaProcessando)
//                                     ehLogin
//                                         ? Icon(Icons.login)
//                                         : Icon(Icons.info),
//                                   if (estaProcessando)
//                                     CircularProgressIndicator(
//                                       color: Colors.black,
//                                     ),
//                                   SizedBox(width: 16),
//                                   Text(
//                                     acaoButton,
//                                     style: TextStyle(
//                                         fontFamily: "Baloo2",
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 gradient: LinearGradient(colors: [
//                                   Colors.amber,
//                                   Colors.amberAccent,
//                                 ])),
//                           ),
//                         ),
//                       ),
//                       // ******Escolher login ou cadastrar
//                       TextButton(
//                         onPressed: () => setFormAction(!ehLogin, "BT"),
//                         child: Text(
//                           alternarButton,
//                           style: TextStyle(fontFamily: "Baloo2", fontSize: 17),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       // ******Esqueci a senha
//                       if (ehLogin)
//                         TextButton(
//                           onPressed: () {
//                             // esqueciSenha(emailController.text);
//                             Navigator.of(context)
//                                 .pushNamed(AppRoutes.FORGOTPASSWORD);
//                           },
//                           child: Text(
//                             AppLocalizations.of(context)!.esqueceuSenha,
//                             style:
//                                 TextStyle(fontFamily: "Baloo2", fontSize: 14),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class TelefoneMask extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var telefone = newValue.text;
//
//     if (newValue.text.length > 14) {
//       // if (newValue.text.length > 15) {
//       return oldValue;
//     }
//
//     telefone = telefone.replaceAll(RegExp(r'\D'), '');
//     final caracteres = telefone.characters.toList();
//     String telefoneFormatado = "";
//
//     for (var i = 0; i < caracteres.length; i++) {
//       if (i == 0) {
//         telefoneFormatado += "(";
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 3) {
//       } else if (i == 2) {
//         telefoneFormatado += ")";
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 6) {
//       } else if (i == 5) {
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 8) {
//       } else if (i == 7) {
//         telefoneFormatado += "-";
//         telefoneFormatado += caracteres[i];
//       } else {
//         telefoneFormatado += caracteres[i];
//       }
//     }
//
//     return newValue.copyWith(
//         text: telefoneFormatado,
//         selection: TextSelection.fromPosition(
//           TextPosition(offset: telefoneFormatado.length),
//         ));
//   }
// }
//
// class TelefoneMaskFixo extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var telefone = newValue.text;
//
//     // if (newValue.text.length > 14) {
//     if (newValue.text.length > 13) {
//       return oldValue;
//     }
//
//     telefone = telefone.replaceAll(RegExp(r'\D'), '');
//     final caracteres = telefone.characters.toList();
//     String telefoneFormatado = "";
//
//     for (var i = 0; i < caracteres.length; i++) {
//       if (i == 0) {
//         telefoneFormatado += "(";
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 3) {
//       } else if (i == 2) {
//         telefoneFormatado += ")";
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 5) {
//       } else if (i == 4) {
//         // telefoneFormatado += ")";
//         telefoneFormatado += caracteres[i];
//         // } else if (i == 7) {
//       } else if (i == 6) {
//         telefoneFormatado += "-";
//         telefoneFormatado += caracteres[i];
//       } else {
//         telefoneFormatado += caracteres[i];
//       }
//     }
//
//     return newValue.copyWith(
//         text: telefoneFormatado,
//         selection: TextSelection.fromPosition(
//           TextPosition(offset: telefoneFormatado.length),
//         ));
//   }
// }
