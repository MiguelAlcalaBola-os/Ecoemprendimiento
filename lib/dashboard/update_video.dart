import 'package:flutter/material.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

import '../constants/Theme.dart';

class UpdateVideo extends StatefulWidget {
  const UpdateVideo({Key key}) : super(key: key);

  @override
  State<UpdateVideo> createState() => _UpdateVideoState();
}

class _UpdateVideoState extends State<UpdateVideo> {
  final String entidad = 'Video';
  final videoNombreController = TextEditingController();
  final videoEnlaceController = TextEditingController();
  Map dataVideo;

  void getVideoData(String videoKey) async {
    dataVideo = await CRUDServices().getOneData(entidad, videoKey);
    videoNombreController.text = dataVideo['nombre'];
    videoEnlaceController.text = dataVideo['enlace'];
  }

  @override
  Widget build(BuildContext context) {
    final String videoKey = ModalRoute.of(context).settings.arguments as String;
    getVideoData(videoKey);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar registro"),
        backgroundColor: MaterialColors.myprimary,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Actualizando registro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: videoNombreController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: 'Ingrese el título',
                  labelText: 'Título del Video',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: videoEnlaceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: 'Ingrese el link del video',
                  labelText: 'Enlace del video',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MaterialColors.mysecondary,
                    minimumSize: const Size(180.0, 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    bool resp = await CRUDServices().updateData(
                        context,
                        {
                          'nombre': videoNombreController.text,
                          'enlace': videoEnlaceController.text
                        },
                        entidad,
                        videoKey);
                    if (resp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Video actualizado'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Algo salio mal'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text('Actualizar Datos',
                      style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
