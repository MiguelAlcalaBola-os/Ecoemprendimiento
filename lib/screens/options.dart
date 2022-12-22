import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/Theme.dart';
import 'login_page.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({Key key}) : super(key: key);

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ofrecer servicios"),
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
                      child: Text('Registrar ',
                          style: TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 117, 117, 117))),
                    ),
                    Center(
                      child: Text('Servicio',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/formrecicladora');
                      },
                      child: Card(
                        color: Color.fromARGB(255, 239, 238, 238),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 130.0,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/img/Recicladoras de base 2.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Recicladora de Base',
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
                      onTap: () {
                        Navigator.pushNamed(context, '/formacopiadora');
                      },
                      child: Card(
                        color: Color.fromARGB(255, 239, 238, 238),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 130.0,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage('assets/img/Puntos de Acopio 2.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Punto de Acopio',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/formecoempren');
                      },
                      child: Card(
                        color: Color.fromARGB(255, 239, 238, 238),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 130.0,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/img/ecoemprendimiento 2.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Eco-empredimiento',
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
                      onTap: () {
                        logout(context);
                      },
                      child: Card(
                        color: Color.fromARGB(255, 239, 238, 238),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 120.0,
                              height: 130.0,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/img/cerrarsesion.png'),
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'Cerrar sesión',
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
            ),
          ),
        ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(
        msg: "Sesión cerrada",
        textColor: Color.fromARGB(255, 254, 249, 249),
        backgroundColor: Color.fromARGB(255, 83, 80, 80));

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreenMain()),
    );
  }
}
