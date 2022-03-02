import 'dart:convert';
import 'dart:io';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Detailpagelogic {
  var contexta;
  Detailpagelogic(BuildContext context) {
    contexta = context;
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
  getdetailpage(id)async{
    var url = "https://azz-app.com/api/productDetails/"+"$id";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    return body["productDetails"];
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  makeeventorder(GlobalKey<FormState> key ,store_id,event_type,event_date,event_time,event_address ,event_details)async{
    if(key.currentState.validate()) {
      if (event_date != null&&event_time!=null) {
        var url = "https://azz-app.com/api/MakeEventOrder";
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var token = sharedPreferences.getString("token");
        alertwait();
        var data = {
          "store_id": store_id.toString(),
          "event_type": event_type,
          "event_date": event_date,
          "event_time" : event_time,
          "event_address" : event_address,
          "event_details" : event_details
        };
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"].toString() == "true") {
          Navigator.of(contexta).pop();
          Alertdialogazz.alert(contexta,body["msg"]);
        }
        else {
          Alertdialogazz.alert(contexta,body["msg"]);
        }
      }else{
        Alertdialogazz.alert(contexta,"يجب اختيار التاريخ والوقت بالشكل المناسب");
      }
    }
  }
  addtocart(id , plus)async{
      alertwait();
      var url = "https://azz-app.com/api/addToCart";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      print(token);
      var data;
      if(plus){
         data = {
          "product_id":id.toString(),
          "product_qt": "+1"
        };
      }
      else{
        data = {
          "product_id":id.toString(),
          "product_qt": "-1"
        };
      }
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: data);
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      var body = jsonDecode(response.body);
      print(body);
      if (body["status"].toString().trim() == "true") {
        return true;
      }
      else {
        Alertdialogazz.alert(contexta,body["msg"]);
         return false;
      }
    }

}