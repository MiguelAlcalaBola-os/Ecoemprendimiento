import 'package:flutter/material.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

import '../constants/Theme.dart';

class UpdatePdf extends StatefulWidget {
  const UpdatePdf({Key key}) : super(key: key);

  @override
  State<UpdatePdf> createState() => _UpdatePdfState();
}

class _UpdatePdfState extends State<UpdatePdf> {
  final String entidad = 'Pdf';
  final pdfNombreController = TextEditingController();
  final pdfEnlaceController = TextEditingController();
  Map dataPdf;
  void getPdfData(String pdfKey) async {
    dataPdf = await CRUDServices().getOneData(entidad, pdfKey);
    pdfNombreController.text = dataPdf['nombre'];
    pdfEnlaceController.text = dataPdf['enlace'];
  }

  @override
  Widget build(BuildContext context) {
    final String pdfKey = ModalRoute.of(context).settings.arguments as String;
    getPdfData(pdfKey);
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
                controller: pdfNombreController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: 'Ingrese el título',
                  labelText: 'Título del PDF',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: pdfEnlaceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: 'Ingrese el link web del PDF',
                  labelText: 'Enlace del PDF',
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
                          'nombre': pdfNombreController.text,
                          'enlace': pdfEnlaceController.text
                        },
                        entidad,
                        pdfKey);
                    if (resp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('PDF actualizado'),
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
