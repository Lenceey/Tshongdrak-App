import 'dart:io';
import 'package:TshongdrakApp/Shopkeeper%20Dashoboard/order.dart';
import 'package:TshongdrakApp/Widget/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:TshongdrakApp/Shopkeeper Dashoboard/Sdawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DisplayShop.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Page { dashboard, manage }

class ShopHomeScreen extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<ShopHomeScreen>
 {
     final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser()).uid;
  }
        var db;
  void initState() {
    db = Firestore.instance.collectionGroup("items").snapshots();
    super.initState();
  }

  File file;
   TextEditingController _priceEditingController = TextEditingController();
   TextEditingController _titleEditingController = TextEditingController();
   TextEditingController _shortInfoEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;
 

  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.blue;
  MaterialColor notActive = Colors.grey;
  

  @override
  Widget build(BuildContext context) {
     return file == null ? displayAdminHomeScreen() : displayAdminUploadFormScreen();
  }
  
  displayAdminHomeScreen(){
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.brown,
        ),
        body: _loadScreen(),
        drawer: ShopMainDrawer(),
        );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
           
            Expanded(
              child: new ListView(
           children: <Widget>[
             Container(
                height: 500.0,
              child: StreamBuilder(
          stream: db,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.documents;
                 return  Container(
                  padding: EdgeInsets.only(left: 0.1, right: 0,),
                  child: Card(
                    child: Row(
                      children: <Widget>[
                         Padding(padding: EdgeInsets.only(top: 15)),
                        Image.network(
                          userDocument[index].data["thumnailUrl"].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                     child: Column(
                      children: <Widget>[
                         Text(userDocument[index].data["title"]),
                         Text(userDocument[index].data["stock"]),
                         Divider(),
                         
                          Text(userDocument[index].data["price"]),
                          IconButton(
                              icon: Icon(Icons.delete, size: 10, color: Colors.black,),
                              padding: EdgeInsets.only(left: 200, right: 0),
                               onPressed: () {
                                _deleteTask();
                               },
                               ),
                      ],
                      ),
                        ),
                      
                   
                      ],
                    ),
                  ),
                 );
              },
            ) : Container();
          }
      ),
       ),
      ],
      ),
            ),
          ],
        );
        break;



      case Page.manage:
        return ListView(
          children: <Widget>[      
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap:()=> takeImage(context),
            ),
            Divider(),
              ListTile(
              leading: Icon(Icons.add),
              title: Text("Order"),
              onTap: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => Order()),
                 );
              },
            ),  
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  takeImage(mContext) {
    return showDialog(
      context: mContext,
      builder: (con) {
          return SimpleDialog(
            title: Text('Upload Product Image', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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

  capturePhotoWithCamera() async {
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

 displayShopFormScreen() {
   Container(
     child:DisplayAdminUploadFormScreen() ,
   );
 }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.brown],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
            )
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white),
         onPressed: clearFormInfo),
        title: Text('New Product', style: TextStyle(
          color: Colors.white, fontSize: 24.0, 
          fontWeight: FontWeight.bold)),
        actions: [
          FlatButton(
          onPressed: 
          uploading ? null : ()=> uploadImageAndSaveItemInfo(),
          child: Text("Add", style: TextStyle(
            color: Colors.white, fontSize: 16.0, 
            fontWeight: FontWeight.bold,)),
          ),
          ],
      ),

      body: ListView(
          children: [
            uploading ? linearProgress() : Text(""),
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width * 200.0,
              child: Center(
               child: AspectRatio(
                 aspectRatio: 16/9,
                 child: Container(
                   decoration: BoxDecoration(image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)),
                 ),
              ),
            ),
            ),
            Padding(padding: EdgeInsets.only(top: 12.0)),
            ListTile(
              leading: Icon(Icons.change_history, color: Colors.brown),
              title: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _titleEditingController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.blue),

            ListTile(
              leading: Icon(Icons.change_history, color: Colors.brown),
              title: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _shortInfoEditingController,
                  decoration: InputDecoration(
                    hintText: "Stock",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.blue),
            ListTile(
              leading: Icon(Icons.change_history, color: Colors.brown),
              title: Container(
                width: 250.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  controller: _priceEditingController,
                  decoration: InputDecoration(
                    hintText: "Price",
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
  
  clearFormInfo()
  {
    setState(() {
      file = null;
      _priceEditingController.clear();
      _shortInfoEditingController.clear();
      _titleEditingController.clear();
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
   final StorageReference storageReference = FirebaseStorage.instance.ref().child("Items");
   StorageUploadTask uploadTask = storageReference.child("Product $productId.jpg").putFile(mfileImage);
   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
   String downloadurl = await taskSnapshot.ref.getDownloadURL();
   return downloadurl;
 }

 saveItemInfo(String downloadUrl) async{
   final itemsRef = Firestore.instance.collection("items");
   itemsRef.document((await _auth.currentUser()).uid).setData({
     
     "stock": _shortInfoEditingController.text.trim(),
     "price": _priceEditingController.text.trim(),
     "title": _titleEditingController.text.trim(),
     "publishDate": DateTime.now(),
     "thumnailUrl": downloadUrl,
     "productId": (await _auth.currentUser()).uid,
   });

   setState(() {
     file = null;
     uploading = false;
     _titleEditingController.clear();
     _shortInfoEditingController.clear();
     _priceEditingController.clear();
   });
 }
 _deleteTask()  async{
        CollectionReference collectionReference = Firestore.instance.collection('items');
        QuerySnapshot querySnapshot = await collectionReference.getDocuments();
          querySnapshot.documents[0].reference.delete();
          Fluttertoast.showToast(msg: 'Deleted',textColor: Colors.white);
    }
 }