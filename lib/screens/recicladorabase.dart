import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/model/recicladora_model.dart';

import '../services/crud_services.dart';

class RecicladoraBasePage extends StatefulWidget {
  const RecicladoraBasePage({Key key}) : super(key: key);

  @override
  State<RecicladoraBasePage> createState() => _RecicladoraBasePageState();
}

class _RecicladoraBasePageState extends State<RecicladoraBasePage> {
  String comboCiudad;
  List _itemCiudades = [];
  String _comboZona;
  List itemZonas = [];

  TextEditingController searchController = TextEditingController();
  final _listacopioservice = CRUDServices();
  Map departamentos;

  Stream<List<Recicladora>> listareciclador;
  void initvalues() {
    listareciclador = _listacopioservice.getRecicladoraStream('', '', '');
    _listacopioservice.getpaises('').then((value) {
      setState(() {
        departamentos = {...value};
        _itemCiudades.add('Todas');
        departamentos.forEach((key, value) {
          _itemCiudades.add(key);
        });
      });
    });
  }

  void setzonas() {
    _comboZona = null;
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
        title: const Text("Recicladoras de Base"),
        backgroundColor: MaterialColors.myprimary,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image(
                  image: AssetImage('assets/img/Recicladoras de base 2.png'),
                  height: 130,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Recicladoras de Base',
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
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Buscar por nombre o zona",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    listareciclador =
                                        _listacopioservice.getRecicladoraStream(
                                            searchController.text,
                                            comboCiudad,
                                            _comboZona);
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
              /* Expanded(
                child: recicler(),
              ),  */
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
                        icon: Icon(Icons.arrow_drop_down,
                            color: MaterialColors.mysecondary),
                        isExpanded: true,
                        hint: Text('Elegir ciudad'),
                        value: comboCiudad,
                        onChanged: (newValue) {
                          setState(() {
                            comboCiudad = newValue;
                            setzonas();
                            listareciclador =
                                _listacopioservice.getRecicladoraStream(
                                    searchController.text,
                                    comboCiudad,
                                    _comboZona);
                          });
                        },
                        items: _itemCiudades.map((valueItem) {
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
                        hint: Text('Elegir zona'),
                        value: _comboZona,
                        onChanged: (newValue) {
                          setState(() {
                            _comboZona = newValue;
                            listareciclador =
                                _listacopioservice.getRecicladoraStream(
                                    searchController.text,
                                    comboCiudad,
                                    _comboZona);
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
                      StreamBuilder<List<Recicladora>>(
                        stream: listareciclador,
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
                                      Navigator.pushNamed(context, '/details',
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
                                                    'assets/img/recicladorabtn.png'),
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
                                                      r.departamento + " - ",
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
