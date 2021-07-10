import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
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
                      Text('Menu', style: TextStyle(fontSize: 22, color: Colors.white, ),),
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
               Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.brown,),
            title: Text(
                'Account', 
                style: TextStyle(fontSize: 18),
            ),
            onTap: (){
                    Navigator.pushNamed(context, '/Clogin');
            } 
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
            leading: Icon(Icons.help, color: Colors.brown,),
            title: Text(
                'About Us',
                style: TextStyle(fontSize: 18),),
                onTap: (){
                    Navigator.pushNamed(context, '/About');
            } 
            ),   
        ],
      ),
    );
  }
}