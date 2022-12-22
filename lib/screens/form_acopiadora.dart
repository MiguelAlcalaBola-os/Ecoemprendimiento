import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/services/crud_services.dart';

class RegisterAcopiadora extends StatefulWidget {
  //RegisterRecicladora({Key key}) : super(key: key);

  @override
  State<RegisterAcopiadora> createState() => _RegisterAcopiadoraState();
}

class _RegisterAcopiadoraState extends State<RegisterAcopiadora> {
  final TextEditingController _nombreCompletoController =
      TextEditingController();
  final TextEditingController _numeroCelularController =
      TextEditingController();
  final TextEditingController _queResiduosController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _horarioAtencionController =
      TextEditingController();
  final TextEditingController _queDiasRecorreController =
      TextEditingController();
  final TextEditingController _detallesController = TextEditingController();

  final GlobalKey<FormState> _formAcopiadora = GlobalKey<FormState>();

  bool updatevalues = false;
  String comboCiudad;
  List _itemCiudades = [];
  String _comboZona;
  List _itemZonas = [];

  String hoy = DateTime.now().toString();
  final userFirebase = FirebaseAuth.instance.currentUser;
  final _listacopioservice = CRUDServices();
  Map departamentos;
  Future verifica() async {
    CRUDServices validador = new CRUDServices();
    var snapshott = await validador.esValueRol(userFirebase.uid.toString());
    if ((snapshott.containsKey('rol'))) {
      setState(() {
        updatevalues = true;
        comboCiudad = snapshott['ciudad'];
        _comboZona = snapshott['zona'];
        _nombreCompletoController.value =
            TextEditingValue(text: snapshott['nombre']);
        _numeroCelularController.value =
            TextEditingValue(text: snapshott['celular']);
        _horarioAtencionController.value =
            TextEditingValue(text: snapshott['horarios']);
        _queResiduosController.value =
            TextEditingValue(text: snapshott['querecibe']);
        _direccionController.value =
            TextEditingValue(text: snapshott['direccion']);
        _detallesController.value =
            TextEditingValue(text: snapshott['detalles']);
      });
    }
  }

  void initvalues() {
    _listacopioservice.getpaises('').then((value) {
      setState(() {
        departamentos = {...value};
        departamentos.forEach((key, value) {
          _itemCiudades.add(key);
        });
      });
    });
  }

  void setzonas() {
    _comboZona = null;
    _itemZonas = [];
    _itemZonas =
        comboCiudad != null && comboCiudad.isNotEmpty && comboCiudad != "Todas"
            ? departamentos[comboCiudad]
            : [];
  }

  @override
  initState() {
    super.initState();
    verifica();
    initvalues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !updatevalues
              ? Text(
                  'Añadir Punto de Acopio',
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  'Modificar servicio',
                  style: TextStyle(color: Colors.white),
                ),
          backgroundColor: MaterialColors.myprimary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              !updatevalues
                  ? Navigator.pushNamed(context, '/options')
                  : Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: formularioAcopiadora(
            userFirebase.email.toString(), userFirebase.uid.toString()));
  }

  Widget formularioAcopiadora(String email, String usuarioUid) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formAcopiadora,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nombreCompleto(),
              SizedBox(
                height: 15.0,
              ),
              _elegirCiudad(),
              SizedBox(
                height: 15.0,
              ),
              _elegirZona(),
              SizedBox(
                height: 10.0,
              ),
              _numCelular(),
              SizedBox(
                height: 10.0,
              ),
              _queResiduos(),
              SizedBox(
                height: 10.0,
              ),
              _direccion(),
              SizedBox(
                height: 10.0,
              ),
              _queHorarios(),
              SizedBox(
                height: 10.0,
              ),
              _queDetalles(),
              SizedBox(
                height: 25.0,
              ),
              updatevalues
                  ? _updateButton(usuarioUid)
                  : _registerButton(email, usuarioUid),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
        controller: _nombreCompletoController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.account_circle,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Nombre completo',
          labelText: 'Nombre del reciclador/a',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNombreCompleto(value)));
  }

  Widget _elegirCiudad() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 28.0),
          margin: EdgeInsets.only(left: 13.0, right: 0),
          child: DropdownButtonFormField(
            isExpanded: true,
            hint: Text(
              'Elegir ciudad',
              style: TextStyle(color: MaterialColors.mysecondary),
            ),
            items: _itemCiudades.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
            value: comboCiudad,
            onChanged: (value) {
              setState(() {
                comboCiudad = value;
                setzonas();
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 13.0,
          ),
          //margin: EdgeInsets.only(top: 80.0, left: 28.0),
          child: Icon(
            Icons.place,
            color: MaterialColors.mysecondary,
            size: 25.0,
          ),
        ),
      ],
    );
  }

  Widget _elegirZona() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 28.0),
          margin: EdgeInsets.only(left: 13.0, right: 0),
          child: DropdownButton(
            isExpanded: true,
            hint: Text(
              'Elegir zona',
              style: TextStyle(color: MaterialColors.mysecondary),
            ),
            items: _itemZonas.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
            value: _comboZona,
            onChanged: (value) {
              setState(() {
                _comboZona = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 13.0,
          ),
          //margin: EdgeInsets.only(top: 80.0, left: 28.0),
          child: Icon(
            Icons.location_city,
            color: MaterialColors.mysecondary,
            size: 25.0,
          ),
        ),
      ],
    );
  }

  Widget _numCelular() {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: _numeroCelularController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.phone_android,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Solo numeros, sin agregar +591',
          labelText: 'Nro. de celular',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNumCelular(value)));
  }

  Widget _queResiduos() {
    return TextFormField(
        controller: _queResiduosController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.article,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Los 3 residuos principales que acopia',
          labelText: 'Que residuos recibe?',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNombreCompleto(value)));
  }

  Widget _direccion() {
    return TextFormField(
        controller: _direccionController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.place,
            color: MaterialColors.mysecondary,
          ),
          //helperText: 'Las 2 calles principales que recorre',
          labelText: 'Escribe la direccion',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNombreCompleto(value)));
  }

  Widget _queHorarios() {
    return TextFormField(
        controller: _horarioAtencionController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.timer_outlined,
            color: MaterialColors.mysecondary,
          ),
          //helperText: 'De que hora a que hora?',
          labelText: 'Horarios de atención',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNombreCompleto(value)));
  }

  Widget _queDetalles() {
    return TextFormField(
        controller: _detallesController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.message,
            color: MaterialColors.mysecondary,
          ),
          helperText: 'Cualquier detalle que quieras agregar',
          labelText: 'Detalles o comentarios',
          labelStyle: TextStyle(color: MaterialColors.mysecondary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: MaterialColors.mysecondary)),
        ),
        validator: ((value) => _validatorNombreCompleto(value)));
  }

  Widget _registerButton(String email, String usuarioUid) {
    var _em = email;
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
            if (_formAcopiadora.currentState.validate()) {
              bool resp = await CRUDServices().guardarData({
                //AcopiadoraServices().guardarAcopiadora(
                //   'uidUser': 'ta6Jc7NOagbAlXmKtrYO1YH0kre2',
                //   'rol': 'Admin',
                // }, 'Usuarios');
                'nombre': _nombreCompletoController.text,
                'ciudad': comboCiudad,
                'zona': _comboZona,
                'fecha': hoy,
                'celular': _numeroCelularController.text,
                'horarios': _horarioAtencionController.text,
                'querecibe': _queResiduosController.text,
                'direccion': _direccionController.text,
                'detalles': _detallesController.text,
                'correo': _em,
                'rol': 'Acopiador',
                'uidUser': usuarioUid
              }, "registro/$usuarioUid"); //${_uidUser}
              if (resp) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Punto de Acopio registrado'),
                  backgroundColor: Colors.green,
                ));
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

  Widget _updateButton(String usuarioUid) {
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
            if (_formAcopiadora.currentState.validate()) {
              bool resp = await CRUDServices().modificarData({
                'nombre': _nombreCompletoController.text,
                'ciudad': comboCiudad,
                'zona': _comboZona,
                'fecha': hoy,
                'celular': _numeroCelularController.text,
                'horarios': _horarioAtencionController.text,
                'querecibe': _queResiduosController.text,
                'direccion': _direccionController.text,
                'detalles': _detallesController.text,
              }, "registro/$usuarioUid"); //${_uidUser}
              if (resp) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Se modifico los datos correctamente'),
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
          child: Text('Modificar', style: TextStyle(color: Colors.white))),
    );
  }

  String _validatorNombreCompleto(String value) {
    if (!_minLength(value)) {
      return 'Por favor llene este campo';
    }
  }

  String _validatorNumCelular(String value) {
    if (!_minLengthCelular(value)) {
      return 'Por favor ingresa solo 8 digitos de celular';
    }
  }

  bool _minLength(String value) {
    return value.isNotEmpty && value.length >= 4;
  }

  bool _minLengthCelular(String value) {
    return value.isNotEmpty && value.length == 8;
  }
}
