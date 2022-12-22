import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import '../services/crud_services.dart';
import 'drawer-tile.dart';

class MaterialDrawer extends StatelessWidget {
  final String currentPage;
  final user = FirebaseAuth.instance.currentUser;
  CRUDServices validador = new CRUDServices();
  MaterialDrawer({this.currentPage});
  Future salir(context) async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(
        msg: "Sesión cerrada",
        textColor: Color.fromARGB(255, 254, 249, 249),
        backgroundColor: Color.fromARGB(255, 83, 80, 80));
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => LoginScreenMain()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 10, 126, 74)),
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: user?.photoURL.toString() != 'null'
                            ? NetworkImage(user.photoURL.toString())
                            : AssetImage('assets/img/profile-user.png'),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      // _nameUser(context)

                      Column(children: [
                        Text(
                          user?.email.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (user?.displayName.toString() != 'null')
                          Text(
                            user?.displayName.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                      ])
                    ],
                  ),
                )
              ],
            ))),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (currentPage != "Home") Navigator.pop(context);
                },
                iconColor: MaterialColors.mysecondary,
                title: "Inicio",
                isSelected: currentPage == "Home" ? true : false),
            FutureBuilder(
              future: validador.esValueRol(user.uid.toString()),
              builder: (_, snapshott) {
                if (snapshott.hasData && snapshott.data.containsKey('rol')) {
                  return DrawerTile(
                    icon: Icons.handyman,
                    onTap: () {
                      switch (snapshott.data['rol']) {
                        case 'acopiador':
                          Navigator.pushNamed(context, '/formacopiadora');
                          break;
                        case 'ecoemprendedor':
                          Navigator.pushNamed(context, '/formecoempren');
                          break;
                        case 'reciclador':
                          Navigator.pushNamed(context, '/formrecicladora');
                          break;
                      }
                    },
                    iconColor: MaterialColors.mysecondary,
                    title: "Edita tu servicio",
                    //isSelected: currentPage == "Root" ? true : false
                  );
                } else {
                  return DrawerTile(
                    icon: Icons.handyman,
                    onTap: () {
                      //if (currentPage != "Root")
                      Navigator.pushNamed(context, '/options');
                    },
                    iconColor: MaterialColors.mysecondary,
                    title: "Registrar Servicio",
                    //isSelected: currentPage == "Root" ? true : false
                  );
                }
              },
            ),
            DrawerTile(
              icon: Icons.book,
              onTap: () {
                Navigator.pushNamed(context, '/normativas');
              },
              iconColor: MaterialColors.mysecondary,
              title: "Normativa ambiental",
            ),
            DrawerTile(
              icon: Icons.info_outline_rounded,
              onTap: () {
                Navigator.pushNamed(context, '/acercade');
              },
              iconColor: MaterialColors.mysecondary,
              title: "Acerca de Redcicla",
            ),
            DrawerTile(
              icon: Icons.logout,
              onTap: () {
                salir(context);
              },
              iconColor: MaterialColors.mysecondary,
              title: "Cerrar sesión",
            ),
          ],
        ))
      ])),
    );
  }
}
