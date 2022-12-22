import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/dashboard/update_video.dart';
import 'package:material_kit_flutter/services/crud_services.dart';
import 'package:url_launcher/url_launcher.dart';
import "formvideos.dart";
import "getstarted.dart";

class VideosAdmin extends StatefulWidget {
  const VideosAdmin({Key key}) : super(key: key);

  @override
  State<VideosAdmin> createState() => _VideosAdmin();
}

class _VideosAdmin extends State<VideosAdmin> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Video');
  Widget listItem({Map video}) {
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
                  loadLink(video['enlace']);
                },
                child: Image(
                  image: AssetImage('assets/img/youtubeplay.png'),
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Text(
                video['nombre'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/UpdateVideo',
                      arguments: video['key']);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () async {
                  final resp =
                      await CRUDServices().deleteData('Video', video['key']);
                  if (resp) {
                    print('Eliminado');
                  } else {
                    print('Ocurrio un error');
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SpeedDial(
            backgroundColor: MaterialColors.myprimary,
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.add),
                  onTap: (() => Navigator.pushNamed(context, '/FormVideo')),
                  label: "Añadir Video",
                  backgroundColor: Colors.lightGreen),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
            backgroundColor: MaterialColors.myprimary,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Videos"),
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
            Map video = snapshot.value as Map;
            video['key'] = snapshot.key;

            return listItem(video: video);
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
