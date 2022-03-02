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
class Showpagelogic {
  var contexta;
  Showpagelogic(BuildContext context) {
    contexta = context;
  }
 void navigate() {
    Navigator.of(contexta).pop();
  }
  alertwait(){
   return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessage(message) {
   return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text(message,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop();
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  getshowpage(id,subcategories)async{
    var url;
    if(subcategories !=null){
      url = "https://azz-app.com/api/providers/"+"$id"+"/1";
    }
    else{
      url = "https://azz-app.com/api/providers/"+"$id"+"/0";
    }
    print(url);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url),headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(token);
    var body = jsonDecode(response.body);
    return body["providers"];
  }
  getshowketchins(subcategories)async{
    List ketchins= [];
    List cookers = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    for(int g = 0 ; g<subcategories.length ; g++){
      var id= subcategories[g]["ID"].toString();
      var url = "https://azz-app.com/api/providers/"+"$id"+"/1";
      var response = await http.get(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      if(subcategories[g]["Name"].toString().trim() == "طهاه"){
        cookers = body["providers"];
      }
      else{
        ketchins= body["providers"];
      }
    }
    return {"1" : cookers,"2": ketchins};
  }
  addtofav(id,Id,subcategories,context,ketchi)async{
    var url = "https://azz-app.com/api/addTofav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    },body: {"product_id": id.toString()});
    var body = jsonDecode(response.body);
    print(body);
    Navigator.of(context).pop("dialog");
    if(body["status"].toString() == "true"){
      alertmessage(body["msg"]);
       await Provider.of<Notifires>(contexta, listen: false).getdatashowpage(
            Id, subcategories, contexta);
      }
    else{
      alertmessage(body["msg"]);
    }
    //هون في تخبيص
  }
  addtofavp(id,Id,subcategories,context,ketchi)async{
    var url = "https://azz-app.com/api/addTofav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    },body: {"product_id": id.toString()});
    var body = jsonDecode(response.body);
    print(body);
    Navigator.of(context).pop("dialog");
    if(body["status"].toString() == "true"){
      alertmessage(body["msg"]);
     await Provider.of<Notifires>(contexta, listen: false).updatepalce(context);
    }
    else{
      alertmessage(body["msg"]);
    }
    //هون في تخبيص
  }
  addtofavpalces(id,context)async{
    var url = "https://azz-app.com/api/addTofav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    },body: {"place_id": id.toString()});
    var body = jsonDecode(response.body);
    print(body);
    if(Navigator.canPop(context)){
      Navigator.of(context).pop("dialog");
    }
    if(body["status"].toString() == "true"){
      alertmessage(body["msg"]);
     await Provider.of<Notifires>(contexta, listen: false).updatepalce(context);
    }
    else{
      alertmessage(body["msg"]);
    }
    //هون في تخبيص
  }
  cancelfav(id,context,type)async{
    var url = "https://azz-app.com/api/addTofav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response ;
    if(type.toString() =="اماكن"){
      response= await http.post(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      },body: {"place_id": id.toString()});
    }else{
      response= await http.post(Uri.parse(url),headers: {
        'Authorization': 'Bearer $token',
      },body: {"product_id": id.toString()});
    }
    var body = jsonDecode(response.body);
    print(body);
    Navigator.of(context).pop("dialog");
    if(body["status"].toString() == "true"){
      alertmessage(body["msg"]);
      Provider.of<Notifires>(contexta,listen: false).getfav(context);
    }
    else{
      alertmessage(body["msg"]);
    }
    //هون في تخبيص
  }

}