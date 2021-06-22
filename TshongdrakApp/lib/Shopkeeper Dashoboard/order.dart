import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/customer_order.dart';
import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/main_order.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
    DocumentReference userRef;
 @override
 initState(){ 
  super.initState();
  _getUserDoc();
 } 

  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    setState((){
       userRef = _firestore.collection("Buy").document(user.uid);
    });
 }
  @override
 Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("My Cart"),
         ),
         body:  Container(
        child: Row(
          children: [
            Expanded(
    child: StreamBuilder<QuerySnapshot> (
                  stream: userRef
                  .collection("Product")
                  .snapshots(),
                  builder: (context,snapshot){
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState){
                      case ConnectionState.waiting:
                        return  Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                          ),
                        );
                      default:
                        return ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (_,index){
                          List<DocumentSnapshot> userDocument = snapshot.data.documents;
                          return Column(
                            children: [
                              MainOrder(b_list: userDocument,index: index),
                               CustomerOrder(b_list: userDocument,index: index),
                            ],
                          );
                        });
                    }
                  },
                ),
              ),
          ],
        ),
      ),
         );
  }
}