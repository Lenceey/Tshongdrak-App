import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:TshongdrakApp/Widget/loadingWidget.dart';

class DisplayAdminUploadFormScreen extends StatefulWidget {
  @override
  _DisplayAdminUploadFormScreenState createState() => _DisplayAdminUploadFormScreenState();
}

class _DisplayAdminUploadFormScreenState extends State<DisplayAdminUploadFormScreen> {

   File image;
  String shopId = DateTime.now().millisecondsSinceEpoch.toString();
    TextEditingController _shopnameEditingController = TextEditingController();
   TextEditingController _shopkeepernameEditingController = TextEditingController();
   TextEditingController _addressEditingController = TextEditingController();
    bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return image == null ? displayAdminHomeScreen() : displayAdminUploadFormScreen();
      }
       displayAdminUploadFormScreen() {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.blue, Colors.red],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                )
              ),
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white),
             onPressed: clearInfo),
            title: Text('New Product', style: TextStyle(
              color: Colors.black, fontSize: 24.0, 
              fontWeight: FontWeight.bold)),
            actions: [
              FlatButton(
              onPressed: uploading ? null : ()=> uploadAndSaveImage(),
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
                  height: 100.0,
                  width: MediaQuery.of(context).size.width * 100.0,
                  child: Center(
                   child: AspectRatio(
                     aspectRatio: 16/9,
                     child: Container(
                       decoration: BoxDecoration(image: DecorationImage(image: FileImage(image), fit: BoxFit.cover)),
                     ),
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                ListTile(
                  leading: Icon(Icons.perm_device_info, color: Colors.blue),
                  title: Container(
                    width: 250.0,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _shopnameEditingController,
                      decoration: InputDecoration(
                        hintText: "shop name",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.blue),
    
                ListTile(
                  leading: Icon(Icons.perm_device_info, color: Colors.blue),
                  title: Container(
                    width: 250.0,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _shopkeepernameEditingController,
                      decoration: InputDecoration(
                        hintText: "Shopkeeper",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.blue),
                ListTile(
                  leading: Icon(Icons.perm_device_info, color: Colors.blue),
                  title: Container(
                    width: 250.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      controller: _addressEditingController,
                      decoration: InputDecoration(
                        hintText: "address",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.blue),
    
              ],
          ),
        );
    }
    
    clearInfo() {
        setState(() {
          image = null;
          _shopnameEditingController.clear();
          _shopkeepernameEditingController.clear();
          _addressEditingController.clear();
        });
      }
    
    uploadAndSaveImage() async{
        setState(() {
          uploading = true;
        });
    
       String imageDownloadUrl = await upload(image);
    
      
      saveItemInfo(imageDownloadUrl);
         Fluttertoast.showToast(msg: 'Added',textColor: Colors.white);
        }
      
     Future<String> upload(ufileImage) async {
       final StorageReference storageReference = FirebaseStorage.instance.ref().child("ShopImage");
       StorageUploadTask uploadTask = storageReference.child("ShopImage $shopId.jpg").putFile(ufileImage);
       StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
       String downloadurl = await taskSnapshot.ref.getDownloadURL();
       return downloadurl;
     }
    
     saveItemInfo(String downloadUrl) {
       final itemsRef = Firestore.instance.collection("ShopImage");
       itemsRef.document(shopId).setData({
         "shopname": _shopnameEditingController.text.trim(),
         "shopkeepername": _shopkeepernameEditingController.text.trim(),
         "address": _addressEditingController.text.trim(),
         "publishDate": DateTime.now(),
         "thumnailUrl": downloadUrl,
       });
    
       setState(() {
         image = null;
         uploading = false;
         shopId = DateTime.now().millisecondsSinceEpoch.toString();
         _shopnameEditingController.clear();
         _shopkeepernameEditingController.clear();
         _addressEditingController.clear();
       });
      }
    
      displayAdminHomeScreen() {}
}
