import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';
import 'package:remarcacao_chassi/controller/remarcacao_controller.dart';
import 'package:remarcacao_chassi/utils/app_routes.dart';
import 'package:remarcacao_chassi/utils/utilidades.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../model/dados_pdf.dart';
import '../model/remarcacao.dart';
import 'package:flutter/services.dart';


class FormularioStepRemController {
  static Future<void> gerarImpressaoPdf(
      Remarcacao objRemarcacao, BuildContext context) async {
    FormularioStepRemController.gerarVisualizacaoPdf(
            objRemarcacao, context, "CARREGAR")
        .then((value) async {
        if(value.isNotEmpty){
          OpenFilex.open(value);
        }
      // File filePdf = File(value);
      // var pdf = filePdf.open();
      // await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());

      // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    });
  }

  static Future<String> gerarVisualizacaoPdf(
      Remarcacao objRemarcacao, BuildContext context, String tipo) async {
    //Create a PDF document
    final PdfDocument document = PdfDocument();
    //Add a new page
    final PdfPage page = document.pages.add();

    page.graphics.drawString(
      'AO\n\nDepto Estadual de Trânsito\n\nA/C Sr(a). Chefe da SAT/DILI\n\nSão Paulo - SP\n\n',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      // brush: PdfSolidBrush(PdfColor(255, 36, 0)),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    late String referente;
    if (objRemarcacao.nChassi.isNotEmpty) {
      referente = "Ref.: Gravação de Chassi";
    }
    if (objRemarcacao.nMotor.isNotEmpty) {
      referente = "Ref.: Gravação do Motor";
    }
    if (objRemarcacao.nVidro.isNotEmpty) {
      referente = "Ref.: Gravação do Vidro";
    }

    page.graphics.drawString(
      referente,
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: const Rect.fromLTWH(0, 110, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      '_______________________________________________________________________________________',
      PdfStandardFont(PdfFontFamily.helvetica, 13),
      bounds: const Rect.fromLTWH(0, 140, 630, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      'PROPRIETÁRIO:',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 170, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    // nome da pessoa
    page.graphics.drawString(
      objRemarcacao.proprietario,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(120, 170, 370, 150), // era 3 = 230
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      'MARCA/MODELO:',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 190, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    //
    page.graphics.drawString(
      objRemarcacao.marcaModelo,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(120, 190, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      'PLACA:',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 210, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    //
    page.graphics.drawString(
      objRemarcacao.placa,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(120, 210, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    if (objRemarcacao.nChassi.isNotEmpty) {
      page.graphics.drawString(
        'Nº CHASSI:',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );
      page.graphics.drawString(
        objRemarcacao.nChassi,
        PdfStandardFont(PdfFontFamily.helvetica, 13),
        bounds: const Rect.fromLTWH(120, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(255, 36, 0)),
      );
    }

    if (objRemarcacao.nMotor.isNotEmpty) {
      page.graphics.drawString(
        'Nº MOTOR:',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );
      page.graphics.drawString(
        objRemarcacao.nMotor,
        PdfStandardFont(PdfFontFamily.helvetica, 13),
        bounds: const Rect.fromLTWH(120, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(255, 36, 0)),
      );
    }

    if (objRemarcacao.nVidro.isNotEmpty) {
      page.graphics.drawString(
        'Nº VIDRO:',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );
      page.graphics.drawString(
        objRemarcacao.nVidro,
        PdfStandardFont(PdfFontFamily.helvetica, 13),
        bounds: const Rect.fromLTWH(120, 230, 230, 150),
        brush: PdfSolidBrush(PdfColor(255, 36, 0)),
      );
    }

    page.graphics.drawString(
      'OFÍCIO DE Nº:',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 250, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
    //
    page.graphics.drawString(
      objRemarcacao.oficioNum,
      PdfStandardFont(PdfFontFamily.helvetica, 13),
      bounds: const Rect.fromLTWH(120, 250, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      'Nº PROTOCOLO:',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 270, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      objRemarcacao.numProtocolo,
      PdfStandardFont(PdfFontFamily.helvetica, 13),
      bounds: const Rect.fromLTWH(120, 270, 230, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    page.graphics.drawString(
      '_______________________________________________________________________________________',
      PdfStandardFont(PdfFontFamily.helvetica, 13),
      bounds: const Rect.fromLTWH(0, 290, 630, 150),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

//  ######################  FOTO 1 ######################################
    if (objRemarcacao.foto1 != "") {
      page.graphics.drawString(
        objRemarcacao.descricaoFoto1,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 360, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );

      //Read image data.
      final Uint8List imageData = File(objRemarcacao.foto1).readAsBytesSync();
//  Load the image using PdfBitmap.
      final PdfBitmap image = PdfBitmap(imageData);
//  Draw the image to the PDF page.
      page.graphics.drawImage(
        image,
        const Rect.fromLTWH(0, 380, 230, 150),
      );
    }

//  ######################  FOTO 2 ######################################
    if (objRemarcacao.foto2 != "") {
      page.graphics.drawString(
        objRemarcacao.descricaoFoto2,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(280, 360, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );

      //Read image data.
      final Uint8List imageData = File(objRemarcacao.foto2).readAsBytesSync();
//  Load the image using PdfBitmap.
      final PdfBitmap image = PdfBitmap(imageData);
//  Draw the image to the PDF page.
      page.graphics.drawImage(
        image,
        const Rect.fromLTWH(280, 380, 230, 150),
      );
    }

    //  ######################  FOTO 3 ######################################
    if (objRemarcacao.foto3 != "") {
      page.graphics.drawString(
        objRemarcacao.descricaoFoto3,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 545, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );

      //Read image data.
      final Uint8List imageData = File(objRemarcacao.foto3).readAsBytesSync();
//  Load the image using PdfBitmap.
      final PdfBitmap image = PdfBitmap(imageData);
//  Draw the image to the PDF page.
      page.graphics.drawImage(
        image,
        const Rect.fromLTWH(0, 565, 230, 150),
      );
    }

    //  ######################  FOTO 4 ######################################
    if (objRemarcacao.foto4 != "") {
      page.graphics.drawString(
        objRemarcacao.descricaoFoto4,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(280, 545, 230, 150),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      );

      //Read image data.
      final Uint8List imageData = File(objRemarcacao.foto4).readAsBytesSync();
//  Load the image using PdfBitmap.
      final PdfBitmap image = PdfBitmap(imageData);
//  Draw the image to the PDF page.
      page.graphics.drawImage(
        image,
        const Rect.fromLTWH(280, 565, 230, 150),
      );
    }

// Rodapé
//Create a PDF page template and add footer content.
    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(280, 50, 515, 50));

//Draw text in the footer.
    String mes = "";
    switch (DateTime.now().month) {
      case 1:
        mes = "janeiro";
        break;
      case 2:
        mes = "fevereiro";
        break;
      case 3:
        mes = "março";
        break;
      case 4:
        mes = "abril";
        break;
      case 5:
        mes = "maio";
        break;
      case 6:
        mes = "junho";
        break;
      case 7:
        mes = "julho";
        break;
      case 8:
        mes = "agosto";
        break;
      case 9:
        mes = "setembro";
        break;
      case 10:
        mes = "outubro";
        break;
      case 11:
        mes = "novembro";
        break;
      case 12:
        mes = "dezembro";
        break;
    }

    footerTemplate.graphics.drawString(
        'São Paulo, ${DateTime.now().day} de $mes de ${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(260, 28, 400, 28));

//Set footer in the document.
    document.template.bottom = footerTemplate;

// Save the document.
//     File filePdf = new File();
    // abrir PDF para impressão
    File('/data/user/0/br.com.poligicchiodigital.remarcacao_chassi/app_flutter/${objRemarcacao.placa}_${objRemarcacao.id}.pdf')
        .writeAsBytes(await document.save())
        .then((value) {
      // filePdf = value;
      if (tipo == "VISUALIZAR") {
        Navigator.of(context).pushNamed(AppRoutes.PDFCARTA, arguments: value);
      }
    });

    document.dispose();
    return '/data/user/0/br.com.poligicchiodigital.remarcacao_chassi/app_flutter/${objRemarcacao.placa}_${objRemarcacao.id}.pdf';
    // return filePdf;
// Dispose the document.
  }

  static Future<DadosPDf> lerArquivoPdf() async {
    DadosPDf dados = DadosPDf();
    String textOficio = "";
    String textProtocolo = "";
    String textChassi = "";
    String textProprietario = "";
    String textMarca = "";
    String textTipo = "";
    String textPlaca = "";
    String textMotor = "";

    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
    } else {
//    Load an existing PDF document.
      final PdfDocument document = PdfDocument(
          inputBytes: File(result.files[0].path!).readAsBytesSync());
//    Extract the text from all the pages.
      var text = PdfTextExtractor(document).extractText();

      int indexOfStringOficio = text.indexOf("OFÍCIO Nº:");
      int indexOfStringProtocolo = text.indexOf("PROTOCOLO Nº:");
      int indexOfStringChassi = text.indexOf("combinação:");
      int indexOfStringProprietario = text.indexOf("Despacho");
      int indexOfStringInteressado = text.indexOf("Interessado:");
      indexOfStringInteressado = indexOfStringInteressado - 1;
      int indexOfStringCor = text.indexOf("PLACA\r\n");
      int indexOfStringMotor = text.indexOf("do motor");
      int indexOfStringCor2 = -1;
      int indexOfStringSemPapel = text.indexOf("SEM PAPEL");
      int indexOfStringNumeroReferencia = text.indexOf("Assunto:");
      int indexOfStringGravacaMotor =
          text.indexOf("AUTORIZAÇÃO PARA REMARCAÇÃO/GRAVAÇÃO DE MOTOR");

      if (indexOfStringCor < 0) {
        indexOfStringCor2 = text.indexOf("Placa");
      }

      // Chassi Motor
      if (indexOfStringMotor > 0 && indexOfStringGravacaMotor > 0) {
        // int inicio = indexOfStringMotor;
        // int fim = indexOfStringMotor + 150;
        // var lerMotorText = text.substring(inicio, fim);
        // var split = lerMotorText.split("\r\n");
        // textMotor = split[3].trim().toUpperCase();
      }

      // Oficio
      if (indexOfStringOficio > 0) {
        int inicio = indexOfStringOficio + 11;
        int fim = indexOfStringOficio + 20;
        var oficioText = text.substring(inicio, fim);
        var split = oficioText.split(" ");
        textOficio = split[0].trim();
      } else {
        if (indexOfStringSemPapel > 0) {
          int inicio = indexOfStringSemPapel + 0;
          int fim = indexOfStringSemPapel + 22;
          var oficioText = text.substring(inicio, fim);
          var split = oficioText.split("\r\n");
          textOficio = split[1].trim();
        }
      }

      if (indexOfStringProtocolo > 0) {
        int inicio = indexOfStringProtocolo + 14;
        int fim = indexOfStringProtocolo + 35;
        var protocoloText = text.substring(inicio, fim);
        var split = protocoloText.split(" ");
        textProtocolo = split[0].trim();
      } else {
        if (indexOfStringNumeroReferencia > 0) {
          int inicio = indexOfStringNumeroReferencia + 0;
          int fim = indexOfStringNumeroReferencia + 35;
          var protocoloText = text.substring(inicio, fim);
          var split = protocoloText.split("\r\n");
          textProtocolo = split[1].trim().toUpperCase();
        }
      }

      if (indexOfStringChassi > 0) {
        int inicio = indexOfStringChassi + 11;
        int fim = indexOfStringChassi + 34;
        var placaText = text.substring(inicio, fim);
        textChassi = placaText.trim();
      }

      if (indexOfStringProprietario > 0) {
        int inicio = indexOfStringProprietario + 8;
        int fim = indexOfStringInteressado;
        var nomeText = text.substring(inicio, fim);
        textProprietario = nomeText.trim();
      }

      if (indexOfStringCor2 > 0 && indexOfStringGravacaMotor > 0) {
        int inicio = indexOfStringCor2 + 16;
        int fim = indexOfStringCor2 + 105;
        //var textMarcaTipoPlacaLocal = text.substring(inicio, fim);
        var textLongo = text.substring(inicio, inicio + 200);
        var splitLongo = textLongo.split("\r\n");
        if (splitLongo[0] == "") {
          var textPlacaLocal = text.substring(inicio, inicio + 10);
          var textChassiLocal = text.substring(inicio + 11, inicio + 31);
          //var textModeloObsLocal = text.substring(inicio+47, inicio+100);
          final splitLocal =
              text.substring(inicio + 47, inicio + 100).split("\r\n");
          var textModeloLocal = splitLocal[1];

          textMarca = textModeloLocal;
          textPlaca = textPlacaLocal;
          textMarca = textMarca.replaceAll(",", "").trim();
          textMotor = textChassiLocal.trim().toUpperCase();
        } else {
          var textPlacaLocal = splitLongo[1];
          var textChassiLocal = splitLongo[0];
          var textModeloLocal = splitLongo[3];

          textMarca = textModeloLocal;
          textPlaca = textPlacaLocal;
          textMarca = textMarca.replaceAll(",", "").trim();
          textMarca = textMarca.replaceAll(":", "").trim();
          textPlaca = textPlaca.replaceAll(":", "").trim();
          textMotor = textChassiLocal.trim().toUpperCase();
        }
      }

      if (indexOfStringCor > 0) {
        int inicio = indexOfStringCor + 14;
        int fim = indexOfStringCor + 65;
        var textMarcaTipoPlaca = text.substring(inicio, fim);
        final split = textMarcaTipoPlaca.split(":");
        var totallinhas = split.length;
        if (totallinhas == 1) {
          textMarca = split[0];
          textMarca = textMarca.replaceAll(",", "").trim();
        } else if (totallinhas == 2) {
          textMarca = split[0];
          textTipo = split[1];
          textMarca = textMarca.replaceAll(",", "").trim();
          textTipo = textTipo.replaceAll(",", "").trim();
        } else if (totallinhas == 3 || totallinhas == 4) {
          textMarca = split[0];
          textTipo = split[1];
          textPlaca = split[2];
          textPlaca = textPlaca.replaceAll(",", "").trim();
          textMarca = textMarca.replaceAll(",", "").trim();
          textTipo = textTipo.replaceAll(",", "").trim();
        }
        // textMarca = "Marca/Modelo: ${split[0]}";
      }

      if (textOficio == "") {
        textOficio = textProtocolo;
      }

      dados.textOficio = textOficio;
      dados.textProtocolo = textProtocolo;
      dados.textChassi = textChassi;
      dados.textProprietario = textProprietario;
      dados.textMarca = textMarca;
      dados.textTipo = textTipo;
      dados.textPlaca = textPlaca;
      dados.textMotor = textMotor;
    }
    // Retorno
    return dados;
  }

  static void salvarRemarcacao(Remarcacao objRemarcacao, BuildContext context) {
    Provider.of<RemarcacaoController>(context, listen: false)
        .addRemarcacao(objRemarcacao)
        .whenComplete(() => Navigator.of(context).pop());
  }

  static void modifyRemarcacao(Remarcacao objRemarcacao, BuildContext context) {
    // Voltar tela inicial atualizada
    Provider.of<RemarcacaoController>(context, listen: false)
        .modifyRemarcacao(objRemarcacao.id, objRemarcacao, "UsuarioAlterador")
        .whenComplete(() {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      Utilidades.mensagemSnackBar(context,"Dados modificados com Sucesso!", Colors.green);
    });
  }

  static void deletarRemarcacao(Remarcacao objRemarcacao, BuildContext context){
    // Voltar tela inicial atualizada
    Provider.of<RemarcacaoController>(context, listen: false)
        .deleteRemarcacao(objRemarcacao.id)
        .whenComplete(() {

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      Utilidades.mensagemSnackBar(context,"Exclusão feita com sucesso!", Colors.green);
    });
  }

}
