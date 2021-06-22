import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
        var db;
  void initState() {
    db = Firestore.instance.collectionGroup("items").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
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
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.blue,Colors.red]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Image.network(
                          userDocument[index].data["thumnailUrl"].toString(),
                          width: 400,
                          height: 200,
                          fit: BoxFit.scaleDown,
                        ),
                         Text(userDocument[index].data["title"]),
                         Text(userDocument[index].data["stock"]),
                         Divider(),
                          Text(userDocument[index].data["price"]),
                        IconButton(
                              icon: Icon(Icons.delete, size: 20, color: Colors.black,),
                              padding: EdgeInsets.only(left: 230, right: 0),
                               onPressed: () {
                                 Firestore.instance
                                 .collection("items")
                                 .document(userDocument[index]
                                 .data["price"])
                                 .delete();
                                 Navigator.pushNamed(context, '/product');
                               }
                               )
                      ]
                    ),
                  ),
                 );
              },
            ) : Container();
          }
      ),
    );
  }
}