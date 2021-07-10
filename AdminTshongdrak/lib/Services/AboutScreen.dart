import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveTask() {
    final taskName = _controller.text;

  Firestore.instance.collection("About Data")
  .add({
    "info": taskName
  });
  _controller.clear();
  Fluttertoast.showToast(msg: 'Data Added',textColor: Colors.white);
  }

  final ref = Firestore.instance.collection('notes');

  @override 
   Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text("Update AboutUs"),
         ),
         body: new ListView(
           children: [
             TextField(decoration: InputDecoration(
               labelText: 'Daily Entry', border: InputBorder.none,
             ),
             textAlign: TextAlign.justify,
             controller: _controller,
             maxLines: 12,
             minLines: 10,
             ),
             RaisedButton(
               color: Theme.of(context).accentColor,
               child: Text('save', style: TextStyle(color:Colors.white)),
               onPressed: () {
                  _saveTask();
               },
             ),
             RaisedButton(
               color: Colors.red,
               child: Text('Delete', style: TextStyle(color:Colors.white)),
               onPressed: ()
               {
                 _deleteTask();
               },
             ),
           ],
         ),
         );
  }
    _deleteTask()  async{
        CollectionReference collectionReference = Firestore.instance.collection('About Data');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
    
}
