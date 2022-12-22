import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_kit_flutter/screens/registration_screen.dart';
import 'package:material_kit_flutter/screens/reset_password.dart';
import '../utils/color_utils.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class LoginScreenMain extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenMain> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String errorMessage;
  void signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage =
                "Su dirección de correo electrónico parece estar mal formada.";

            break;
          case "wrong-password":
            errorMessage = "Contraseña incorrecta";
            break;
          case "user-not-found":
            errorMessage =
                "El usuario(a) con este correo electrónico no existe.";
            break;
          case "user-disabled":
            errorMessage =
                "El usuario con este correo electrónico ha sido deshabilitado.";
            break;
          case "too-many-requests":
            errorMessage = "Demasiadas solicitudes";
            break;
          case "operation-not-allowed":
            errorMessage =
                "El inicio de sesión con correo electrónico y contraseña no está habilitado.";
            break;
          default:
            errorMessage = "Ocurrió un error indefinido.";
        }
        Fluttertoast.showToast(msg: errorMessage);
        print(error.code);
      }
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return ("Por favor ingresa tu correo electrónico");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor ingresa un correo válido");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo electrónico",
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        ));

    //password field

    final passwordField = TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            return ("La contraseña es requerida");
          } else if (!regex.hasMatch(value)) {
            return ("Ingresa una contraseña válida (Min. 6 caracteres)");
          }
        },
        onSaved: (value) {
          passwordController.text = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contraseña",
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 34, 180, 114),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Iniciar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final GoogleButton = Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          signInWithGoogle();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 11, 30, 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage("assets/img/google_access.png"),
                height: 18.0,
                width: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 8),
                child: Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );

    final FacebookButton = Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () async {
          User user = await Authenticator.iniciarSesion(context: context);
          print(user.displayName);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 11, 30, 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage("assets/img/facebook_logo.png"),
                height: 18.0,
                width: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 8),
                child: Text(
                  'Facebook',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("000000"),
          hexStringToColor("023020"),
          hexStringToColor("000000")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/img/acercabtn.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 45),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 35),
                      forgetPassword(context),
                      loginButton,
                      SizedBox(height: 15),
                      GoogleButton,
                      SizedBox(height: 15),
                      FacebookButton,
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Quieres ofrecer servicios de reciclaje?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            ),
                            //         ),

                            //       ]),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: Text(
                                " Registrate",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 34, 180, 114),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Olvidaste tu contraseña?",
          style: TextStyle(color: Color.fromARGB(179, 64, 239, 5)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}

class Authenticator {
  static Future<User> iniciarSesion({BuildContext context}) async {
    FirebaseAuth objAuthenticator = FirebaseAuth.instance;

    User user;

    FacebookLogin objFacebookSignIn = new FacebookLogin();

    FacebookLoginResult objFacebookSignInAccount =
        await objFacebookSignIn.logIn(customPermissions: ['email']);

    if (objFacebookSignInAccount != null) {
      FacebookAccessToken objAccessToken = objFacebookSignInAccount.accessToken;
      AuthCredential objCredential =
          FacebookAuthProvider.credential(objAccessToken.token);

      try {
        UserCredential objUserCredential =
            await FirebaseAuth.instance.signInWithCredential(objCredential);
        user = objUserCredential.user;

        return user;
      } on FirebaseAuthException catch (e) {
        print("Error en la autenticación");
      }
    }
  }
}
