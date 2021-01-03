import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikipedia_search/route/route_constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () => Navigator
        .pushNamedAndRemoveUntil(context, searchResult, (route) => false));

    return SafeArea(child: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text("Wiki Search",
        style: TextStyle(
          fontSize: 28,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.black87
        ),),
      ),
    ));
  }
}
