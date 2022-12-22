// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/dashboard/update_pdf.dart';
import 'package:material_kit_flutter/services/crud_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../constants/Theme.dart';

//AQUI ESTAN LOS PDF
class NormativasRedciclaPage extends StatefulWidget {
  const NormativasRedciclaPage({Key key}) : super(key: key);

  @override
  State<NormativasRedciclaPage> createState() => _NormativasRedciclaPageState();
}

class _NormativasRedciclaPageState extends State<NormativasRedciclaPage> {
  Query dbRef = FirebaseDatabase.instance.ref('Pdf');
  // DatabaseReference reference = FirebaseDatabase.instance.ref().child('Pdf');

  Widget listItem({Map pdf}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Color.fromARGB(255, 219, 219, 219),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            
            children: [
              
              GestureDetector(
                onTap: () async {
                  loadLink(pdf['enlace']);
                },
                child: Image(
                  image: AssetImage('assets/img/pdf.png'),
                  width: 80.0,
                  height: 80.0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                pdf['nombre'],
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
        backgroundColor: MaterialColors.myprimary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        title: const Text("PDFs"),
        backgroundColor: MaterialColors.myprimary,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // key: _scaffoldKey,

      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            print(snapshot.value);
            Map pdf = snapshot.value as Map;
            pdf['key'] = snapshot.key;

            return listItem(pdf: pdf);
          },
        ),
      ),
    );
  }

  Future<void> loadLink(enlace) async {
    if (!await launchUrl(
      Uri.parse(enlace),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'No se pudo cargar en enlace: $enlace';
    }
  }
}
