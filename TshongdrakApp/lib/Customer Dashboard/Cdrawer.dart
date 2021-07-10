import 'package:TshongdrakApp/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerMainDrawer extends StatelessWidget {
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
                      Text('Menu', style: TextStyle(fontSize: 22, color: Colors.white),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.brown,),
            title: Text('Home',
                style: TextStyle(fontSize: 18),
                
            ),
            onTap: (){
               Navigator.pushNamed(context, '/Chome');
            },
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.brown,),
            title: Text(
                'Contact Us',
                style: TextStyle(fontSize: 18),
            ),
            onTap: (){
                    Navigator.pushNamed(context, '/contact');
            } 
          ),
          ListTile(
            leading: Icon(Icons.help, color:Colors.brown,),
            title: Text(
                'About Us',
                style: TextStyle(fontSize: 18),),
                onTap: (){
                    Navigator.pushNamed(context, '/About');
            } 
            ),   
             ListTile(
            leading: Icon(Icons.logout, color:Colors.brown,),
            title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),),
                onTap: () async{
                   logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
            }
             ),
              
        ],
      ),
    );
  }
}