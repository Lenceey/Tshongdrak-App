import 'package:flutter/material.dart';
import 'package:TshongdrakApp/Screens/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
      var db;
  void initState() {
    db = Firestore.instance.collectionGroup("Contact Data").snapshots();
    super.initState();
  }

  @override 
   Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
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
                        gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlue]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       margin: EdgeInsets.only(bottom: 15, top: 10,),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(userDocument[index].data["info"],),
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