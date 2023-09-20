import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_art_technology/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final ControlerServices _controlerServices = ControlerServices();
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {

    _controlerServices.userCheck();
});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
