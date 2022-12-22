import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_kit_flutter/screens/acopios.dart';
import '../dashboard_styles/color.dart';
import '../dashboard_styles/typo.dart';
import 'package:flutter/material.dart';
import "../screens/form_acopiadora.dart";
import "../screens/form_ecoemprendimiento.dart";
import "../screens/form_recicladora.dart";
import './addcity.dart';
class GetStarted extends StatelessWidget {
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => LoginScreenMain()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.greenAccent,
        overlayColor: Colors.lightGreen,
        overlayOpacity: 0.6,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
           SpeedDialChild(
              child: Icon(Icons.add),
              label: "Agregar Ciudad",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCity()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.add),
              label: "Añadir Acopiadora",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterAcopiadora()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.add),
              label: "Añadir Ecoemprendimiento",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterEcoemprendimiento()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.add),
              label: "Añadir Recicladora",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterRecicladora()),
                );
              }),
        ],
      ),
      backgroundColor: softPurple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/img/REDcicla.png', height: 230),
            SizedBox(
              height: 10,
            ),
            Text(
              'Perfil del admin',
              style: header,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Aqui estan todos los campos que necesitas manejar y editar con la mejor tecnologia',
              style: paragraph,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() =>
                                    Navigator.pushNamed(context, '/pdfadmin')),
                                child: Image.asset('assets/img/pdf.png',
                                    height: 50),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'PDFs',
                                style: subHeader,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() =>
                                    Navigator.pushNamed(context, '/useradmin')),
                                child: Image.asset(
                                    'assets/img/profile-user.png',
                                    height: 50),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Usuarios',
                                style: subHeader,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() => Navigator.pushNamed(
                                    context, '/videoadmin')),
                                child: Image.asset('assets/img/youtubeplay.png',
                                    height: 50),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Videos',
                                style: subHeader,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() => logout()),
                                child: Image.asset(
                                    'assets/img/cerrar sesion.png',
                                    height: 50),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Cerrar sesión',
                                style: subHeader,
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
          ],
        ),
      ),
    );
  }
}
