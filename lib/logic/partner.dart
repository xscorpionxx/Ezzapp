import 'dart:convert';
import 'dart:io';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Partenerlogic {
  var contexta;

  Partenerlogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  void navigatetomain() {
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home2();
        }));
  }
  void navigatetosignup() {
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Signup();
        }));
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  getpartners()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/partOfSuccess";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var data = body2["data"]["users"];
    return  data;
  }
}