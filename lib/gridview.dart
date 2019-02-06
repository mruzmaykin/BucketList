import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyGridView {
  Card getStructuredGridCell(id, image) {
    return new Card(
        elevation: 1.5,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new Image(image: AssetImage('assets/pics/santamonica.jpg')),
            new FlatButton(
              child: _createBody(id),
            )
          ],
        ));
  }

  GridView build() {
    return new GridView.builder(
      itemCount: 100,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            shape: CircleBorder(),
            child: new Container(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/pics/santamonica.jpg'),
                    fit: BoxFit.fill,
                  )),
              child: new FlatButton(
                child: _createBody(index),
                //child: new Text('Santa Monica'), //just for testing, will fill with image later
              ),
            ));
      },
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
}
