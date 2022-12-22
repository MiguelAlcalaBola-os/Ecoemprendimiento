import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:material_kit_flutter/constants/Theme.dart';

import 'login_page.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreenMain()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/img/on_recicladoras.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    const pageDecorationtwo = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 0.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          footer: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MaterialColors.mysecondary,
                  minimumSize: const Size(180.0, 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                child: const Text(
                  'Iniciar',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                onPressed: () => _onIntroEnd(context),
              ),
            ],
          ),
          title: "",
          body:
              "REDcicla es una iniciativa ciudadana que busca fortalecer la cadena de valor en la gestion de residuos solidos, conectado a todos los actores que forman parte de ella.",
          image: _buildImage('assets/img/on_banner.jpg'),
          decoration: pageDecorationtwo,
        ),
        PageViewModel(
          title: "Recicladoras de base",
          body:
              "Impulsamos el reciclaje inclusivo, desde la valoracion y visibilizacion del aporte que realizan las recicladoras de base en la gestion y aprovechamiento de residuos solidos.",
          image: _buildImage('assets/img/on_recicladoras.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ecoemprendimientos",
          body:
              "Valoramos y apoyamos a negocios y empresas con un enfoque responsable hacia nuestro entorno y la mdre tierra.",
          image: _buildImage('assets/img/on_ecoemprendimientos.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Centros de Acopio",
          body:
              "Centralizamos informacion en formato abierto apra que cada vez mas personas seamos parte del ciclo de reciclaje.",
          image: _buildImage('assets/img/on_acopio.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Únete al ciclo",
          body:
              "Únete al ciclo de reciclaje para cuidar nuestro planeta, si cuidamos la tierra, la tierra nos cuidará.",
          image: _buildImage('assets/img/ciclo.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Text('Atras', style: TextStyle(fontWeight: FontWeight.w600)),
      skip: const Text('Saltar', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Text('Continuar',
          style: TextStyle(fontWeight: FontWeight.w600)),
      done:
          const Text('Empezar', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: const Color.fromARGB(255, 20, 91, 59),
        color: MaterialColors.mysecondary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
