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

import 'alertdialog.dart';
class Addservice2logic {
  var contexta;

  Addservice2logic(BuildContext context) {
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
  editservice2( ida,GlobalKey<FormState> key,name,price , sale_price , desc,model,id , licsence,name2,id2,licsence2,phone,photoa)async{
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/updateCar/"+ida.toString();
        var token = sharedPreferences.getString("token");
        print(token);
        alertwait();
        var request = new http.MultipartRequest("POST", Uri.parse(url));
        request.fields["desc"] = desc.toString();
        request.fields["name"] = name.toString();
        request.fields["brand"] = model.toString();
        request.fields["number"] = id.toString();
        request.fields["car_license"] = licsence.toString();
        request.fields["driver_name"] = name2.toString();
        request.fields["national_number"] = id2.toString();
        request.fields["driver_license"] = id2.toString();
        request.fields["phone"] = phone.toString();
        request.fields["sale_price"] = sale_price.toString();
        request.fields["price"] = price.toString();
        if(photoa ==null){

        }
        else {
          request.files.add(await http.MultipartFile.fromPath("photo",
              photoa.path));
        }
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        var response =  await request.send().then((value){
          value.stream.transform(utf8.decoder).listen(( event) async{
            var body = jsonDecode(event);
            print(body);
            Navigator.of(contexta).pop("dialog");
            if (body["status"] == true) {
              Alertdialogazz.alertservices(contexta, body["msg"]);
            }
            else {
              Alertdialogazz.alert(contexta, body["msg"]);
            }
          });
        });
      }
  addservice2(GlobalKey<FormState> key,name,price , sale_price , desc,model,id , licsence,name2,id2,licsence2,phone,photoa)async{
    if(key.currentState.validate()) {
      if(photoa ==null){
        Alertdialogazz.alert(contexta,"يجب اختيار الصورة للمناسبة" );
      }
      else {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var url = "https://azz-app.com/api/addCar";
        var token = sharedPreferences.getString("token");
        print(token);
        alertwait();
        var request = new http.MultipartRequest("POST", Uri.parse(url));
        request.fields["desc"] = desc.toString();
        request.fields["name"] = name.toString();
        request.fields["brand"] = model.toString();
        request.fields["number"] = id.toString();
        request.fields["car_license"] = licsence.toString();
        request.fields["driver_name"] = name2.toString();
        request.fields["national_number"] = id2.toString();
        request.fields["driver_license"] = id2.toString();
        request.fields["phone"] = phone.toString();
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
            Navigator.of(contexta).pop("dialog");
            if (body["status"] == true) {
              Alertdialogazz.alertservices(contexta,body["msg"] );
            }
            else {
              Alertdialogazz.alert(contexta,body["msg"] );
            }
          });
        });
      }
    }
  }
}