import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage_image/firebase_storage_image.dart';

class MyGridView {
  final String storageBucket = 'gs://bucketlist-e3df2.appspot.com/';
  Card getStructuredGridCell(context, id) {
    return new Card(
      elevation: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            flex: 80,
            child: new Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                  image: DecorationImage(
                    //image: AssetImage('assets/pics/' + (id+1).toString()+".jpg"),
                    image: FirebaseStorageImage(
                      storageBucket + (id+1).toString()+".jpg"),
                    fit: BoxFit.fill,
                  )),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondPage())
                      );
                    },
                    //child: _createBody(id),
                  ),
            ),
          ),
          Expanded(
            flex: 20,
            child: _createBody(id)
            // child: new Container(
            //   decoration: ShapeDecoration(
            //     shape: RoundedRectangleBorder(),
            //   ),
            //   //child: _createBody(id))
            // )
            )
            
          //   child: FlatButton(
          //     child:_createBody(id)),
          // )
        ],
      ),
    );
  }

  GridView build(BuildContext context) {
    return new GridView.builder(
      itemCount: 6,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return getStructuredGridCell(context, index);
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: 12,)
                
              
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
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

