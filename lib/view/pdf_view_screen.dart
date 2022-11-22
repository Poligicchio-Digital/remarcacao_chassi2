import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PDfViewScreen extends StatelessWidget {
  final File pathPDf;
  const PDfViewScreen({Key? key, required this.pathPDf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carta DETRAN"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SfPdfViewer.file(pathPDf),
    );
  }
}
