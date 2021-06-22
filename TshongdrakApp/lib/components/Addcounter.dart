import 'package:flutter/material.dart';

class Itemcounter extends StatefulWidget {
 
  @override
  _ItemcounterState createState() => _ItemcounterState();
}

class _ItemcounterState extends State<Itemcounter> {
 
  getCartData() {
    
  }

 @override
  void initState() {
   getCartData();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black
          ),
          borderRadius: BorderRadius.circular(4)
        ),
      child: Row(
        children: [
          Container(
           // child: Padding(
             // padding: const EdgeInsets.only(left: 3, right: 3),
              child: Icon(Icons.remove),
            ),
        //  ),
          Container(
             height: double.infinity,
            width: 30,
            color: Colors.lightBlue,
            child: FittedBox(child: Text('1', style: TextStyle(color: Colors.white),)),
          ),
          Container(
          // child: Padding(padding: const EdgeInsets.only()),
            child: Icon(Icons.add,),
          ),
        ],
      ),
    );
  }
}