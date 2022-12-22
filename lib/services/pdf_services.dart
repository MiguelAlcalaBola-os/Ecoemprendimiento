import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/recicladora_model.dart';

class PdfServices {
  final firebaseRealTime = FirebaseDatabase.instance.ref();

  Future<List<Recicladora>> getPdf() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('recicladoras').get();

    List<Recicladora> recicladoras = [];

    snapshot.docs.forEach((doc) {
      recicladoras.add(Recicladora.fromSnapshot(doc));
    });
    return recicladoras;
  }

  // DatabaseReference dbRef;

  // void initState() {
  //   // initState();
  //   dbRef = FirebaseDatabase.instance.ref().child('Reciclador');
  // }

  Future<bool> guardarPdf(
      String nombrePdf,
      String enlacePdf) async {
    try {

      await FirebaseDatabase.instance.ref().child('Pdf').push().set({
        'nombre': nombrePdf,
        'enlace': enlacePdf
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
