import 'package:firebase_database/firebase_database.dart';

class EcoemprendimientoServices {
  Future<bool> guardarEcoemprendimiento(
      String nombreCompleto,
      String comboCiudad,
      String comboZona,
      String hoy,
      String celular,
      String aqueDedican,
      String residuos,
      String direccion,
      String horarios,
      String nivel,
      String detalle,
      String em) async {
    try {
      await FirebaseDatabase.instance.ref().child('ecoemprendimientos').push().set({
        'nombre': nombreCompleto,
        'ciudad': comboCiudad,
        'zona': comboZona,
        'fecha': hoy,
        'descripcion':aqueDedican,
        'quenecesita':residuos,
        'direccion':direccion,
        'horarios':horarios,
        'capacidad':nivel,
        'detalles':detalle,
        'correo': em
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
