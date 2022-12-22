import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

class FormPDFs extends StatefulWidget {
  @override
  State<FormPDFs> createState() => _FormPDFsState();
}

class _FormPDFsState extends State<FormPDFs> {
  final TextEditingController _NombrePDFController = TextEditingController();
  final TextEditingController _EnlacePDFController = TextEditingController();

  final GlobalKey<FormState> _formPdf = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Añadir PDF"),
          backgroundColor: MaterialColors.myprimary,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // key: _scaffoldKey,
        body: formularioPdf(user.email.toString()));
  }

  Widget formularioPdf(String email) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formPdf,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nombrePdf(),
              SizedBox(
                height: 15.0,
              ),
              _enlacePdf(),
              SizedBox(
                height: 10.0,
              ),
              _registerButton(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nombrePdf() {
    return TextFormField(
        controller: _NombrePDFController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.account_circle,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Ingrese el título',
          labelText: 'Título del PDF',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorLlenarCampo(value)));
  }

  Widget _enlacePdf() {
    return TextFormField(
        controller: _EnlacePDFController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.article,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Ingrese el link web del PDF',
          labelText: 'Enlace del PDF',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorLlenarCampo(value)));
  }

  Widget _registerButton() {
    // var _em = email;
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: MaterialColors.mysecondary,
            minimumSize: const Size(180.0, 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () async {
            if (_formPdf.currentState.validate()) {
              bool resp = await CRUDServices().guardarDatapdf({
                'nombre': _NombrePDFController.text,
                'enlace': _EnlacePDFController.text,
              }, 'Pdf');
              if (resp) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('PDF registrado'),
                  backgroundColor: Colors.green,
                ));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Algo salio mal'),
                  backgroundColor: Colors.red,
                ));
              }
            }
          },
          child: Text('Guardar', style: TextStyle(color: Colors.white))),
    );
  }

  String _validatorLlenarCampo(String value) {
    if (!_minLength(value)) {
      return 'Por favor llene este campo';
    }
  }

  bool _minLength(String value) {
    return value.isNotEmpty && value.length >= 4;
  }
}
