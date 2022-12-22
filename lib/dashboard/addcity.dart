import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

class AddCity extends StatefulWidget {
  const AddCity({Key key}) : super(key: key);

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
   final TextEditingController _nombreCiudadController = TextEditingController();
  final TextEditingController _zonaCiudadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir ciudad"),
        backgroundColor: Colors.lightGreen,
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
                    controller: _nombreCiudadController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.music_video,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Nombre de la ciudad',
                      labelText: 'Ingrese el Nombre de una ciudad',
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
                    controller: _zonaCiudadController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.link,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Zona de la ciudad',
                      labelText: 'Ingrese la zona de una ciudad',
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
                         'Zona': _zonaCiudadController.text,
                        'Ciudad': _nombreCiudadController.text
                       
                        }, "Ciudades/"+_nombreCiudadController.text);
                        if (resp) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Ciudad y zona registrada'),
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

