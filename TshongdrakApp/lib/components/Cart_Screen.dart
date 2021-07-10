import 'package:TshongdrakApp/Customer%20Dashboard/Chome.dart';
import 'package:TshongdrakApp/components/Main_Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
    final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await auth.currentUser()).uid;
  }

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
       userRef = _firestore.collection("Customer").document(user.uid);
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
                  .collection("Cart")
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
                              MainCart(b_list: userDocument,index: index),
                              ElevatedButton(
                          onPressed: () async{
                             Map<String, dynamic> data = {
                                  "productId": userDocument[index].data["productId"],
                                  "uid": (await auth.currentUser()).uid,
                                  "time": DateTime.now(),
                                };
                           await Firestore.instance.collection("Buy").document(userDocument[index].data["productId"]).collection("Product").document((await auth.currentUser()).uid).setData(data);
                           await Firestore.instance.collection("Customer").document((await auth.currentUser()).uid).collection("Cart").document(userDocument[index].data["id"]).delete();
                                Fluttertoast.showToast(msg: 'Successful',textColor: Colors.white);
                                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
                 );
                          }, 
                          child: Text('Buy now')
                          )
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
