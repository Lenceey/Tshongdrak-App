import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_auth/email_auth.dart';
//import 'package:TshongdrakApp/Shopkeeper Dashoboard/Shome.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  static final _auth= FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  final _formKey= GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  String _phone;
  String _license;
  String _shop;
  bool _isLoading =false;
  String _error;
  String _otp;
  String _add;
  bool _seepassword = true;

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

  _submit()
  {
    if(_formKey.currentState.validate())
    {
      setState(() {
        _isLoading =true;
      });
      _formKey.currentState.save();  //save the data inside formkey
      //connect to firebase
      signUpUser(context, _name, _email, _password, _phone, _license, _shop, _otp,);
    }
  }

  
  void signUpUser(BuildContext context,String name,String email, String password, String phone, String license, String shop, String otp) async
  {
    try
    {
      AuthResult authResult =await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if(signedInUser !=null)
      {
        _firestore.collection("Shopkeeper").document(signedInUser.uid).setData({
          'ID': signedInUser.uid,
          'Name':name,
          'Email': email,
          'Phone Number' : phone,
          'License' : license,
          'Shop Name' : shop,
        });
        Navigator.pushNamed(context, '/Shome');
      }
    }
    catch(e)
    {
      setState(() {
        _error =e.message;
      });
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
              Icon(Icons.warning,color: Colors.lightBlue,),
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
       ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text("Create Account  for Shopkeeper",
                style: TextStyle(color: Colors.black,fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            ),
            SizedBox(height: 15,),
            Form(
               key: _formKey,
              child: Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10,),
                     child: Card(
                       child: Padding(
                         padding: EdgeInsets.all(8),
                         child: TextFormField(
                           decoration: InputDecoration(
                             icon: Icon(Icons.person, color: Colors.lightBlue,),
                             labelText: 'Full Name'),
                            validator: (String value) {
                            if (!RegExp(r"^[a-z_]{1,24}$",caseSensitive: false,).hasMatch(value)) {
                              return 'Please enter your valid full name';  
                            } else {
                              return null;
                            }
                          },
                           onSaved: (input) => _name = input,
                         ),
                       ),
                     ),
                   ),

                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(decoration: InputDecoration(
                           icon: Icon(Icons.pages, color: Colors.lightBlue,),
                           labelText: 'License'),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          onSaved: (input) => _license = input,
                             validator: (input) {
                             if (input.length < 7 ) {
                                return "License must be atleaest 7 digit long";
                             }
                             else if (input.length > 8) {
                               return "License must be  7 digit only";
                             } else {
                               return null;
                             }
                           
                             },),),
                      ),
                    ),
                    
                     Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(decoration: InputDecoration(
                           icon: Icon(Icons.people, color: Colors.lightBlue,),
                           labelText: 'Shop Name'),
                          validator: (input) =>
                           input.trim().length<3
                               ? 'Please enter Your Shop Name'
                               : null,
                           onSaved: (input) => _shop = input,
                        ),),
                      ),
                    ),

                     Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(decoration: InputDecoration(
                           icon: Icon(Icons.phone, color: Colors.lightBlue,),
                          prefixText: "+975",
                           labelText: 'Phone Number'),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                onSaved: (input) => _phone = input,
                                validator: (input) {
                             if (input.length < 8 ) {
                                return "Phone Number must be atleaest 8 digit long";
                             }
                             else if (input.length > 8) {
                               return "Phone Number must be  8 digit only";
                             } else {
                               return null;
                             }
                             },
                        ),),
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
                           icon: Icon(Icons.mail, color: Colors.lightBlue,),
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
                           icon: Icon(Icons.phone, color: Colors.lightBlue,),
                           labelText: 'OTP',
                           suffixIcon: TextButton(
                               child: Text("Verify OTP"),
                               onPressed: () => verifyOTP(),
                            ),),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                           icon: Icon(Icons.lock, color: Colors.lightBlue,),
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
                           icon: Icon(Icons.lock, color: Colors.lightBlue,),
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
                   _isLoading ? Padding(padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                       child: LinearProgressIndicator(
                         backgroundColor: Colors.blue[200],
                         valueColor: AlwaysStoppedAnimation(Colors.blue),
                       )): SizedBox.shrink(),
                   SizedBox(height: 20),
                   ShowError(),
                   SizedBox(height: 5),


                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: GestureDetector(
                       onTap: _submit,
                       child: Card(
                         color: Colors.lightBlue,
                         child: Padding(
                           padding: const EdgeInsets.all(20),
                           child: Container(
                               width: MediaQuery.of(context).size.width/4,
                               child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,letterSpacing: 1),),),),
                         ),), 
                     ),
                   ),


                 ],
              ),
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
    );
  }
}