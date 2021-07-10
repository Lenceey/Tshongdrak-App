import 'dart:convert';
import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopkeeperSignup extends StatefulWidget {
  @override
  _ShopkeeperSignupState createState() => _ShopkeeperSignupState();
    final String license;
  const ShopkeeperSignup({Key key, this.license}) : super(key : key);
}

class _ShopkeeperSignupState extends State<ShopkeeperSignup> {
   final FirebaseAuth _auth = FirebaseAuth.instance;

   final TextEditingController _otpcontroller = TextEditingController();
   final TextEditingController _emailcontroller = TextEditingController();
   final TextEditingController _passwordcontroller = TextEditingController();
   final TextEditingController _confirmpasswordcontroller = TextEditingController();

   String _otp;
   bool _seepassword = true;
   String _password;
   String _email;
   String _error;
   bool _isLoading =false;
   final _formKey= GlobalKey<FormState>();

     void sendOTP() async {
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: _emailcontroller.text);
    if (res) {
     print("OTP sent");
      Fluttertoast.showToast(msg: 'OTP Sent');
    }
    else {
      print("Sorry");
      Fluttertoast.showToast(msg: 'invalid');
    }
  }

    void verifyOTP() {
    var res = EmailAuth.validate(
      receiverMail: _emailcontroller.text, userOTP: _otpcontroller.text);
       if (res) {
              print("OTP verified");
              Fluttertoast.showToast(msg: 'verified');
             }
              else {
               print("Invalid OTP");
                 Fluttertoast.showToast(msg: 'invalid');
              }
            }



       Widget ShowError(){
    if(_error!=null){
      setState(() {
        _isLoading=false;
      });
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Center(
          child: Row(
            children: <Widget>[
              Icon(Icons.warning,color: Colors.brown,),
              SizedBox(width: 5,),
              Expanded(child: Text(_error,style: TextStyle(color: Colors.black),))
            ],
          ),
        ),
      );
    }
    return SizedBox(height: 0,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("asserts/shoopkeeper.json"),
        builder: (context, snapshot){
          var myDoc = json.decode(snapshot.data.toString());

          return new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (myDoc[index]['license'] == widget.license) ?
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10,),
                        child: Form(
                           key: _formKey,
                           child: Column(
                            children: [
                               Card(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: TextFormField(
                                      controller: TextEditingController(text: myDoc[index]["name"]),
                                      decoration: InputDecoration(
                                         icon: Icon(Icons.person, color: Colors.brown),
                                          labelText: 'Full Name',
                                          labelStyle: TextStyle(fontSize: 20),
                                      ) ,
                                  ),
                                   ),
                               ),
                               Card(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: TextFormField(
                                      controller: TextEditingController(text: myDoc[index]["shop name"]),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.people, color: Colors.brown,),
                                          labelText: 'Shop Name',
                                          labelStyle: TextStyle(fontSize: 20),
                                      ) ,
                                  ),
                                   ),
                               ),
                                 Card(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: TextFormField(
                                      controller: TextEditingController(text: myDoc[index]["phone"]),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.phone, color: Colors.brown,),
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(fontSize: 20),
                                      ) ,
                                  ),
                                   ),
                               ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                    icon: Icon(Icons.mail, color: Colors.brown,),
                                      labelText: 'Email',
                                      suffixIcon: TextButton(
                                        child: Text("Send OTP"),
                                        onPressed: () => sendOTP(),
                                      )),
                                    validator: (input) =>
                                    !input.contains('@') || !input.contains('.')
                                        ? 'Please enter valid email'
                                        : null,
                                    onSaved: (input) => _email = input,
                                  ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _otpcontroller,
                                    decoration: InputDecoration(
                                    icon: Icon(Icons.phone, color: Colors.brown,),
                                    labelText: 'OTP',
                                    suffixIcon: TextButton(
                                        child: Text("Verify OTP"),
                                        onPressed: () => verifyOTP(),
                                      ),),
                                    keyboardType: TextInputType.number,
                                    //  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      onSaved: (input) => _otp = input,
                                      validator: (String value) {
                                      if (value.length < 6 ) {
                                          return "OTP must be atleaest 6 digit long";
                                      }
                                      else if (value.length > 6) {
                                        return "OTP must be  6 digit only";
                                      }
                                      return null;
                                      },
                                  ),),),
                              ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: _passwordcontroller,
                                    decoration: InputDecoration(
                                    suffixIcon: _seepassword?GestureDetector(onTap: (){ setState(() {
                                            _seepassword = false;});},
                                        child: Icon(CupertinoIcons.eye_solid)):
                                        GestureDetector(onTap: (){setState(() {
                                          _seepassword = true;
                                        });},
                                        child: Icon(CupertinoIcons.clear)),
                                    icon: Icon(Icons.lock, color: Colors.brown,),
                                      labelText: 'Password'),
                                    validator: (input) =>
                                    input.length < 6
                                        ? 'Password must be atleaest 6 character long'
                                        : null,
                                    obscureText: _seepassword,
                                    onSaved: (input) => _password = input,
                                  ),
                              ),
                            ),
                          ),
                          Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                    controller: _confirmpasswordcontroller,
                                  decoration: InputDecoration(
                                  suffixIcon: _seepassword?GestureDetector(onTap: (){ setState(() {
                                          _seepassword = false;});},
                                      child: Icon(CupertinoIcons.eye_solid)):
                                      GestureDetector(onTap: (){setState(() {
                                        _seepassword = true;
                                      });},
                                      child: Icon(CupertinoIcons.clear)),
                                  icon: Icon(Icons.lock, color: Colors.brown,),
                                    labelText: 'Confirm Password'),
                                  validator: (String value) {
                                    if (value != _passwordcontroller.value.text) {
                                      return 'Passwords do not match!';
                                    } else {
                                    }
                                  },
                                  obscureText: _seepassword,
                                  onSaved: (input) => _password = input,
                                ),
                            ),
                          ),
                        ),

                    SizedBox(height: 10,),
                              ElevatedButton(
                                child: Text('Sign Up',style: TextStyle(fontSize: 15, color: Colors.white)),
                                onPressed: () async {
                                   if(_formKey.currentState.validate()){
                                        setState(() {
                                          _isLoading =true;
                                        });
                                        _formKey.currentState.save();  //save the data inside formkey
                                        //connect to firebase
                                              try {
                                                AuthResult authResult =await _auth.createUserWithEmailAndPassword(
                                                    email: _email,
                                                    password: _password,
                                                );
                                                FirebaseUser signedInUser = authResult.user;
                                                if(signedInUser !=null)
                                                {

                                                  Map <String, dynamic> data = {
                                                      "Name":  myDoc[index]["name"],
                                                      "License":  myDoc[index]["license"],
                                                      "Shop Name":  myDoc[index]["shop name"],
                                                      "Phone Number":  myDoc[index]["phone"],
                                                      "Email":  _emailcontroller.text,
                                                      "UID": signedInUser.uid,
                                                  };
                                                    await Firestore.instance.collection("Shopkeeper").document(signedInUser.uid).setData(data);
                                                }
                                              }
                                              catch(e)
                                                    {
                                                      setState(() {
                                                        _error =e.message;
                                                      });
                                                    }
                                                 }
                                         Navigator.pushNamed(context, '/Shome');
                                },
                              ),

                      SizedBox(height: 15,),
                      Text("Already have account!!!",style: TextStyle(color: Colors.black)),
                      SizedBox(height: 15,),
                        GestureDetector(
                            onTap: ()=> Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LoginPage()
                            )),
                            child: RaisedButton(
                              onPressed: () async{
                                Navigator.pushNamed(context, '/Login');
                                },
                                child: Text("Login",style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ) : Center();
                        },
                itemCount: myDoc == null ? 0 : myDoc.length,
          );
        }
      ),
    );
  }
}
