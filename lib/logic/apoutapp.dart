import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class Applogic {
  var contexta;
  Applogic(BuildContext context) {
    contexta = context;
  }
  String validateemail(String value) {
    RegExp exp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (exp.hasMatch(value)) {
      return null;
    }
    else {
      return 'البريد الالكتروني خاطآ';
    }
  }
  String validate(String value){
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  void navigate() {
    Navigator.of(contexta).pop();
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  void gotofacebook(url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  void gotogoogle(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void gototwiter(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void gotoin(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  getabout()async {
    var url = "https://azz-app.com/api/appInfo";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    return {"about" : body["categories"]["about"] ,"l" : body["categories"]["linkedin"]
      ,"f":body["categories"]["facebook"]  , "g":body["categories"]["google"]  ,
      "t":body["categories"]["twitter"] };
  }
  getpolicy()async {
    var url = "https://azz-app.com/api/appInfo";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    return body["categories"]["useage_policy"];
  }
  getterms()async {
    var url = "https://azz-app.com/api/appInfo";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    return body["categories"]["terms_and_conditions"];
  }
  cancelfav(id,Id){

  }
}