import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/alertdialog.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Addcuponlogic {
  var contexta;

  Addcuponlogic(BuildContext context) {
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
  editcupon(GlobalKey<FormState> key,code, value , services,id,servicetype,num)async {
    if (key.currentState.validate()) {
      if (services.length == 0&&servicetype!="اماكن") {
        Alertdialogazz.alert(contexta, "يجب اختيار المنتجات التي يشملها الكويون");
      } else {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/updateCoupon/"+id.toString();
        var token = sharedPreferences.getString("token");
        print(token);
        alertwait();
        var data ;
        if(servicetype.toString() =="اماكن") {
          data = {
            "code": code.toString(),
            "value": value.toString(),
            "min_day_count": num.toString()
          };
        }
        else{
          data = {
            "code": code.toString(),
            "value": value.toString(),
            "services": services.toString().substring(1, services
                .toString()
                .length - 1)
          };
        }
        var responsea = await http.post(Uri.parse(url), body:data,headers: {
          'Authorization': 'Bearer $token',
        } );
        var body = jsonDecode(responsea.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"] == true) {
          Alertdialogazz.alertservices(contexta, body["msg"]);
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }
    }
  }
  addcupon(GlobalKey<FormState> key,code, value , services,servicetype,num)async {
    if (key.currentState.validate()) {
      if (services.length == 0 && servicetype !="اماكن") {
        Alertdialogazz.alert(contexta, "يجب اختيار المنتجات التي يشملها الكويون");
      } else {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/addCoupon";
        var token = sharedPreferences.getString("token");
        alertwait();
        var data ;
        if(servicetype.toString() =="اماكن") {
          data = {
            "code": code.toString(),
            "value": value.toString(),
            "min_day_count": num.toString()
          };
        }
        else{
          data = {
            "code": code.toString(),
            "value": value.toString(),
            "services": services.toString().substring(1, services
                .toString()
                .length - 1)
          };
        }
        var responsea = await http.post(Uri.parse(url), body:data,headers: {
          'Authorization': 'Bearer $token',
        } );
        var body = jsonDecode(responsea.body);
            Navigator.of(contexta).pop("dialog");
            if (body["status"] == true) {
              Alertdialogazz.alertservices(contexta, body["msg"]);
            }
            else {
              Alertdialogazz.alert(contexta, body["msg"]);
            }
      }
    }
  }
}