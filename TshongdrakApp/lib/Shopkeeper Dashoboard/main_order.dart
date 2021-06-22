import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainOrder extends StatelessWidget {
 final List<DocumentSnapshot> b_list;
  final int index;

   MainOrder({Key key, this.b_list, this.index}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("items").where("productId",isEqualTo: b_list[index]["productId"].toString()).getDocuments(),
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
                return 
                // Container(
                //   child: Row(
                //     children: [
                //       Text(document["title"], style: TextStyle(fontSize: 20)),
                //       Text(document["stock"], style: TextStyle(fontSize: 20)),
                //       Text(document["price"], style: TextStyle(fontSize: 20)),            
                //     ],
                //     ),
                // );
                 Container(
                  padding: EdgeInsets.only(left: 0.1, right: 0,),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                         Padding(padding: EdgeInsets.only(top: 15)),
                        Image.network(
                          document["thumnailUrl"].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                     child: Column(
                      children: <Widget>[
                         Text(document["title"]),
                         Text(document["stock"]),
                         Divider(),
                         
                          Text(document["price"]),
                        
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