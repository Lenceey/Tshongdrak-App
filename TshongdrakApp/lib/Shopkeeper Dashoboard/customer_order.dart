import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerOrder extends StatelessWidget {
 final List<DocumentSnapshot> b_list;
  final int index;

   CustomerOrder({Key key, this.b_list, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("MainCustomer").where("UID",isEqualTo: b_list[index]["uid"].toString()).getDocuments(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
              ),
            );
          }else{
            return  Column(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Container(
                  padding: EdgeInsets.only(left: 0.1, right: 0,),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                         Padding(padding: EdgeInsets.only(top: 15)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                     child: Column(
                      children: <Widget>[
                         Text(document["Name"]),
                         //Text(document["Address"]),
                          Text(document["Phone Number"]),
                      ],
                      ),
                        ),
                      
                   
                      ],
                    ),
                  ),
                 );
              }).toList(),
            );
          }
        }
    );
  }
}