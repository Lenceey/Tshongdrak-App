import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Seller extends StatefulWidget {
  @override
  _SellerState createState() => _SellerState();
}

class _SellerState extends State<Seller> {
      var db;
  void initState() {
    db = Firestore.instance.collectionGroup("Shopkeeper").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlue]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       margin: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(userDocument[index].data["Name"],),
                          ],
                        ),
                        Row(
                          children: [
                            Text(userDocument[index].data["Email"]),
                          ]
                        ),
                        Row(
                          children: [
                           Text(userDocument[index].data["Phone Number"]),
                          ]
                        ),
                        Row(
                          children: [
                             Text(userDocument[index].data["License"]),
                          ]
                        ),
                        Row(
                          children: [
                            Text(userDocument[index].data["Shop Name"]),
                             IconButton(
                              icon: Icon(Icons.delete, size: 20, color: Colors.black,),
                              padding: EdgeInsets.only(left: 150, right: 0),
                               onPressed: () {
                                   _deleteTask();
                                //  Firestore.instance
                                //  .collection("Shopkeeper")
                                //  .document(userDocument[index]
                                //  .data["ID"])
                                //  .delete();
                                //  Navigator.pushNamed(context, '/seller');
                               }
                               )
                          ]
                        ),
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
  _deleteTask()  async{
        CollectionReference collectionReference = Firestore.instance.collection('Shopkeeper');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
}