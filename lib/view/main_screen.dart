import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/filtro_controller.dart';
import 'package:remarcacao_chassi/controller/funcionario_controller.dart';
import 'package:remarcacao_chassi/controller/remarcacao_controller.dart';
import 'package:remarcacao_chassi/controller/seguradora_controller.dart';
import 'package:remarcacao_chassi/database/objectbox_database.dart';
import 'package:remarcacao_chassi/l10n/l10n.dart';
import 'package:remarcacao_chassi/model/remarcacao.dart';
import 'package:remarcacao_chassi/utils/app_routes.dart';
import 'package:remarcacao_chassi/view/formulario_step_nova_rem_screen.dart';
import 'package:remarcacao_chassi/view/home_screen.dart';
import 'package:remarcacao_chassi/view/pdf_view_screen.dart';
import '../controller/equipe_controller.dart';
import 'detalhe_remarcacao_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Widget _openPage<T>(
    BuildContext context,
    Widget Function(T) onPage,
  ) {
    final args = ModalRoute.of(context)!.settings.arguments as T;
    return onPage(args);
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => RemarcacaoController()),
        ChangeNotifierProvider(create: (ctx) => EquipeController()),
        ChangeNotifierProvider(create: (ctx) => FuncionarioController()),
        ChangeNotifierProvider(create: (ctx) => SeguradoraController()),
        ChangeNotifierProvider(create: (ctx) => FiltroStatusController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "REM App",
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        theme: ThemeData(
          appBarTheme: const AppBarTheme(foregroundColor: Colors.black),
          colorSchemeSeed: Colors.yellow,
          brightness: Brightness.dark,
          useMaterial3: false,
          fontFamily: "SpecialElite",
        ),
        home: const HomeScreen(),
        routes: {
          AppRoutes.HOME: (ctx) => const HomeScreen(),
          AppRoutes.NOVOCADSTEP: (ctx) => const FormStepNovaRemScreen(),
          AppRoutes.DETREMAR: (ctx) => _openPage<Remarcacao>(
                ctx,
                (obj) => DetalheRemarcacao(
                  remarcacao: obj,
                ),
              ),
          AppRoutes.PDFCARTA: (ctx) => _openPage<File>(
                ctx,
                (file) => PDfViewScreen(
                  pathPDf: file,
                ),
              ),
        },
      ),
    );
  }
}
