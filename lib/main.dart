import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gridview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyGridView myGridView = new MyGridView();
  @override
  Widget build(BuildContext context) {
    final title = '\u00b7PLACES\u00b7';
    //00b7 - middle dot
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              style: TextStyle(
                color: Colors.yellow[600],
                fontFamily: 'Raleway Bold',
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: myGridView.build(context),

        //backgroundColor: Colors.teal,
      ),
    );
  }
}
