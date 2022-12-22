import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaDePage extends StatefulWidget {
  const AcercaDePage({Key key}) : super(key: key);

  @override
  State<AcercaDePage> createState() => _AcercaDePageState();
}

class _AcercaDePageState extends State<AcercaDePage> {
  final Uri _launchUrlFacebook = Uri.parse(
      "https://m.facebook.com/REDcicla-Bolivia-Reciclaje-Inclusivo-117748492970580/");
  final Uri _launchUrlFacebookGroup =
      Uri.parse("https://www.facebook.com/groups/2245402859114896");
  final Uri _launchUrlYoutube =
      Uri.parse("https://www.youtube.com/channel/UCPirO3q2m8qI3Q8GkFTUOog");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de Redcicla"),
        backgroundColor: MaterialColors.myprimary,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image(
                  image: AssetImage('assets/img/iniciobanner.jpg'),
                  height: 70,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Acerca de Redcicla',
                        style: TextStyle(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 117, 117, 117))),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MaterialColors.mysecondary,
                          minimumSize: const Size(280.0, 60.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Normativa',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/normativas');
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MaterialColors.mysecondary,
                          minimumSize: const Size(280.0, 60.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Videos',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/videos');
                        },
                      ),
                      SizedBox(height: 20.0),
                      Card(
                        color: Color.fromARGB(255, 239, 238, 238),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 280.0,
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Redcicla Bolivia se funda el 17 de mayo de 2017 y es una iniciativa ciudadana que funciona como una plataforma en red, que busca conectar a diferentes actores de la cadena de valor en torno al reciclaje. Priorizando y visibilizando el papel importa del reciclaje inclusivo, para generar una gestion integral de residuos.',
                                style: TextStyle(fontSize: 12.0),
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _launchUrlFacebookExec,
                            child: Card(
                              color: Color.fromARGB(255, 239, 238, 238),
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 100.0,
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/img/facebook.png'),
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Pagina de Facebook',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          GestureDetector(
                            onTap: _launchUrlFacebookGExec,
                            child: Card(
                              color: Color.fromARGB(255, 239, 238, 238),
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 100.0,
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/img/groupface.png'),
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Grupo de Facebook',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _launchUrlYoutubeExec,
                            child: Card(
                              color: Color.fromARGB(255, 239, 238, 238),
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 100.0,
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/img/youtube.png'),
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Canal de Youtube',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          GestureDetector(
                            onTap: _launchUrlCorreoExec,
                            child: Card(
                              color: Color.fromARGB(255, 239, 238, 238),
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 100.0,
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/img/gmail.png'),
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        Text(
                                          'Correo electronico',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
        backgroundColor: MaterialColors.myprimary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _launchUrlFacebookExec() async {
    if (!await launchUrl(
      _launchUrlFacebook,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_launchUrlFacebook';
    }
  }

  Future<void> _launchUrlFacebookGExec() async {
    if (!await launchUrl(
      _launchUrlFacebookGroup,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_launchUrlFacebookGroup';
    }
  }

  Future<void> _launchUrlYoutubeExec() async {
    if (!await launchUrl(
      _launchUrlYoutube,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_launchUrlYoutube';
    }
  }

  Future<void> _launchUrlCorreoExec() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'redciclabolivia@gmail.com',
        queryParameters: {'subject': '', 'body': ''});

    String url = params.toString();
    final Uri _launchUrlCorreo = Uri.parse(url);

    if (!await launchUrl(
      _launchUrlCorreo,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_launchUrlCorreo';
    }
  }
}
