import 'package:cloud_firestore/cloud_firestore.dart';

class Recicladora {
  String key;
  String nombre;
  String departamento;
  String zona;
  String celular;
  String correo;
  String dias;
  String horarios;
  String recolecta;
  String ruta;
  String detalle;
  DocumentReference reference;

  Recicladora(
      this.nombre,
      this.key,
      this.departamento,
      this.zona,
      this.celular,
      this.correo,
      this.dias,
      this.horarios,
      this.recolecta,
      this.ruta,
      this.detalle);

  Recicladora.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data.call(), reference: snapshot.reference);

  Recicladora.fromMap(Map<String, dynamic> map, {this.reference})
      : nombre = map['nombre'],
        key = map['key'],
        departamento = map['departamento'],
        zona = map['zona'],
        celular = map['celular'],
        correo = map['correo'],
        dias = map['dias'],
        horarios = map['horarios'],
        recolecta = map['recolecta'],
        ruta = map['ruta'],
        detalle = map['detalle'];
}
