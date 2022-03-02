import 'dart:convert';
import 'dart:io';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Mazadlogic {
  var contexta;

  Mazadlogic(BuildContext context) {
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
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }

  getcomments(id)async{
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = "https://azz-app.com/api/getAuction/"+id.toString();
      var token = sharedPreferences.getString("token");
      var responsea = await http.get(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      } );
      var body = jsonDecode(responsea.body);
      List comments = body["data"]["comments"];
      return comments;
    }
  addcomm(GlobalKey<FormState> key, comm,price,id)async{
    if(key.currentState.validate()) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = "https://azz-app.com/api/postAuction";
      var token = sharedPreferences.getString("token");
      print(token);
      alertwait();
      var data =  {
        "price" : price.toString(),
        "comment": comm.toString(),
        "auction_id": id.toString(),
      };
      var responsea = await http.post(Uri.parse(url), body:data,headers: {
        'Authorization': 'Bearer $token',
      } );
      Navigator.of(contexta).pop("dialog");
      var body = jsonDecode(responsea.body);
          if (body["status"] == true) {
            Alertdialogazz.alert(contexta,body["msg"]);
          }
    else {
            Alertdialogazz.alert(contexta,body["msg"]);
          }
    return null;
        }
  }
}