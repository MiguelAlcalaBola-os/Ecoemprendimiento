import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

class FormVideo extends StatefulWidget {
  //RegisterRecicladora({Key key}) : super(key: key);

  @override
  State<FormVideo> createState() => _FormVideoState();
}

class _FormVideoState extends State<FormVideo> {
  final TextEditingController _nombreVideoController = TextEditingController();
  final TextEditingController _EnlaceVideoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Video"),
        backgroundColor: MaterialColors.myprimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            //que el boton vaya al fornmulario de recicladora
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    controller: _nombreVideoController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.music_video,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Titulo de video',
                      labelText: 'Ingrese el titulo del video',
                      labelStyle: TextStyle(color: MaterialColors.mysecondary),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                    ),
                    validator: ((value) => (value))),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                    controller: _EnlaceVideoController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.link,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Link del video',
                      labelText: 'Ingrese el enlace web del video',
                      labelStyle: TextStyle(color: MaterialColors.mysecondary),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MaterialColors.mysecondary)),
                    ),
                    validator: ((value) => (value))),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: MaterialColors.mysecondary,
                        minimumSize: const Size(180.0, 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        bool resp = await CRUDServices().guardarDatapdf({
                          'nombre': _nombreVideoController.text,
                          'enlace': _EnlaceVideoController.text,
                        }, 'Video');
                        if (resp) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Video registrado'),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Algo salio mal'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Text('Guardar',
                          style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // key: _scaffoldKey,
    );
  }
}
