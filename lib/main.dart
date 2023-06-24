

// pemboleh run utk semua dart file


import 'package:flutter/material.dart';
import '/login.dart';

import 'app.dart';

void main() => runApp(const ShrineApp());

class ShrineApp extends StatelessWidget{
  const ShrineApp({Key? key}) : super(key: key);

  Widget build(BuildContext context){

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
        backgroundColor: Colors.black38,
        body: LoginPage(),    //first start navigate to page
      )
    );
  }
}
