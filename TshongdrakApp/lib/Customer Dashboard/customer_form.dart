import 'package:TshongdrakApp/Customer%20Dashboard/customer_signup.dart';
import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
   final _customerController = TextEditingController();
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
                  controller: _customerController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.card_membership, color: Colors.brown ,),
                      labelText: 'CID',
                    labelStyle: TextStyle(fontSize: 20),
                  ) ,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'CID is requires';
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
                        builder: (context) => CustomerSignup(cid : _customerController.text),
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