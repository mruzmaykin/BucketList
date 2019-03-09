import 'package:carousel_slider/carousel_slider.dart';
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
                        storageBucket + (id + 1).toString() + ".jpg"),
                    fit: BoxFit.fill,
                  )),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondPage(id: id)));
                },
                //child: _createBody(id),
              ),
            ),
          ),
          Expanded(flex: 20, child: _createBody(id)
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
}

class SecondPage extends StatelessWidget {
  SecondPage({this.id});
  int id;
  final String storageBucket = 'gs://bucketlist-e3df2.appspot.com/';
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: _getTitle(id),
        centerTitle: true,
      ),
      body: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // new Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          Expanded(
            flex: 57,
            child: CarouselSlider(
              height: 400.0,
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(),
                          image:DecorationImage( 
                        image: FirebaseStorageImage(
                        storageBucket + (id + 1).toString() + ".jpg"),
                  fit: BoxFit.fill,
                  ),
                        // child: Text(
                        //   'text $i',
                        //   style: TextStyle(fontSize: 16.0),
                        // ));
                    ),);},
                );
              }).toList(),
            ),
          ),
          Expanded(
            flex: 13,
            child: new Container(
              //padding: const EdgeInsets.all(16.0),
              width: c_width,
              child: _getAddress(id),
            ),
          ),

          Expanded(
            flex: 30,
            child: new Container(
              //padding: const EdgeInsets.all(16.0),
              width: c_width,
              child: _getDescription(id),
            ),
          )
          // new RaisedButton.icon(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: new Icon(
          //     Icons.arrow_back,
          //     color: Colors.teal,
          //   ),
          //   label: Text('Back'),
          // ),
          //   ],
          // )
        ],
      )),
    );
  }
}

Widget _createBody(int id) {
  String text;
  return StreamBuilder(
      stream: Firestore.instance
          .collection('places')
          .document(id.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          if (doc.exists) {
            return Text(text = doc['content'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: 12,
                ));
          }
        }
        return Center(child: CircularProgressIndicator());
      });
}

Widget _getAddress(int id) {
  String text;
  return StreamBuilder(
      stream: Firestore.instance
          .collection('places')
          .document(id.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          if (doc.exists) {
            return Text(text = "Address: " + doc['address'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: 11,
                ));
          }
        }
        return Center(child: CircularProgressIndicator());
      });
}

Widget _getDescription(int id) {
  String text;
  return StreamBuilder(
      stream: Firestore.instance
          .collection('places')
          .document(id.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          if (doc.exists) {
            return Text(text = doc['description'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: 9,
                ));
          }
        }
        return Center(child: CircularProgressIndicator());
      });
}

Widget _getTitle(int id) {
  String text;
  return StreamBuilder(
      stream: Firestore.instance
          .collection('places')
          .document(id.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          if (doc.exists) {
            return Text(text = '\u00b7' + doc['content'] + '\u00b7',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontFamily: 'Raleway Bold',
                  fontSize: 16,
                ));
          }
        }
        return Center(child: CircularProgressIndicator());
      });
}
