import 'package:AdminTshongdrak/Services/Customer.dart';
import 'package:AdminTshongdrak/Services/seller.dart';
import 'package:AdminTshongdrak/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Adminpanel/ALogin.dart';
import 'Adminpanel/Adminhome.dart';
import 'Services/AboutScreen.dart';
import 'Services/Contact.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. 
  @override 
  Widget build(BuildContext context) {
  //  SystemChrome.setPreferredOrientations([
  //    DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown, ]
  //    );
    return MaterialApp(
     // title: 'TshongDrak APP',
     home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
       
      ),
      //Route to the other files from here  
      routes: <String, WidgetBuilder>{
        //'/' : (context)=>ALoginPage(), 
        '/Ahome': (context)=>AdminHome(),
        '/About': (context)=>AboutScreen(),
        '/contact':(context)=>ContactScreen(),
        '/seller':(context)=>Seller(),
        '/customer':(context)=>Customer(),
      },
    );
  }
}
 