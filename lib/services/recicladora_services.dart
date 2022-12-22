import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/recicladora_model.dart';

class RecicladoraServices {
  final firebaseRealTime = FirebaseDatabase.instance.ref();

  Future<List<Recicladora>> getRecicladora() async {
    var snapshot = await firebaseRealTime
        .child('recicladoras')
        .get(); //FirebaseFirestore.instance.collection('recicladoras').get();

    List<Recicladora> recicladoras = [];
    print(snapshot.value);
    //Map recicla = snapshot.value as Map;
    // recicla.forEach((key, value) {
    //   recicladoras.add(Recicladora());
    // });
    // snapshot.docs.forEach((doc) {
    //   recicladoras.add(Recicladora.fromSnapshot(doc));
    // });
    //print(recicladoras);
    return recicladoras;
  }

  // DatabaseReference dbRef;

  // void initState() {
  //   // initState();
  //   dbRef = FirebaseDatabase.instance.ref().child('Reciclador');
  // }

  Future<bool> guardarRecicladoras(
      String nombreCompleto,
      String comboCiudad,
      String comboZona,
      String hoy,
      String celular,
      String horarios,
      String residuos,
      String ruta,
      String dias,
      String detalle,
      String em) async {
    try {
      await FirebaseDatabase.instance.ref().child('recicladoras').push().set({
        'nombre': nombreCompleto,
        'departamento': comboCiudad,
        'zona': comboZona,
        'fecha': hoy,
        'celular': celular,
        'horarios': horarios,
        'recolecta': residuos,
        'ruta': ruta,
        'dias': dias,
        'correo': em,
        'detalle': detalle
      });

      // await Map<String, String> reciclador = {
      //   'nombre': nombreCompleto,
      //   'departamento': comboCiudad,
      //   'zona': comboZona,
      //   'fecha': hoy,
      //   'celular': celular,
      //   'horarios': horarios,
      //   'recolecta': residuos,
      //   'ruta': ruta,
      //   'dias': dias,
      //   'correo': em,
      //   'detalle': detalle
      // };
      // print(reciclador);
      // dbRef.push().set(reciclador);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
