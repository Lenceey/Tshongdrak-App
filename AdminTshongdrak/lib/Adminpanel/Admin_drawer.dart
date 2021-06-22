import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ALogin.dart';

class AdminMainDrawer extends StatelessWidget {
  FirebaseAuth auth=FirebaseAuth.instance;
    Future<void> logOut() async{
      FirebaseUser user=auth.signOut() as FirebaseUser;
    }

  @override 
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      width:80,
                      height:20,
                        ),
                      Text('Menu', style: TextStyle(fontSize: 22, ),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color:Color(0xFF03A9F4),),
            title: Text('Home',
                style: TextStyle(fontSize: 18),
                
            ),
            onTap: (){
               Navigator.pushNamed(context, '/Ahome');
            },
          ),
             ListTile(
            leading: Icon(Icons.logout, color:Color(0xFF03A9F4),),
            title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),),
                onTap: () async{
                    logOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>
               ALoginPage()), (Route<dynamic> route) => false);
            }
             ), 
        ],
      ),
    );
  }
}