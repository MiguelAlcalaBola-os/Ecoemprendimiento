import 'package:firebase_database/firebase_database.dart';
import '../model/acopio_model.dart';
import '../model/eco_model.dart';
import '../model/global_model.dart';
import '../model/recicladora_model.dart';
import 'package:flutter/material.dart';

class CRUDServices {
  final firebaseRealTime = FirebaseDatabase.instance.ref();
  // Future<List<Recicladora>> getPdf() async {
  //   var snapshot =
  //       await FirebaseFirestore.instance.collection('recicladoras').get();

  //   List<Recicladora> recicladoras = [];

  //   snapshot.docs.forEach((doc) {
  //     recicladoras.add(Recicladora.fromSnapshot(doc));
  //   });
  //   return recicladoras;
  // }

  Future<bool> guardarData(Object data, String table) async {
    try {
      await FirebaseDatabase.instance.ref('$table').set(data);
      // final snapshot2 =
      //     await FirebaseDatabase.instance.ref().child('$table').get();
      // if (snapshot2.exists) {
      //   _rol.setvalues(snapshot2.value);
      // }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> guardarDatapdf(Object data, String table) async {
    try {
      await FirebaseDatabase.instance.ref('$table').push().set(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> modificarData(Object data, String table) async {
    try {
      await FirebaseDatabase.instance.ref('$table').update(data);
      // final snapshot2 =
      //     await FirebaseDatabase.instance.ref().child('$table').get();
      // if (snapshot2.exists) {
      //   _rol.setvalues(snapshot2.value);
      // }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateData(
      BuildContext context, Object data, String table, key) async {
    try {
      await FirebaseDatabase.instance
          .ref()
          .child(table)
          .child(key)
          .update(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getOneData(String table, key) async {
    try {
      DataSnapshot snapshot =
          await FirebaseDatabase.instance.ref().child(table).child(key).get();
      Map dataMap = snapshot.value as Map;
      return dataMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<bool> deleteData(String table, key) async {
    try {
      await FirebaseDatabase.instance.ref().child(table).child(key).remove();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Query> getAllData(String table) async {
    try {
      Query dbRef = FirebaseDatabase.instance.ref().child(table);

      return dbRef;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Recicladora>> getRecicladora() async {
    DatabaseEvent event =
        await FirebaseDatabase.instance.ref('registro').once();
    Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;

    List<Recicladora> recicladoras = [];
    dataMap?.forEach((key, value) {
      if (value['rol'] == 'reciclador') {
        recicladoras.add(new Recicladora(
            value['nombre'],
            value['uidUser'],
            value['departamento'],
            value['zona'],
            value['celular'],
            value['correo'],
            value['dias'],
            value['horarios'],
            value['recolecta'],
            value['ruta'],
            value['detalles']));
      }
    });
    return recicladoras;
  }

  Stream<List<Globalmodel>> getglobalvaluesStream(String nom) async* {
    List<Globalmodel> recicladoras = [];
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro').once();
      Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;
      dataMap?.forEach((key, value) {
        if (value['rol'] != 'Admin') {
          recicladoras.add(new Globalmodel(value['nombre'], value['rol']));
        }
      });

      if (nom != null && nom.isNotEmpty) {
        recicladoras.removeWhere(
            (value) => !value.nombre.toLowerCase().contains(nom.toLowerCase()));
      }
      yield recicladoras;
    } catch (e) {
      print('------------------------eeeeee---------------------------');
      print(e);
      yield recicladoras;
    }
  }

  Stream<List<Recicladora>> getRecicladoraStream(
      String nom, String ciudad, String zona) async* {
    List<Recicladora> recicladoras = [];
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro').once();
      Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;
      dataMap?.forEach((key, value) {
        if (value['rol'] == 'reciclador') {
          recicladoras.add(new Recicladora(
              value['nombre'],
              value['uidUser'],
              value['departamento'],
              value['zona'],
              value['celular'],
              value['correo'],
              value['dias'],
              value['horarios'],
              value['recolecta'],
              value['ruta'],
              value['detalles']));
        }
      });
      if (nom != null && nom.isNotEmpty) {
        recicladoras.removeWhere(
            (value) => !value.nombre.toLowerCase().contains(nom.toLowerCase()));
      }
      if (ciudad != null && ciudad.isNotEmpty && ciudad != "Todas") {
        recicladoras.removeWhere((value) =>
            !value.departamento.toLowerCase().contains(ciudad.toLowerCase()));
      }
      if (zona != null && zona.isNotEmpty && zona != "Todas") {
        recicladoras.removeWhere(
            (value) => !value.zona.toLowerCase().contains(zona.toLowerCase()));
      }

      yield recicladoras;
    } catch (e) {
      print('------------------------eeeeee---------------------------');
      print(e);
      yield recicladoras;
    }
  }

  Future<List<Acopio>> getAcopio() async {
    List<Acopio> recicladoras = [];
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro').once();
      Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;

      dataMap?.forEach((key, value) {
        if (value['rol'] == 'acopiador') {
          recicladoras.add(new Acopio(
              value['nombre'],
              value['uidUser'],
              value['ciudad'],
              value['zona'],
              value['celular'],
              value['correo'],
              value['horarios'],
              value['direccion'],
              value['querecibe'],
              value['detalles']));
        }
      });
      return recicladoras;
    } catch (e) {
      return recicladoras;
    }
  }

  Stream<List<Acopio>> getAcopioStream(
      String nom, String ciudad, String zona) async* {
    List<Acopio> recicladoras = [];
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro').once();
      Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;

      dataMap?.forEach((key, value) {
        if (value['rol'] == 'acopiador') {
          recicladoras.add(new Acopio(
              value['nombre'],
              value['uidUser'],
              value['ciudad'],
              value['zona'],
              value['celular'],
              value['correo'],
              value['horarios'],
              value['direccion'],
              value['querecibe'],
              value['detalles']));
        }
      });
      if (nom != null && nom.isNotEmpty) {
        recicladoras.removeWhere(
            (value) => !value.nombre.toLowerCase().contains(nom.toLowerCase()));
      }
      if (ciudad != null && ciudad.isNotEmpty && ciudad != "Todas") {
        recicladoras.removeWhere((value) =>
            !value.ciudad.toLowerCase().contains(ciudad.toLowerCase()));
      }
      if (zona != null && zona.isNotEmpty && zona != "Todas") {
        recicladoras.removeWhere(
            (value) => !value.zona.toLowerCase().contains(zona.toLowerCase()));
      }

      yield recicladoras;
    } catch (e) {
      print('------------------------eeeeee---------------------------');
      print(e);
      yield recicladoras;
    }
  }

  Future<List<Ecoemprendedor>> ecoemprendedor() async {
    DatabaseEvent event =
        await FirebaseDatabase.instance.ref('registro').once();
    Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;
    List<Ecoemprendedor> recicladoras = [];
    dataMap?.forEach((key, value) {
      if (value['rol'] == 'ecoemprendedor') {
        recicladoras.add(new Ecoemprendedor(
            value['nombre'],
            value['uidUser'],
            value['ciudad'],
            value['zona'],
            value['celular'],
            value['correo'],
            value['quenecesita'],
            value['horarios'],
            value['capacidad'],
            value['detalles'],
            value['direccion'],
            value['descripcion']));
      }
    });
    return recicladoras;
  }

  Stream<List<Ecoemprendedor>> ecoemprendedorStream(
      String nom, String ciudad, String zona) async* {
    List<Ecoemprendedor> ecoemprendedor = [];
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro').once();
      Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;
      dataMap?.forEach((key, value) {
        if (value['rol'] == 'ecoemprendedor') {
          ecoemprendedor.add(new Ecoemprendedor(
              value['nombre'],
              value['uidUser'],
              value['ciudad'],
              value['zona'],
              value['celular'],
              value['correo'],
              value['quenecesita'],
              value['horarios'],
              value['capacidad'],
              value['detalles'],
              value['direccion'],
              value['descripcion']));
        }
      });
      if (nom != null && nom.isNotEmpty) {
        ecoemprendedor.removeWhere(
            (value) => !value.nombre.toLowerCase().contains(nom.toLowerCase()));
      }
      if (ciudad != null && ciudad.isNotEmpty && ciudad != "Todas") {
        ecoemprendedor.removeWhere((value) =>
            !value.ciudad.toLowerCase().contains(ciudad.toLowerCase()));
      }
      if (zona != null && zona.isNotEmpty && zona != "Todas") {
        ecoemprendedor.removeWhere(
            (value) => !value.zona.toLowerCase().contains(zona.toLowerCase()));
      }
      yield ecoemprendedor;
    } catch (e) {
      print('------------------------eeeeee---------------------------');
      print(e);
      yield ecoemprendedor;
    }
  }

  Stream<Map> esValueRolStream(String userUid) async* {
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro/$userUid').once();
      yield event.snapshot.exists ? event.snapshot.value : {};
    } catch (e) {
      yield {};
    }
  }

  Future esValueRol(String userUid) async {
    try {
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref('registro/$userUid').once();
      return event.snapshot.exists ? event.snapshot.value : {};
    } catch (e) {
      return {};
    }
  }

  Future<Map> getpaises(String dep) async {
    DatabaseEvent event = await FirebaseDatabase.instance.ref('bolivia').once();
    Map dataMap = (event.snapshot.exists ? event.snapshot.value : {}) as Map;
    // if (dep != null && dep.isNotEmpty && dep != "Todas") {
    //     dataMap.removeWhere((key, value) => !key.toLowerCase().contains(dep.toLowerCase()));
    //   }
    return dataMap;
  }
}
