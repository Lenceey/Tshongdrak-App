import 'package:TshongdrakApp/Customer%20Dashboard/Cdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerHomeScreen extends StatefulWidget {
  
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
       final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
  }
  var db1;
  var db;
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
        actions:<Widget> [
          IconButton(icon: Icon(Icons.shopping_cart), 
          onPressed: () {
            Navigator.pushNamed(context, '/cartscreen');
          }
          ),
        ],
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
            child: new Text('Grocery Shop', 
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
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async{
                                  DocumentReference ref = Firestore.instance.collection("Customer").document((await _auth.currentUser()).uid).collection("Cart").document();
                                  ref.setData({
                                    "productId": userDocument[index].data["productId"],
                                    "uid": (await _auth.currentUser()).uid,
                                    "id": ref.documentID,
                                  });

                                //  await Firestore.instance.collection("Customer").document((await _auth.currentUser()).uid).collection("Cart").add(data);
                                  Navigator.pushNamed(context, '/cartscreen');
                                                                 } ,
                                 child: Text("Add to cart")
                                 ),
                                 SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () async{
                                Map<String, dynamic> data = {
                                  "productId": userDocument[index].data["productId"],
                                  "uid": (await _auth.currentUser()).uid,
                                  "time": DateTime.now(),
                                };
                                await Firestore.instance.collection("Buy").document(userDocument[index].data["productId"]).collection("Product").document((await _auth.currentUser()).uid).setData(data);
                                Fluttertoast.showToast(msg: 'Successful',textColor: Colors.white);
                                Navigator.pushNamed(
                                  context, "/chome");
                                  
                                } ,
                                 child: Text("Buy now"),
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
      )
     ],
    ), 
    drawer: CustomerMainDrawer(),
  );
  }

  
}

