import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemModel {
  String title;
  String stock;
  Timestamp publishDate;
  String thumnailUrl;
  int price;

 ItemModel({
 this.title,
  this.stock, 
  this.publishDate,
  this.thumnailUrl,
 });

 ItemModel.fromJson(Map<String, dynamic> json) {
   title = json['title'];
   stock = json['stock'];
   publishDate = json['publishDate'];
   thumnailUrl = json['thumnailUrl'];
   price = json['price'];
 }

 Map<String, dynamic> json() {
   
 } 
}
