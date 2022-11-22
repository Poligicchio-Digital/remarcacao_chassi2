import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/view/main_screen.dart';

import 'controller/remarcacao_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // objectbox = await ObjectBox.create();
  runApp(const MainScreen());
}
