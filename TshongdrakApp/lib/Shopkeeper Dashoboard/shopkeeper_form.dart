import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/shopkeeper_signup.dart';
import 'package:flutter/material.dart';

class ShopkeeperForm extends StatefulWidget {
  @override
  _ShopkeeperFormState createState() => _ShopkeeperFormState();
}

class _ShopkeeperFormState extends State<ShopkeeperForm> {
  final _shopkeeperController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                      icon: Icon(Icons.card_membership, color: Colors.lightBlue,),
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