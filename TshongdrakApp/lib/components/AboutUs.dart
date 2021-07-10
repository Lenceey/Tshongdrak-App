import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:TshongdrakApp/Screens/main_drawer.dart';
import 'package:expandable_text/expandable_text.dart';
  
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
      var db;
  void initState() {
    db = Firestore.instance.collectionGroup("About Data").snapshots();
    super.initState();
  }

  @override 
   Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
         ),
         body: StreamBuilder(
          stream: db,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.documents;
                 return  Container(
                  padding: EdgeInsets.only(left: 15, right: 15,),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.white,Colors.white]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       margin: EdgeInsets.only(bottom: 15, top: 10,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                           Text(
                              userDocument[index].data["info"],
                              // style: TextStyle(
                              //   fontSize: 15.0,
                              //   color: Colors.black,letterSpacing: 0.3,
                              // ),
                              // textAlign: TextAlign.justify,
                              // expandText: 'read more',
                              // collapseText: 'wrap up',
                              ),
                          ],
                        ),
                      ]
                    ),
                  ),
                 );
              },
            ) : Container();
          }
      ),
          drawer: MainDrawer(),
         );
  }
}