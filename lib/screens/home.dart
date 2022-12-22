import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import '../model/global_model.dart';
import '../services/crud_services.dart';
import '../widgets/card-small.dart';
import '../widgets/drawer.dart';

final Map<String, Map<String, String>> homeCards = {
  "Makeup": {
    "title": "Recicladoras de Base",
    "image": "assets/img/recicladorabtn.png",
    "price": "220"
  },
  "Coffee": {
    "title": "Puntos de Acopio",
    "image": "assets/img/Puntos de Acopio.png",
    "price": "40"
  },
  "eco": {
    "title": "Eco emprendimientos",
    "image": "assets/img/ecoemprendimiento.png",
    "price": "220"
  },
  "acerca": {
    "title": "Acerca de Redcicla",
    "image": "assets/img/REDcicla.png",
    "price": "40"
  }
};

class HomeInicio extends StatefulWidget {
  @override
  State<HomeInicio> createState() => _innicioless();
}

class _innicioless extends State<HomeInicio> {
  final textobuscarcontroller = TextEditingController();
  String buscargeneral = "";
  Stream<List<Globalmodel>> listaglobalstream;
  final _listacopioservice = CRUDServices();
  final user = FirebaseAuth.instance.currentUser;
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 50),
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "REDcicla",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              color: MaterialColors.myprimary,
              height: height + 55,
              width: MediaQuery.of(context).size.width,
            ),
            Container(),
            Positioned(
              top: 80.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: new Icon(Icons.menu, color: MaterialColors.myprimary, size: 40,),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                primary: false,
                title: TextField(
                    controller: textobuscarcontroller,
                    decoration: InputDecoration(
                        hintText: "Ingrese el nombre...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
                actions: <Widget>[
                  
                  IconButton(
                    
                    icon: Icon(Icons.search, color: MaterialColors.myprimary, size: 40,),
                  
                    onPressed: () {
                      setState(() {
                        buscargeneral = textobuscarcontroller.text;
                        listaglobalstream = _listacopioservice
                            .getglobalvaluesStream(buscargeneral);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );

  @override
  void dispose() {
    textobuscarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        drawer: MaterialDrawer(currentPage: "Home"),
        body: buscargeneral.length <= 0
            ? FutureBuilder(
                future: _listacopioservice.esValueRol(user.uid.toString()),
                builder: (context, snapshott) {
                  return (snapshott.hasData &&
                          snapshott.data.containsKey('rol'))
                      ? Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/img/iniciobanner.jpg'),
                                      height: 90,
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(height: 20.0),
                                Column(children: [
                                  Text(
                                    'Bienvenido',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshott.data['rol'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  )
                                ]),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["Makeup"]['title'],
                                        img: homeCards["Makeup"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/recicladora');
                                        }),
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["Coffee"]['title'],
                                        img: homeCards["Coffee"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/acopios');
                                        })
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["eco"]['title'],
                                        img: homeCards["eco"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/ecoempren');
                                        }),
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["acerca"]['title'],
                                        img: homeCards["acerca"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/acercade');
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/img/iniciobanner.jpg'),
                                  ),
                                ),
                                SizedBox(height: 50.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["Makeup"]['title'],
                                        img: homeCards["Makeup"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/recicladora');
                                        }),
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["Coffee"]['title'],
                                        img: homeCards["Coffee"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/acopios');
                                        })
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["eco"]['title'],
                                        img: homeCards["eco"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/ecoempren');
                                        }),
                                    CardSmall(
                                        cta: "View article",
                                        title: homeCards["acerca"]['title'],
                                        img: homeCards["acerca"]['image'],
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/acercade');
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                },
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<Globalmodel>>(
                        stream: listaglobalstream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var r = snapshot.data[index];

                                return TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(0, 255, 255, 255)),
                                    onPressed: () {},
                                    child: Card(
                                      color: MaterialColors.mysecondary,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: CircleAvatar(
                                                  child: Image(
                                                image: AssetImage(
                                                    'assets/img/REDcicla.png'),
                                              )),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  r.nombre,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  children: [Text(r.rol)],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      )
                    ],
                  ),
                ),
              ));
  }
}
