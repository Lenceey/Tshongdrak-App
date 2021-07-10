import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
  }
          var db;
          var db1;
  void initState() {
    db = Firestore.instance.collectionGroup("Shop Name Plate").snapshots();
     db1 = Firestore.instance.collectionGroup("items").snapshots();
    super.initState();
  }
  @override 
   Widget build(BuildContext context) {
       double width = MediaQuery.of(context).size.width * 0.6;

  return Scaffold(
      appBar: AppBar(
        title: Text("TshongDrak App"),
         ),
         body: new ListView(
           children: <Widget>[
            Padding(padding: const EdgeInsets.all(2.0),
            ),
             SizedBox(height: 200.0,width: double.infinity,
             //image carousel begins here
               child: Carousel(
                  images: [
                    AssetImage('asserts/G1.jpg'),
                    AssetImage('asserts/G2.jpg'),
                    AssetImage('asserts/G3.jpg'),
                    AssetImage('asserts/G4.jpg'),
                  ],
                  ),
                  ),
            new Padding(padding: const EdgeInsets.all(0.0),),
            new Padding(padding: const EdgeInsets.all(15.0),
            child: new Text('Grocery Product', 
            style: TextStyle(
              color: Colors.red, 
              fontWeight: FontWeight.w800),
              ),
            ),
            //grid view
            
            Container(
              height: 500.0,
              child: 
               StreamBuilder(
            stream: db1,
           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.documents;
                 return  Container(
                  padding: EdgeInsets.only(left: 0.1, right: 0,),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                         Padding(padding: EdgeInsets.only(top: 15)),
                        Image.network(
                          userDocument[index].data["thumnailUrl"].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                     child: Column(
                      children: <Widget>[
                         Text(userDocument[index].data["title"]),
                         Text(userDocument[index].data["stock"]),
                         Divider(),
                         
                          Text(userDocument[index].data["price"]),
                      ],
                      ),
                        ),
                      ],
                    ),
                  ),
                 );
              },
            ) : Container();
          }
      ),
      )
     ],
    ), 
    drawer: MainDrawer(),
  );
  }
  }
 