import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/widgets/drawer.dart';
import 'package:material_kit_flutter/widgets/navbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_kit_flutter/services/crud_services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class VideosRedciclaPage extends StatefulWidget {
  const VideosRedciclaPage({Key key}) : super(key: key);

  @override
  State<VideosRedciclaPage> createState() => _VideosRedciclaPageState();
}
class _VideosRedciclaPageState extends State<VideosRedciclaPage> {
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
                  width: 80.0,
                  height: 80.0,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                video['nombre'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
