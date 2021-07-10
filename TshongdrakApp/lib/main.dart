import 'package:TshongdrakApp/Customer%20Dashboard/customer_form.dart';
import 'package:TshongdrakApp/Splash.dart';
import 'package:TshongdrakApp/components/Cart_Screen.dart';
import 'package:flutter/material.dart';
import 'package:TshongdrakApp/components/Contact.dart';
import 'package:TshongdrakApp/components/AboutUs.dart';
import 'package:flutter/services.dart';
import 'Shopkeeper Dashoboard/SignUp.dart';
import 'Shopkeeper Dashoboard/Login.dart';
import 'Customer Dashboard/Clogin.dart';
import 'Customer Dashboard/Cregister.dart';
import 'Screens/Home.dart';
import 'Shopkeeper Dashoboard/Shome.dart';

import 'Customer Dashboard/Chome.dart';
import 'Shopkeeper Dashoboard/shopkeeper_form.dart';
import 'components/product.dart';
import 'Screens/ItemsUploaded.dart';
import 'Customer Dashboard/Citems.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. 
  @override
  Widget build(BuildContext context) {
           return MaterialApp(
              //title: 'TshongDrak APP',
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
              primarySwatch: Colors.brown,
              ),
              //Route to the other files from here
              routes: <String, WidgetBuilder>{
               // '/': (context) => HomeScreen(),
                '/Login': (context) => LoginPage(),
                '/SignUp': (context) => RegistrationPage(),
                '/Clogin': (context) => CLoginPage(),
                '/Cregister': (context) => CRegistrationPage(),
                '/contact': (context) => ContactScreen(),
                '/About': (context) => AboutScreen(),
                '/Shome': (context) => ShopHomeScreen(),
                '/Chome': (context) => CustomerHomeScreen(),
                '/product': (context) => Product(),
                '/Items': (context) => ItemsUploaded(),
                '/shopkeeper_form': (context) => ShopkeeperForm(),
                '/customer_form': (context) => CustomerForm(),
                '/Itemsupload': (context) => ItemsUpload(),
                '/cartscreen': (context) => CartScreen(),
              },
            );
          }
        }
         