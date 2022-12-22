import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import '../model/global_model.dart';
import '../services/crud_services.dart';

class Users extends StatefulWidget {
  const Users({Key key}) : super(key: key);
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Stream<List<Globalmodel>> listaglobalstream;
  final _listacopioservice = CRUDServices();
  void initvalues() {
    listaglobalstream = _listacopioservice.getglobalvaluesStream('');
  }

  @override
  void initState() {
    super.initState();
    initvalues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          backgroundColor: MaterialColors.myprimary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        appBar: AppBar(
          title: const Text("Lista de usuarios"),
          backgroundColor: MaterialColors.myprimary,
        ),
        body: Column(
          children: [
            StreamBuilder<List<Globalmodel>>(
              stream: listaglobalstream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = snapshot.data[index];
                    
                      return ListTile(
                        
                        iconColor: Colors.red,
                        title: Text(item.nombre + " - " + item.rol),
                        trailing: Icon(Icons.delete),
                        onTap: () async {
                  final resp =
                      await CRUDServices().deleteData('registro', item);
                  if (resp) {
                    print('Eliminado');
                  } else {
                    print('Ocurrio un error');
                  }
                },
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
             
        ));
  }
}
