import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';

import '../model/acopio_model.dart';
import '../services/crud_services.dart';

class AcopioPage extends StatefulWidget {
  const AcopioPage({Key key}) : super(key: key);

  @override
  State<AcopioPage> createState() => _AcopioPageState();
}

class _AcopioPageState extends State<AcopioPage> {
  String comboCiudad;
  List itemCiudades = [];
  String comboZona;
  List itemZonas = [];
  TextEditingController searchController = TextEditingController();
  final _listacopioservice = CRUDServices();
  Map departamentos;
  Stream<List<Acopio>> listaparaacopio;

  void initvalues() {
    listaparaacopio = _listacopioservice.getAcopioStream('', '', '');
    _listacopioservice.getpaises('').then((value) {
      setState(() {
        departamentos = {...value};
        itemCiudades.add('Todas');
        departamentos.forEach((key, value) {
          itemCiudades.add(key);
        });
      });
    });
  }

  void setzonas() {
    comboZona = null;
    itemZonas = [];
    itemZonas =
        comboCiudad != null && comboCiudad.isNotEmpty && comboCiudad != "Todas"
            ? departamentos[comboCiudad]
            : [];
  }

  @override
  void initState() {
    super.initState();
    initvalues();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Puntos de Acopio"),
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
                  image: AssetImage('assets/img/Puntos de Acopio 2.png'),
                  height: 130,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Puntos de Acopio',
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
                    child: Container(
                        width: 280,
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 0, 0, 0), width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Buscar",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    listaparaacopio =
                                        _listacopioservice.getAcopioStream(
                                            searchController.text,
                                            comboCiudad,
                                            comboZona);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                },
                              ),
                              hintStyle: TextStyle(fontSize: 16.0)),
                        )),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 280,
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MaterialColors.mysecondary, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: MaterialColors.mysecondary,
                        ),
                        isExpanded: true,
                        hint: Text('Elegir ciudad'),
                        value: comboCiudad,
                        onChanged: (newValue) {
                          setState(() {
                            comboCiudad = newValue;
                            setzonas();
                            listaparaacopio =
                                _listacopioservice.getAcopioStream(
                                    searchController.text,
                                    comboCiudad,
                                    comboZona);
                          });
                        },
                        items: itemCiudades.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 280,
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MaterialColors.mysecondary, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: MaterialColors.mysecondary,
                        ),
                        isExpanded: true,
                        hint: Text('Elegir una zona'),
                        value: comboZona,
                        onChanged: (newValue) {
                          setState(() {
                            comboZona = newValue;
                            listaparaacopio =
                                _listacopioservice.getAcopioStream(
                                    searchController.text,
                                    comboCiudad,
                                    comboZona);
                          });
                        },
                        items: itemZonas.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<Acopio>>(
                        stream: listaparaacopio,
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
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/detailsAcopio',
                                          arguments: r);
                                    },
                                    child: Card(
                                      color: Color.fromARGB(255, 211, 211, 211),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: CircleAvatar(
                                                  child: Image(
                                                image: AssetImage(
                                                    'assets/img/Puntos de Acopio.png'),
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
                                                      color: Color.fromARGB(255, 47, 47, 47)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      r.ciudad + " - ",
                                                    ),
                                                    Text(r.zona)
                                                  ],
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
              )
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
}
