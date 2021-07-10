import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
      var db;
  void initState() {
    db = Firestore.instance.collectionGroup("MainCustomer").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Colors.brown,
        title: Text("Customer List",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          ),),
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
                        gradient: LinearGradient(colors: [Colors.brown[200],Colors.brown[200]]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                       margin: EdgeInsets.only(bottom: 15, top: 15),
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
                            Text(userDocument[index].data["CID"]),
                             IconButton(
                              icon: Icon(Icons.delete, size: 20, color: Colors.black,),
                              padding: EdgeInsets.only(left: 200, right: 0),
                               onPressed: () {
                                 _deleteTask();
                                //  Firestore.instance
                                //  .collection("Customer")
                                //  .document(userDocument[index]
                                //  .data["ID"])
                                //  .delete();
                                //  Navigator.pushNamed(context, '/customer');
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
        CollectionReference collectionReference = Firestore.instance.collection('Customer');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
}