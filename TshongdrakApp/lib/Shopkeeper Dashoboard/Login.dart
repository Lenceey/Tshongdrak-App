import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TshongdrakApp/Shopkeeper Dashoboard/Shome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _error;
  static final _auth= FirebaseAuth.instance;
   void login(String email, String password) async
   {
    try{
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       Navigator.push(context, MaterialPageRoute(
         builder: (context) => ShopHomeScreen()
       ));
      
       //RestartWidget.of(context).restartApp();
     }
     catch(e)
     {
      setState(() {
         _error =e.message;
       });
     }
   }

  final _formKey= GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoading = false;
  bool _seepassword = true;

  _submit()
  {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();  //save the data inside formkey

      login(_email, _password);

    }
    setState(() {
      _isLoading = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Customer Login", style: TextStyle(color: Colors.white)),
            onPressed: () async{
                Navigator.pushNamed(context, '/Clogin');
            },
          )
        ],),
      body: SingleChildScrollView(
        child: Container(
        height: deviceInfo.size.height,
          width: deviceInfo.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 65,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: <Widget>[
                    Text("Shopkeeper Login!!!",
                      style: TextStyle(color: Colors.black,fontSize: 30, 
                      fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              ShowError(),// logo
              // making login form begins here
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(decoration: InputDecoration(
                            icon: Icon(Icons.mail,color: Colors.brown,),
                              labelText: '[Email]'),
                            validator: (input) =>
                            !input.contains('@')
                                || !input.contains('.')? 'Please enter valid email'
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
                          child: TextFormField(decoration: InputDecoration(
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
                    _isLoading ? Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.brown,
                          valueColor: AlwaysStoppedAnimation(Colors.brown),
                        )): SizedBox.shrink(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          color: Colors.brown,
                          width: deviceInfo.size.width/3,
                          child: FlatButton(
                            onPressed: _submit,
                            child: Text("Login",
                               style: TextStyle(color: Colors.white,fontWeight: 
                               FontWeight.bold,letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Text("Create Account!!!",style: TextStyle(color: Colors.black)),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginPage()
                  )),
                  child: RaisedButton(
                     onPressed: () async{
                       Navigator.pushNamed(context, '/shopkeeper_form');
                      },
                      child: Text("Register",style: TextStyle(color: Colors.black),
                            ),
                          ),
                    ),
            ],
          ),
        ),
      ),
    );
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
              Icon(Icons.warning,color: Colors.amber,),
              SizedBox(width: 5,),
              Expanded(child: Text(_error,style: TextStyle(color: Colors.black),))
            ],
          ),
        ),
      );
    }
    return SizedBox(height: 0,);
  }
}