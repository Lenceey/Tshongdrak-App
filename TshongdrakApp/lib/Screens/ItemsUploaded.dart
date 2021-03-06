import 'package:TshongdrakApp/components/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemsUploaded extends StatefulWidget {
  @override
  _ItemsUploadedState createState() => _ItemsUploadedState();
}

class _ItemsUploadedState extends State<ItemsUploaded> {
        var db;
  void initState() {
    db = Firestore.instance.collectionGroup("items").snapshots();
    super.initState();
  }

    final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
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
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async{
                                  Map <String, dynamic> data = {
                                    "productId": userDocument[index].data["productId"],
                                    "uid": (await _auth.currentUser()).uid,
                                  };

                                 await Firestore.instance.collection("Customer").document((await _auth.currentUser()).uid).collection("Cart").add(data);
                                  Navigator.pushNamed(context, '/cartscreen');
                                                                 } ,
                                 child: Text("Add to cart")
                                 ),
                                 SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () {} ,
                                 child: Text("Buy now")
                                 ),
                          ],
                          )
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
}


