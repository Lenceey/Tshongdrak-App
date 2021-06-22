import 'dart:io';
import 'package:TshongdrakApp/Screens/Home.dart';
import 'package:TshongdrakApp/Widget/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ShopMainDrawer extends StatefulWidget {
  @override
  _ShopMainDrawerState createState() => _ShopMainDrawerState();
}

class _ShopMainDrawerState extends State<ShopMainDrawer> {
 File file;
   TextEditingController _shopnameEditingController = TextEditingController();
   TextEditingController _addressEditingController = TextEditingController();
   TextEditingController _phoneEditingController = TextEditingController();
    String profileID = DateTime.now().millisecondsSinceEpoch.toString();
    bool uploading = false;
     FirebaseAuth auth=FirebaseAuth.instance;
      Future<void> logOut() async{
      FirebaseUser user=auth.signOut() as FirebaseUser;
    }

  @override 
  Widget build(BuildContext context) {
     return file == null ? displaydrawerScreen() : displayshopUploadFormScreen();
       
  }

   displaydrawerScreen()
    {
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
                      Text('Menu', style: TextStyle(fontSize: 22, ),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color:Color(0xFF03A9F4),),
            title: Text('Home',
                style: TextStyle(fontSize: 18),
                
            ),
           onTap: (){
                    Navigator.pushNamed(context, '/Shome');
            }
          ),
           ListTile(
            leading: Icon(Icons.account_circle, color:Color(0xFF03A9F4),),
            title: Text('Shop Profile',
                style: TextStyle(fontSize: 18),
                
            ),
           onTap:()=> takeImage(context),
          ),
             ListTile(
            leading: Icon(Icons.logout, color:Color(0xFF03A9F4),),
            title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),),
                onTap: () async{
                    //Navigator.pushNamed(context, '/Login');
                    logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
            }
             ), 
        ],
      ),
    );
    }
  takeImage(mContext) {
    return showDialog(
      context: mContext,
       builder: (con){
         return SimpleDialog(
            title: Text('Upload Shop Image', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          children: [
              SimpleDialogOption(
              child: Text("Capture with Camera",style: TextStyle(color: Colors.black,)),
              onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
              child: Text("Select from Gyallery",style: TextStyle(color: Colors.black,)),
              onPressed: pickPhotoFromGallery,
              ),
               SimpleDialogOption(
                 child: Text("Cancel",style: TextStyle(color: Colors.black,)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
               )
            ],
         );   
      }
      );
   }

   capturePhotoWithCamera() async{
      Navigator.pop(context);
      File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
   
   setState(() {
     file = imageFile;
   });
   }
   pickPhotoFromGallery() async {
    Navigator.pop(context);
      File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
   
   setState(() {
     file = imageFile;
   });
  }

  displayshopUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.lightBlue, Colors.lightBlue],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),onPressed: clearformInfoShop),
        title: Text("Shop Profile", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold,)),
        actions: [
          FlatButton(
            onPressed: 
             uploading ? null : ()=> uploadImageAndSaveItemInfo(),
          child: Text("Add", style: TextStyle(
            color: Colors.pink, fontSize: 16.0, 
            fontWeight: FontWeight.bold,)),
          ),
          ],
    ),
    body: ListView(
      children: [
        uploading ? linearProgress() : Text(""),
        Container(
          height: 230.0,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
              )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 12.0)),
        ListTile(
          leading: Icon(Icons.perm_device_information, color: Colors.red,),
          title: Container(
            width: 250.0,
            child: TextField(
              style: TextStyle(color: Colors.amber),
              controller:_shopnameEditingController,
              decoration: InputDecoration(
              hintText: "Shop Name",
              hintStyle: TextStyle(color: Colors.red),
              border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.black,),

        ListTile(
          leading: Icon(Icons.perm_device_information, color: Colors.red,),
          title: Container(
            width: 250.0,
            child: TextField(
              style: TextStyle(color: Colors.amber),
              controller:_addressEditingController,
              decoration: InputDecoration(
              hintText: "Your Address",
              hintStyle: TextStyle(color: Colors.red),
              border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.black,),

        ListTile(
          leading: Icon(Icons.perm_device_information, color: Colors.red,),
          title: Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.amber),
              controller:_phoneEditingController,
              decoration: InputDecoration(
              hintText: "Phone Number",
              hintStyle: TextStyle(color: Colors.red),
              border: InputBorder.none,
              ),
            ),
          ),
        ),
        Divider(color: Colors.black,)

      ],
    ),
    );
  }
  clearformInfoShop() {
    setState(() {
      file  = null;
       _shopnameEditingController.clear();
       _addressEditingController.clear(); 
      _phoneEditingController.clear();
    });
  }
  uploadImageAndSaveItemInfo() async{
    setState(() {
      uploading = true;
    });

   String imageDownloadUrl = await uploadImage(file);
  
    saveItemInfo(imageDownloadUrl);
     Fluttertoast.showToast(msg: 'Added',textColor: Colors.white);
   }
  Future<String> uploadImage(mfileImage) async {
   final StorageReference storageReference = FirebaseStorage.instance.ref().child("Shop Name Plate");
   StorageUploadTask uploadTask = storageReference.child("Profile_$profileID.jpg").putFile(mfileImage);
   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
   String downloadurl = await taskSnapshot.ref.getDownloadURL();
   return downloadurl;
 }
 saveItemInfo(String downloadUrl) {
   final itemsRef = Firestore.instance.collection("Shop Name Plate");
   itemsRef.document(profileID).setData({
     
     "Shop Name": _shopnameEditingController.text.trim(),
     "Your Address": _addressEditingController.text.trim(),
     "Phone Number": _phoneEditingController.text.trim(),
     "publishDate": DateTime.now(),
     "thumnailUrl": downloadUrl,
   });

   setState(() {
     file = null;
     uploading = false;
     profileID = DateTime.now().millisecondsSinceEpoch.toString();
     _shopnameEditingController.clear();
     _addressEditingController.clear();
     _phoneEditingController.clear();
   });
 }
  }