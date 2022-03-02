import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Chatlogic{
  var contexta;
  Chatlogic(BuildContext context) {
    contexta = context;
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  sendfirbasemessage(providerid,text,rname,sname)async{
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var userid = sharedPreferences.getString("id");
    FirebaseFirestore.instance
        .collection('chats')
        .doc(userid.toString())
        .collection('messages')
        .add({"provider_id" : providerid.toString() , "user_id" : userid.toString(),
              "message" : text,
    "SenderID" : userid.toString(),
      "sender" : "User",
    "ReciveName" :rname.toString(),
    "ReciveID" : providerid.toString(),
    "created_at" : DateTime.now().toString(),
     "time" : DateTime.now(),
    "SenderName" : sname.toString()})
        .then((value) {
    }).catchError((error) {
      print(error);
    });
    FirebaseFirestore.instance
        .collection('chats')
        .doc(providerid.toString())
        .collection('messages')
        .add({"provider_id" : providerid.toString() , "user_id" : userid.toString(),
      "message" : text,
      "SenderID" : userid.toString(),
      "ReciveName" :rname.toString(),
      "sender" : "User",
      "ReciveID" : providerid.toString(),
      "created_at" : DateTime.now().toString(),
      "time" : DateTime.now(),
      "SenderName" : sname.toString()})
        .then((value) {
    }).catchError((error) {
      print(error);
    });
  }
  sendfirebasemessage2(providerid,userid,text,rname,sname){
    FirebaseFirestore.instance
        .collection('chats')
        .doc(userid.toString())
        .collection('messages')
        .add({"provider_id" : providerid.toString() , "user_id" : userid.toString(),
      "message" : text,
      "SenderID" : userid.toString(),
      "ReciveName" :rname.toString(),
      "sender" : "Provider",
      "ReciveID" : providerid.toString(),
      "created_at" : DateTime.now().toString(),
      "time" : DateTime.now(),
      "SenderName" : sname.toString()})
        .then((value) {
    }).catchError((error) {
      print(error);
    });
    FirebaseFirestore.instance
        .collection('chats')
        .doc(providerid.toString())
        .collection('messages')
        .add({"provider_id" : providerid.toString() , "user_id" : userid.toString(),
      "message" : text,
      "SenderID" : providerid.toString(),
      "ReciveName" :rname.toString(),
      "ReciveID" : userid.toString(),
      "sender" : "Provider",
      "created_at" : DateTime.now().toString(),
      "time" : DateTime.now(),
      "SenderName" : sname.toString()})
        .then((value) {
    }).catchError((error) {
      print(error);
    });
  }
  getlistmessage(user_id){
    FirebaseFirestore.instance
        .collection('chats')
        .doc(user_id)
        .collection('messages')
        .orderBy('created_at')
        .snapshots()
        .listen((event) {
      List messages = [];
      event.docs.forEach((element) {
        print(element);
        messages.add(element.data());
      });
    });
  }
}