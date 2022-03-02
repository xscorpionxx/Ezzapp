import 'dart:convert';
import 'dart:io';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Loginlogic {
  var contexta;

  Loginlogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }

  List region1 = [];
  List region2 = [];
  List region3 = [];
  getdata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz-app.com/api/places";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    var url2 = "https://azz-app.com/api/Data-Edit-User";
    var token = sharedPreferences.getString("token");
    print(token);
    var response2 = await http.get(Uri.parse(url2), headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 =jsonDecode(response2.body);
    return {"re1" : body2["data"]["Governorate"] , "re2" : body2["data"]["City"] , "re3" : body2["data"]["Region"] , "listre1" : body["data"]};
  }
  void navigatetomain() {
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home();
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
  setlocation(re1a,re2a,re3a,region1back,region2back,region3back)async{
    var id1;
    var id2;
    var id3;
    if (re1a != "المنطقة" && re2a != "المدينة" &&
        re3a != "المحافظة") {
      for (int f = 0; region1back.length > f; f++) {
        if (region1back[f]["name"].toString().trim() == re1a) {
          id1 = region1back[f]["ID"];
        }
      }
      for (int f = 0; region2back.length > f; f++) {
        if (region2back[f]["name"].toString().trim() == re2a) {
          id2 = region2back[f]["ID"];
        }
      }
      for (int f = 0; region3back.length > f; f++) {
        if (region3back[f]["name"].toString().trim() == re3a) {
          id3 = region3back[f]["ID"];
        }
      }
      alertwait();
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = "https://azz-app.com/api/editLocation";
      var token = sharedPreferences.getString("token");
      var data = {
        "Governorate": id1.toString(),
        "City": id2.toString(),
        "Region": id3.toString()
      };
      var response = await http.post(Uri.parse(url), body: data, headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body["status"] == true) {
        Alertdialogazz.alert(contexta,body["msg"] );
        sharedPreferences.setString("region1", re1a);
        sharedPreferences.setString("region2", re2a);
        sharedPreferences.setString("region3", re3a);
      }
      else {
        Alertdialogazz.alert(contexta,body["msg"] );
      }
    }else{
      Alertdialogazz.alert(contexta,"يجب اختيار المنطقة والمدينة والمحافظة");
    }
  }
}