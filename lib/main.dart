import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'gridview.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future <void> main() async{
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'buckelist',
    options: FirebaseOptions(
      googleAppID: Platform.isIOS
          ? '1:395446126031:ios:77bc6f793e32d551'
          : '1:395446126031:android:6eeb145bfa97d11a',
      gcmSenderID: '395446126031',
      apiKey: 'AIzaSyA3YW1gzFqTv_xJPYb6vOJLVA4YguOVyFE',
      projectID: 'bucketlist-e3df2',
    ),
  );
  final Firestore firestore = Firestore(app:app);
 
  final FirebaseStorage storage = FirebaseStorage(
      app: app, storageBucket: 'gs://bucketlist-e3df2.appspot.com');
  runApp(MyApp(firestore:firestore, storage:storage));
}

class MyApp extends StatelessWidget {
  MyApp({this.firestore, this.storage});
  final Firestore firestore;
  final FirebaseStorage storage;
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
                fontSize: 25,
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
