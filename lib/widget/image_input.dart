import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  final int numeracaoFoto;
  final File? fotoGravada;
  final String tipo;

  const ImageInput(
      this.onSelectImage, this.numeracaoFoto, this.fotoGravada, this.tipo);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  void initState() {
    // Ver se pega a imagem pre-gravada
    super.initState();
    if (widget.fotoGravada != null && widget.tipo == "D") {
      _storeImage = widget.fotoGravada;
    }
  }

  File? _storeImage;

  _takePicture() async {
    double? dMaxHeight = 600.0;
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: dMaxHeight,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile == null) return;

    setState(() {
      _storeImage = File(pickedFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storeImage!.path);
    final savedImage = await _storeImage!.copy(
      "${appDir.path}/$fileName",
    );
    widget.onSelectImage(savedImage, widget.numeracaoFoto);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storeImage != null
              ? _storeImage!.path != ""
                  ? Image.file(
                      _storeImage!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Text("Foto ${widget.numeracaoFoto.toString()}")
              : Text("Foto ${widget.numeracaoFoto.toString()}"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text("Tirar Foto"),
          ),
        ),
      ],
    );
  }
}
