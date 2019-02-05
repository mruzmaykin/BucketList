import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'LA Bucket List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: new GridView.builder(
          itemCount: 100,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              shape: CircleBorder(),
              child: new Container(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/pics/santamonica.jpg'),
                    fit:BoxFit.fill,
                  )
                ),
                child: new FlatButton(
                  child:  _createBody(index),
                //child: new Text('Santa Monica'), //just for testing, will fill with image later
                ),
               )
               );
          },
          ),
          
          //backgroundColor: Colors.teal,
      ),
    );
  }
}

Widget _itemList(int id){
  return FlatButton(
    child: _createBody(id),
  );
}
Widget _createBody(int id){
  return StreamBuilder(
    stream: Firestore.instance
    .collection('places')
    .document(id.toString())
    .snapshots(),
    builder: (context,snapshot){
      if (snapshot.hasData){
        var doc = snapshot.data; 
        if(doc.exists){
          return Text(doc['content'], style: TextStyle(color: Colors.white),);
        }
      }
      return Center(child:CircularProgressIndicator());
    });
}
