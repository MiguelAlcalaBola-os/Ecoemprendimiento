import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import "users_admin.dart";

class FormUser extends StatefulWidget {
  //RegisterRecicladora({Key key}) : super(key: key);

  @override
  State<FormUser> createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  final TextEditingController _nombreCompletoController =
      TextEditingController();
  final TextEditingController _ApellidoUsuarioController =
      TextEditingController();
  final TextEditingController _CorreoElectronicoController =
      TextEditingController();
  final TextEditingController _ContrasenaController = TextEditingController();
  final TextEditingController _ContrasenaRepetidaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Añadir Usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MaterialColors.myprimary,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pushNamed(context, '/useradmin');
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    controller: _nombreCompletoController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.account_circle,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Ingrese Nombre del usuario',
                      labelText: 'Nombre de usuario',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 136, 219, 182)),
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
                    controller: _ApellidoUsuarioController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.account_circle,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Ingrese el apellido del usuario',
                      labelText: 'Apellido de usuario',
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
                    controller: _CorreoElectronicoController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Ingrese el correo electronico',
                      labelText: 'correo@gmail.com',
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
                    controller: _ContrasenaController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Ingrese la contraseña del usuario',
                      labelText: 'Contraseña',
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
                    controller: _ContrasenaRepetidaController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: MaterialColors.mysecondary,
                      ),
                      helperText: 'Repita la contraseña anterior',
                      labelText: 'Repetir contraseña',
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
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/useradmin'),
                    child: Text("Guardar PDF"),
                  ),
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
