import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
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

         body: new ListView(
           children: <Widget>[
             Container(
                height: 500.0,
              child: StreamBuilder(
          stream: db,
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
                          IconButton(
                              icon: Icon(Icons.delete, size: 10, color: Colors.black,),
                              padding: EdgeInsets.only(left: 200, right: 0),
                               onPressed: () {
                                 _deleteTask();
                               },
                               ),
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
       ),
      ],
      ),
    );
  }
  _deleteTask()  async{
        CollectionReference collectionReference = Firestore.instance.collection('items');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
}
