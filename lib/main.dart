import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard/form_pdf.dart';
import 'dashboard/formvideos.dart';
import 'dashboard/getstarted.dart';
import 'dashboard/pdfs_admin.dart';
import 'dashboard/update_pdf.dart';
import 'dashboard/update_video.dart';
import 'dashboard/users_admin.dart';
import 'dashboard/videos_admin.dart';
import 'screens/acercade.dart';
import 'screens/acopios.dart';
import 'screens/details_acopio.dart';
import 'screens/details_ecoprendedor.dart';
import 'screens/details_recicladora.dart';
import 'screens/emprendimiento.dart';
import 'screens/form_acopiadora.dart';
import 'screens/form_ecoemprendimiento.dart';
import 'screens/form_recicladora.dart';
import 'screens/home.dart';
import 'screens/login_page.dart';
import 'screens/normativas.dart';
import 'screens/onboarding.dart';
import 'screens/options.dart';
import 'screens/recicladorabase.dart';
import 'screens/videos.dart';
import 'services/crud_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CRUDServices validador = new CRUDServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/onboarding": (context) => Onboarding(),
          "/home": (context) => HomeInicio(),
          "/acopios": (context) => AcopioPage(),
          "/acercade": (context) => AcercaDePage(),
          "/videos": (context) => VideosRedciclaPage(),
          "/recicladora": (context) => RecicladoraBasePage(),
          "/ecoempren": (context) => EcoEmprendimientoPage(),
          "/normativas": (context) => NormativasRedciclaPage(),
          "/login": (context) => LoginScreenMain(),
          "/options": (context) => OptionsPage(),
          "/formrecicladora": (context) => RegisterRecicladora(),
          "/formacopiadora": (context) => RegisterAcopiadora(),
          "/formecoempren": (context) => RegisterEcoemprendimiento(),
          "/details": (context) => DetailsPage(),
          "/detailsAcopio": (context) => DetailsPageAcopio(),
          "/detailsEco": (context) => DetailsPageEco(),
          "/pdfadmin": (context) => PDFs(),
          "/formpdf": (context) => FormPDFs(),
          "/videoadmin": (context) => VideosAdmin(),
          "/UpdatePdf": (context) => UpdatePdf(),
          "/UpdateVideo": (context) => UpdateVideo(),
          "/FormVideo": (context) => FormVideo(),
          "/useradmin": (context) => Users()
        },
        title: "RedCiclapp",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshotlog) {
            if (snapshotlog.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshotlog.hasError) {
              return Center(child: Text("algo salio mal"));
            } else if (snapshotlog.hasData) {
              return FutureBuilder(
                future: validador.esValueRol(snapshotlog.data.uid),
                builder: (_, snapshott) {
                  if (snapshott.hasData) {
                    if (snapshott.data.containsKey('rol')) {
                      if (snapshott.data['rol'] == 'Admin')
                        return GetStarted();
                      else
                        return HomeInicio();
                    } else {
                      return HomeInicio();
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else {
              return LoginScreenMain();
            }
          },
        ));
  }
}
