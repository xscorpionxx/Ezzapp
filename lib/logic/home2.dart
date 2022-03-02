import 'dart:convert';
import 'dart:io';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alertdialog.dart';
import 'mainlogic.dart';
class Home2logic {
  var contexta;
  Home2logic(BuildContext context) {
    contexta = context;
  }
  var stringa;

  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  String validatemobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يجب ترك الحقل';
    }
    else if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
    }
    return null;
  }
  deleteservice(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
    var url ;
    if(servicetype == "مراسيل") {
      url = "https://azz-app.com/api/deleteCar/"+id.toString();
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      url = "https://azz-app.com/api/deleteService/"+id.toString();
    }
    if(servicetype == "اماكن"){
      url = "https://azz-app.com/api/deletePlace/"+id.toString();
    }
    if(servicetype == "مزاد"){
      url = "https://azz-app.com/api/deleteAuction/"+id.toString();
    }
    var token =sharedPreferences.getString("token");
    alertwait();
    var response= await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] == true){
      //alertmessage("true");
      Provider.of<Notifires>(contexta,listen: false).getservices(contexta);
    }
    else{

    }
  }
  deleteservicem(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var  url = "https://azz-app.com/api/deleteAuction/"+id.toString();
    var token =sharedPreferences.getString("token");
    alertwait();
    var response= await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] == true){
      //alertmessage("true");
      Provider.of<Notifires>(contexta,listen: false).getmazads(contexta);
    }
    else{

    }
  }
  deletecupon(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz-app.com/api/deleteCoupon/"+id.toString();
    var token =sharedPreferences.getString("token");
    alertwait();
    var response= await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] == true){
      alertmessagedelete(body2["msg"].toString());
    }
    else{

    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessagedelete(message){
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم الامر بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
                Provider.of<Notifires>(context,listen: false).getcupon(contexta);
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  alertmessagego(message){
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
                Navigator.of(contexta).popUntil((route) => route.isFirst);
                Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
                  return Home2();
                }));
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  parsephoto(photo) {
    String base = base64Encode(photo.readAsBytesSync());
    return base;
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  sendinfocommesion( photo ,collection,date,note) async{
      if(photo ==null){
        Alertdialogazz.alert(contexta,"يجب اختيار صورة التحويل للمناسبة" );
      }
      else {
        if(collection.toString() !=""){
          if(date !=null){
            if(note.toString() != "") {
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              var url = "https://azz-app.com/api/add_collect";
              var token = sharedPreferences.getString("token");
              print(token);
              alertwait();
              var request = new http.MultipartRequest("POST", Uri.parse(url));
              request.fields["collection"] = collection.toString();
              request.fields["date"] = date.toString();
              request.fields["note"] = note.toString();
              request.files.add(await http.MultipartFile.fromPath("photo",
                  photo.path));
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              var response = await request.send().then((value) {
                value.stream.transform(utf8.decoder).listen((event) async {
                  var body = jsonDecode(event);
                  print(body);
                  Navigator.of(contexta).pop("dialog");
                  if (body["status"] == true) {
                    alertmessagego(body["msg"]);
                  }
                  else {
                    Alertdialogazz.alert(contexta,body["msg"] );
                  }
                });
              });
            }
            else{
              Alertdialogazz.alert(contexta,"يجب كتابة رقم التحويل" );
            }
  }else{
            Alertdialogazz.alert(contexta,"يجب اختيار تاريخ التحويل" );
            }
        }else{
          Alertdialogazz.alert(contexta,"يجب كتابة قيمة التحويل" );

    }
      }

  }
  addpromocode()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/myOrder";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var profiledata = body2["data"];
  }
  getdata()async{
    var url = "https://azz-app.com/api/home";
    alertwait();
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    var categories = body["categories"]["cats"];
    var banner = body["categories"]["banners"];
    Navigator.of(contexta).pop("dialog");
    return {"categories":categories, "banner":banner};
  }
  getprofiledata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/Data-Edit-User";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var profiledata = body2["data"];
    return {"profiledata" : profiledata};
  }
  getservices()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url;
    var servicetype = sharedPreferences.getString("servicetype");
    if(servicetype == "مراسيل") {
     url = "https://azz-app.com/api/getCars";
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      url = "https://azz-app.com/api/getServices";
    }
    if(servicetype == "اماكن"){
      url = "https://azz-app.com/api/getPlaces";
    }
    if(servicetype == "مزاد"){
      url = "https://azz-app.com/api/getAuctions";
    }
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var services = body["data"];
    print(services.toString());
    return  services;
  }
  getmazads()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url = "https://azz-app.com/api/getAuctions";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var services = body["data"];
    return  services;
  }
  getcupons()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url = "https://azz-app.com/api/getCoupons";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var cupons = body["data"];
    return  cupons;
  }
  makeordermarsol(id,offer,desc)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/makeMarsolOrder";
    var response2 = await http.post(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    },body: {"order_id" :id.toString(),"offer" : offer.toString(),"desc" :desc.toString()});
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] ==true){
      Alertdialogazz.alert(contexta,body2["msg"] );
      await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
    }
  }
  getreqsmarasil()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url = "https://azz-app.com/api/marsolOrders";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var data = body["data"];
    return  data;
  }
  getreqs()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
   //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDQyMzc5NjEsIm5iZiI6MTY0NDIzNzk2MSwianRpIjoiUFJ3Z0xBaG5VU3hNS0dreSIsInN1YiI6MTI5LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.h51VAKyVAjnIKF-ApXqHN4X-Sn6adztYKwf4wsphxko";
    var url = "https://azz-app.com/api/provider_orders";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var data = body["data"];
    return  data;
  }
  getreqsevents()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDQyMzc5NjEsIm5iZiI6MTY0NDIzNzk2MSwianRpIjoiUFJ3Z0xBaG5VU3hNS0dreSIsInN1YiI6MTI5LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.h51VAKyVAjnIKF-ApXqHN4X-Sn6adztYKwf4wsphxko";
    var url = "https://azz-app.com/api/eventsOrder";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    var data = body["data"];
    return  data;
  }
  acceptreq(id,type)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDQyMzc5NjEsIm5iZiI6MTY0NDIzNzk2MSwianRpIjoiUFJ3Z0xBaG5VU3hNS0dreSIsInN1YiI6MTI5LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.h51VAKyVAjnIKF-ApXqHN4X-Sn6adztYKwf4wsphxko";
    if(type=="1"){
      var url = "https://azz-app.com/api/provider_acceptOrder";
      alertwait();
      var response = await http.post(Uri.parse(url) ,headers: {
        'Authorization': 'Bearer $token',
      },body: {"eventId"  : id.toString(),"orderType" : "1"});
      print(response);
      var body = jsonDecode(response.body);
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      if(body["status"].toString() == "true"){
        Alertdialogazz.alert(contexta, body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
      else{
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }
    else{
      var url = "https://azz-app.com/api/provider_acceptOrder";
      alertwait();
      var response = await http.post(Uri.parse(url) ,headers: {
        'Authorization': 'Bearer $token',
      },body: {"order_id"  : id.toString(),"orderType" : "0"});
      var body = jsonDecode(response.body);
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      if(body["status"].toString() == "true"){
        Alertdialogazz.alert(contexta, body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
      else{
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }
  }
  completereq(id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDQyMzc5NjEsIm5iZiI6MTY0NDIzNzk2MSwianRpIjoiUFJ3Z0xBaG5VU3hNS0dreSIsInN1YiI6MTI5LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.h51VAKyVAjnIKF-ApXqHN4X-Sn6adztYKwf4wsphxko";
    var url = "https://azz-app.com/api/deliveryOrder";
    alertwait();
    var response = await http.post(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    },body: {"order_id"  : id.toString()});
    var body = jsonDecode(response.body);
    if(Navigator.canPop(contexta)){
      Navigator.of(contexta).pop("dialog");
    }
    if(body["status"].toString() == "true"){
      Alertdialogazz.alert(contexta, body["msg"]);
      await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
    }
    else{
      Alertdialogazz.alert(contexta, body["msg"]);
    }
  }
  cancelreq(id,type)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDQyMzc5NjEsIm5iZiI6MTY0NDIzNzk2MSwianRpIjoiUFJ3Z0xBaG5VU3hNS0dreSIsInN1YiI6MTI5LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.h51VAKyVAjnIKF-ApXqHN4X-Sn6adztYKwf4wsphxko";
    if(type =="1"){
      var url = "https://azz-app.com/api/provider_cancelOrder";
      alertwait();
      var response = await http.post(Uri.parse(url) ,headers: {
        'Authorization': 'Bearer $token',
      },body: {"eventId"  : id.toString(),"orderType" : "1"});
      var body = jsonDecode(response.body);
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      if(body["status"].toString() == "true"){
        Alertdialogazz.alert(contexta, body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
      else{
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }else{
      var url = "https://azz-app.com/api/provider_cancelOrder";
      alertwait();
      var response = await http.post(Uri.parse(url) ,headers: {
        'Authorization': 'Bearer $token',
      },body: {"order_id"  : id.toString(),"orderType" : "0"});
      var body = jsonDecode(response.body);
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      if(body["status"].toString() == "true"){
        Alertdialogazz.alert(contexta, body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
      else{
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }
  }
  productstatus(status,id,contexta)async{
    var url = "https://azz-app.com/api/productStatus";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    },body: {"product_id": id.toString() ,"status" : status.toString() =="1" ? "0":"1" });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body["status"].toString() == "true"){
        Provider.of<Notifires>(contexta, listen: false).getservices(contexta);
    }
    else{
      Alertdialogazz.alert(contexta,body["msg"]);
    }
    //هون في تخبيص
  }
  providerstatus(status,contexta)async{
    var url = "https://azz-app.com/api/storeStatus";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var response = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token',
    },body: {"status" : status.toString() =="1" ? "0":"1" });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body["status"].toString() == "true"){
      Provider.of<Notifires>(contexta, listen: false).gethome_provider(contexta);
    }
    else{
      Alertdialogazz.alert(contexta,body["msg"]);
    }
    //هون في تخبيص
  }
  getrewards(histfrom,histto)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url = "https://azz-app.com/api/rewards";
    var response = await http.post(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    } ,body: {
      "start" : histfrom.toString(),
      "end" : histto.toString()
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    var data = body["data"];
    return  data;
  }
  showhist(type){
    var value = DateTime.now().toString().substring(0,10);
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child: CalendarDatePicker(initialDate:DateTime.now(), firstDate: DateTime.now().subtract(Duration(days: 100000)), lastDate: DateTime.now().add(Duration(days: 10000)),onDateChanged: (val){
                            value= val.toString().substring(0,10);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
                Provider.of<Notifires>(context,listen: false).homeproviderhist(type, value);
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  getmyorders()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/myOrder";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var profiledata = body2["data"];
    return  profiledata;
  }
  gethomeprovider()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/provider_home";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var url3 = "https://azz-app.com/api/appInfo";
    var response3 = await http.get(Uri.parse(url3));
    var body3 = jsonDecode(response3.body);
    var data ={"1" : body2["data"],"2":body3["categories"]["pledge"]};
    return  data;
  }
  getfav(context)async{
    var url = "https://azz-app.com/api/fav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    alertwait();
   var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    Navigator.of(context).pop("dialog");
    var body = jsonDecode(response.body);
    print('g');
    print(body);
    return body["fav"];
  }
}