import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveTask() {
    final taskName = _controller.text;

  Firestore.instance.collection("Contact Data")
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
        title: Text("Update Contact"),
         ),
         body: new ListView(
           children: [
             TextField(decoration: InputDecoration(
               labelText: 'Daily Entry', border: InputBorder.none,
             ),
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
               onPressed: () {
                 _deleteTask();
               },
             ),
           ],
         ),
         
         );
  }
  _deleteTask()  async{
        CollectionReference collectionReference = Firestore.instance.collection('Contact Data');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
    
}