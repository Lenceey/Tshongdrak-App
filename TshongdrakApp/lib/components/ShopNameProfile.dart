import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopNameProfile extends StatefulWidget {
  @override
  _ShopNameProfileState createState() => _ShopNameProfileState();
}

class _ShopNameProfileState extends State<ShopNameProfile> {
        var db;
  void initState() {
    db = Firestore.instance.collectionGroup("Shop Name Plate").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Profile"),
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
                  padding: EdgeInsets.only(left: 15, right: 15,),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlue]),
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
                         Text(userDocument[index].data["Shop Name"]),
                         Text(userDocument[index].data["Your Address"]),
                         Divider(),
                          Text(userDocument[index].data["Phone Number"]),                        
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