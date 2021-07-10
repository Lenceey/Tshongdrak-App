import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/shopkeeper_signup.dart';
import 'package:flutter/material.dart';

class ShopkeeperForm extends StatefulWidget {
  @override
  _ShopkeeperFormState createState() => _ShopkeeperFormState();
}

class _ShopkeeperFormState extends State<ShopkeeperForm> {
  final _shopkeeperController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   String _error;
    bool _isLoading =false;

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
       bottomNavigationBar: _getForm(),
    );
  }

  Widget _getForm() {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
        child: Column(children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _shopkeeperController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.card_membership, color: Colors.brown,),
                      labelText: 'License',
                    labelStyle: TextStyle(fontSize: 20),
                  ) ,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'License is requires';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    if(!_formKey.currentState.validate()){
                      return ;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopkeeperSignup(license : _shopkeeperController.text),
                      ),
                    );
                  },
                  child: Text("Enter",style: TextStyle(fontSize: 15, color: Colors.white)),
                )
              ],
            ),
          ),
        ]));
  }
}