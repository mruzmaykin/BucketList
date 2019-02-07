import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyGridView {
  Card getStructuredGridCell(id) {
    return new Card(
      elevation: 1.5,
      child: new Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(),
            image: DecorationImage(
              image: AssetImage('assets/pics/' + id.toString()+".jpg"),
              fit: BoxFit.fill,
            )),
            child: FlatButton(
              child: _createBody(id),
            ),
      ),
    );
  }

  GridView build() {
    return new GridView.builder(
      itemCount: 100,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return getStructuredGridCell(index);
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
