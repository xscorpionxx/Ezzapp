import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Addservicelogic {
  var contexta;

  Addservicelogic(BuildContext context) {
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
    print("go");
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
  editservice(id,GlobalKey<FormState> key,name , desc , price, sale_price , imageedit)async{
    if(key.currentState.validate()) {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/updateService/"+ id.toString();
        var token = sharedPreferences.getString("token");
        var request = new http.MultipartRequest("POST", Uri.parse(url));
        request.fields["desc"] = desc.toString();
        request.fields["name"] = name.toString();
        request.fields["sale_price"] = sale_price.toString();
        request.fields["price"] = price.toString();
        if(imageedit ==null) {}
        else {
          request.files.add(await http.MultipartFile.fromPath("photo",
              imageedit.path));
        }
    request.headers.addAll({
    'Authorization': 'Bearer $token',
    });
        alertwait();
    var response =  await request.send().then((value){
    value.stream.transform(utf8.decoder).listen(( event) async{
    var body = jsonDecode(event);
    print(body);
    Navigator.of(contexta).pop();
    if (body["status"] == true) {
      Alertdialogazz.alertservices(contexta, body["msg"]);
    }
    else {
      Alertdialogazz.alert(contexta, body["msg"]);
    }
    });
    });
  }
  }
  addservicea(GlobalKey<FormState> key,name , desc , price, sale_price ,photoa)async{
    if(key.currentState.validate()) {
      if(photoa ==null){
        Alertdialogazz.alert(contexta, "يجب اختيار الصورة للمناسبة");
      }
      else {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/addService";
        var token = sharedPreferences.getString("token");
        print(token);
        alertwait();
        var request = new http.MultipartRequest("POST", Uri.parse(url));
        request.fields["desc"] = desc.toString();
        request.fields["name"] = name.toString();
        request.fields["sale_price"] = sale_price.toString();
        request.fields["price"] = price.toString();
        request.files.add(await http.MultipartFile.fromPath("photo",
            photoa.path));
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        var response =  await request.send().then((value){
          value.stream.transform(utf8.decoder).listen(( event) async{
            var body = jsonDecode(event);
            print(body);
            if (body["status"] == true) {
              Alertdialogazz.alertservices(contexta, "يجب اختيار الصورة للمناسبة");
            }
            else {
              Alertdialogazz.alert(contexta, "يجب اختيار الصورة للمناسبة");
            }
          });
        });
     }
}
  }
}