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
    final title = 'LA Bucket List';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: myGridView.build(),

        //backgroundColor: Colors.teal,
      ),
    );
  }
}

Widget _itemList(int id) {
  return FlatButton(
    child: _createBody(id),
  );
}

Widget _createBody(int id) {
  return StreamBuilder(
      stream: Firestore.instance
          .collection('places')
          .document(id.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          if (doc.exists) {
            return Text(
              doc['content'],
              style: TextStyle(color: Colors.white),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      });
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second screen'),
      ),
      body: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new RaisedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.teal,
                ),
                label: Text('Back'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
