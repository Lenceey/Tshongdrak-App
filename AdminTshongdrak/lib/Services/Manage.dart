import 'package:flutter/material.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
 
   @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Update About Us"),
              onTap: () {
                   Navigator.pushNamed(context, '/About');
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Update Contact Us"),
              onTap: () {
                  Navigator.pushNamed(context, '/contact');
              },
            ), 
            Divider(),

            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Customer List"),
              onTap: () {
                  Navigator.pushNamed(context, '/customer');
              },
            ), 
            Divider(),

          ],
       ), 
    );   
  }
}