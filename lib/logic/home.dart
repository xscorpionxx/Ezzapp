import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/mazadshow.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/productdetail.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showimages.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'mainlogic.dart';
class Homelogic {
  var contexta;
  Homelogic(BuildContext context) {
    contexta = context;
  }
  List region1 =[];
  List region2 =[];
  List region3 =[];
  var stringa;

  // هدول الدوال مشان التأكد من الاسم وكلمة السر وباقي المعلومات
  String validateemail(String value) {
    RegExp exp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (exp.hasMatch(value)) {
      return null;
    }
    else {
      return "البريد الالكتروني خاطئ!";
    }
  }

  String validatepassword(String value) {
    stringa = value;
    if (value.length < 6) {
      return 'كلمة السر يجب أن تكون أكثر من 6 خانات';
    }
    if (value.isEmpty) {
      return 'لا يمكن أن تكون كلمة السر فارغة';
    }
    return null;
  }

  String validatepasswordre(String value) {
    if (value != stringa) {
      return 'لا يوجد تطابق بين كلمتي السر';
    }
    return null;
  }

  String validatename(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الاسم فارغ';
    }
    return null;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    else if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
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
  parsephoto(photo) {
    String base = base64Encode(photo.readAsBytesSync());
    return base;
  }
  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  void initializesnotification() async{
    var inita = AndroidInitializationSettings('@mipmap/logo');
    var init = InitializationSettings(android: inita);
    final FirebaseMessaging fire = FirebaseMessaging.instance;
        fire.getToken().then((value)async {
          print(value);
        });
    notificationsPlugin.initialize(init);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        show(message.notification.title, message.notification.body);
      }
    });
  }
  Future<void> show(title ,body)async{
    notificationsPlugin.show(0, title, body,
        await NotificationDetails(
            android:  AndroidNotificationDetails(
                'channel id',
                'channel name',
                'channel description',
                importance: Importance.max
            ),
            iOS: IOSNotificationDetails()
        ));
  }
  geteventorder()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/clientEventsOrder";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var data = body2["data"];
    print(body2["data"]);
    return  data;
  }
  makeordermarsol(id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/marsol";
    var response2 = await http.post(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    },body: {"order_id" :id.toString() });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    Alertdialogazz.alert(contexta, body2["msg"]);
    Provider.of<Notifires>(contexta, listen: false)
        .getmyorders(contexta);
  }
  void savedata(token ,name ,phone, password, email,re1,re2,re3)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("phone", phone);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("region1", re1);
    sharedPreferences.setString("region2", re2);
    sharedPreferences.setString("region3", re3);
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  getdata()async{
    var url = "https://azz-app.com/api/home";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    var url1 = "https://azz-app.com/api/appInfo";
    var response1 = await http.get(Uri.parse(url1));
    var body1 = jsonDecode(response1.body);
    var categories = body["categories"]["cats"];
    var ad = body["categories"]["ads"];
    var banner = body["categories"]["banners"];
    return {"categories":categories,"ad" : ad ,"banner" :banner , "adtime" : body1["categories"]["ads_time"].toString() };
  }
  shareapp()async{
    var url1 = "https://azz-app.com/api/appInfo";
    alertwait();
    var response1 = await http.get(Uri.parse(url1));
    var body1 = jsonDecode(response1.body);
    Navigator.of(contexta).pop("dialog");
    if (Platform.isAndroid) {
      FlutterShare.share(title: "شارك التطبيق الان",linkUrl: body1["categories"]["share_link1"]);
    } else if (Platform.isIOS) {
      FlutterShare.share(title: "شارك التطبيق الان",linkUrl: body1["categories"]["share_link2"]);
    }
  }
  getintroimages()async{
    var url1 = "https://azz-app.com/api/appInfo";
    var response1 = await http.get(Uri.parse(url1));
    var body1 = jsonDecode(response1.body);
    print(body1);
    List intro =[];
    return {"1" : body1["categories"]["introImage1"] ,
      "2" : body1["categories"]["introImage2"],
      "3" : body1["categories"]["introImage3"]};
  }
  getprofiledata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/Data-Edit-User";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var profiledata = body2["data"];
    return {"profiledata" : profiledata};
  }
  getmyorders()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/myOrder";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var data = body2["data"];
    print(body2["data"]);
    return  data;
  }
  getmarsoloffers(id)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    var url2 = "https://azz-app.com/api/getMarsolOrder/$id";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    var data = body2["mrsolOfers"];
    return  data;
  }
  deleteorder(id,type)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/delOrder/$id/$type";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"].toString()=="true"){
      Alertdialogazz.alert(contexta,body2["msg"].toString());
      if(type =="1"){
        return true;
      }
      else {
        Provider.of<Notifires>(contexta, listen: false).getmyorders(contexta);
      }
    }
    else {
      Alertdialogazz.alert(contexta, body2["msg"]);
    }
  }
  addrevieworder(id,starnum,desc)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var data = {"order_id" : id.toString() , "star_num" : starnum.toString(),"desc" : desc};
    var url2 = "https://azz-app.com/api/reviewOrder";
    var response2 = await http.post(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    },body: data);
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"].toString()=="true"){
      alertmessagereor(body2["msg"].toString());
      Provider.of<Notifires>(contexta,listen: false).getmyorders(contexta);
    }
    else {
      Alertdialogazz.alert(contexta, body2["msg"]);
    }
  }
  showreview(review){
   var levelofstar =int.parse(review[0]["star_num"].toString().trim().substring(0,1)) ;
    return showDialog( context: contexta, builder: (context) {
      return StatefulBuilder(builder: (Context , setState){
        return AlertDialog(
            content:Container(height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03) ,child: Row(children: [
                    Expanded(child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.clear,size: MediaQuery.of(context).size.height*0.03,color: Colors.black,),onPressed: (){
                      Navigator.of(context).pop("dialog");
                    },))),
                    Expanded(child: Container(alignment: Alignment.centerLeft,child: Text("تقييم الطلب",style: TextStyle(color: Colors.indigo,fontSize:14,fontWeight: FontWeight.bold),))),
                  ],),),
                  Directionality(textDirection: TextDirection.rtl,
                    child: Container(width: MediaQuery.of(context).size.width*0.4,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.centerRight ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                      if(levelofstar >i ){
                        return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Color.fromRGBO(244, 194, 27, 1),size: MediaQuery.of(context).size.width*0.05,));
                      }
                      else{
                        return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
                      }
                    }),
                    )),
                  ),
                  Container(child: Text("الوصف",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),margin:EdgeInsets.only(right: 25),alignment: Alignment.centerRight,),
                  Container(width: MediaQuery.of(context).size.width,alignment: Alignment.topRight,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin:EdgeInsets.only( left: 20,right: 20,bottom: 10),height: MediaQuery.of(context).size.height*0.1 ,child: Text(review[0]["desc"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),decoration: BoxDecoration(border: Border.all(color: Colors.lightBlueAccent),borderRadius: BorderRadius.circular(5)),)
                 ,Container(margin: EdgeInsets.only(top:5,left: 25,right: 25),
                    child: InkWell(onTap: (){
                      Navigator.of(context).pop("dialog");
                    },child: Container( width: MediaQuery.of(context).size.width*0.7,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
                  )
                ])));
      },
      );
    });
  }
  selectmarsoloffer(idorder,idmarsol)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz-app.com/api/selectMarsolOrder/$idorder/$idmarsol";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    Navigator.of(contexta).pop();
    var body2 = jsonDecode(response2.body);
    if(body2["status"].toString()=="true"){
      alertmessagemarsol(body2["msg"].toString());
      Provider.of<Notifires>(contexta,listen: false).getmyorders(contexta);
    }
    else {
      Alertdialogazz.alert(contexta, body2["msg"]);
    }
  }
  alertmessagemarsol(message) {
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
                Navigator.of(context).pop("dialog");
                Navigator.of(context).pop();
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  alertmessagereor(message) {
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
                Navigator.of(contexta).pop("dialog");
                Navigator.of(contexta).pop();
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  getfav(context)async{
    var url = "https://azz-app.com/api/fav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url),headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    return body["fav"];
  }
  ///  نظام الاعلانات
  var go ;
  var timer;
  int activeee = 0;
  double valuea =0;
  bool stop = false;
  bool done =false;
  brogress(setState,adtime,video){
    double time = (1/double.parse(adtime.toString()));
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(!stop && !done) {
        setState(() {
          valuea = valuea + time;
          if (valuea == 1) {
            stop =true;
            timer.cancel();
            Future.delayed(Duration(seconds: 1), () {
              if (video) {
                _controller.pause();
              }
              Navigator.of(contexta).pop();
            });
          }
        });
      }else{
        if(stop &&video){
          _controller.pause();
        }
      }
    });
  }
  showadd(banner,adtime,homedata,tab){
    Future.delayed(Duration(seconds: 0) , (){
      if(banner.length ==0){
        return null;
      }
      var type = banner[0]["type"].toString();
      if(type=="2"){
        try {
          return showDialog(
            barrierDismissible: false, context: contexta, builder: (context) {
            return StatefulBuilder(
                builder: (contexta, setState) {
                  brogress(setState, adtime, false);
                  return AlertDialog(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),backgroundColor: Colors.transparent,elevation: 0,insetPadding: EdgeInsets.only(top: 30),
                    contentPadding: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    content: Container(height: MediaQuery
                        .of(context)
                        .size
                        .height ,
                      child:
                      Column(
                        children: [Container(
                          child:Stack(children:[ Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.9, width: MediaQuery
                              .of(context)
                              .size
                              .width,
                              child:Container(height: MediaQuery.of(context).size.height* 0.9
                                    ,width: MediaQuery.of(context).size.width,child: banner[0]["photos"].length==0? Container():
                                  CarouselSlider.builder(options: CarouselOptions(height: MediaQuery.of(context).size.height*0.9,viewportFraction: 1,
                                      onPageChanged: (ind,reason){
                                    setState((){
                                      activeee = ind;
                                    });
                                      }
                                      ,autoPlay: false),
                                    itemBuilder: (context,index , real){
                                      return Container(
                                        child:Column(children:[ Container(height: MediaQuery.of(context).size.height*0.8,width: MediaQuery.of(context).size.width,
                                          child: FadeInImage(placeholder:AssetImage("images/logoaz.png") ,
                                              image:NetworkImage( banner[0]["photos"][activeee]),fit: BoxFit.fill,),
                                        ),
                                      Container( child: LinearProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white), value: valuea * 1,
                                      semanticsLabel: 'Linear progress indicator',),),
                                          Container(height: MediaQuery.of(context).size.height*0.05,child: Container(child:  Center(
                                            child: AnimatedSmoothIndicator(count: banner[0]["photos"].length,
                                              activeIndex:activeee ,),
                                          ) ,),)]),
                                      );//);
                                    },itemCount: banner[0]["photos"].length,),
                              ) ),Positioned(top: 30,right: MediaQuery.of(context).size.width*0.9,child: Container(child: InkWell( onTap: (){
                            stop = true;
                            Navigator.of(contexta).pop("dialog");
                          },child: Icon(Icons.close,size: 30,color: Colors.white,)),alignment: Alignment.centerRight,) ),
                            ]),
                        ),
                         // Container(alignment: Alignment.centerRight,
                          //  child: ElevatedButton(
                          //    child: Text("تخطي"), onPressed: () {
                          //     done = true;
                          //    Navigator.of(context).pop("dialog");
                          //  },),)
                        ],
                      )),
                  );
                });},
          );
        }
        catch(e){
          print(e);
        }
      }
      if(type=="3"){
        return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[ Container(margin: EdgeInsets.only(top: 10),child: InkWell( onTap: (){
                        stop = true;
                        Navigator.of(contexta).pop("dialog");
                      },child: Icon(Icons.close)),alignment: Alignment.centerRight,),
                        Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                          child:Center(
                            child: Directionality(textDirection: TextDirection.rtl,
                              child: Row(children:[
                                Container( alignment: Alignment.centerRight,child: Text("اضغط للذهاب للرابط الاتي ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                              ,Container(alignment: Alignment.centerRight ,child:InkWell(onTap: ()async{
                                  if (await canLaunch(banner[0]["url"])) {
                                    stop = true;
                                    Navigator.of(context).pop("dialog");
                                    await launch(banner[0]["url"]);
                                  } else {
                                    throw 'Could not launch';
                                  }
                                },child: Text("هنا",style: TextStyle(color: Colors.red,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))),]),
                            ),
                          )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          stop = true;
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="4"){
        return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[Container(margin: EdgeInsets.only(top: 10),child: InkWell( onTap: (){
                        stop = true;
                        Navigator.of(contexta).pop("dialog");
                      },child: Icon(Icons.close)),alignment: Alignment.centerRight,),
                        Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                            child:Center(
                              child: Directionality(textDirection: TextDirection.rtl,
                                child: Row(children:[
                                  Container( alignment: Alignment.centerRight,child: Text("اضغط للذهاب للفئة المتاحة ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                                  ,Container(alignment: Alignment.centerRight ,child:InkWell(onTap: ()async{
                                    stop = true;
                                    Navigator.of(context).pop("dialog");
                                    adsgotocats(banner[0]["cat_id"].toString(),homedata,tab);
                                  },child: Text("هنا",style: TextStyle(color: Colors.red,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))),]),
                              ),
                            )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          stop = true;
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="5"){
        return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[Container(margin: EdgeInsets.only(top: 10),child: InkWell( onTap: (){
                        stop = true;
                        Navigator.of(contexta).pop("dialog");
                      },child: Icon(Icons.close)),alignment: Alignment.centerRight,),
                        Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                            child:Center(
                              child: Directionality(textDirection: TextDirection.rtl,
                                child: Row(children:[
                                  Container( alignment: Alignment.centerRight,child: Text("اضغط للذهاب للفئة الفرعية المتاحة ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                                  ,Container(alignment: Alignment.centerRight ,child:InkWell(onTap: ()async{
                                    stop = true;
                                    Navigator.of(context).pop("dialog");
                                    adsgotosubcats(banner[0]["cat_id"].toString(),banner[0]["subcat_id"].toString(),homedata);
                                  },child: Text("هنا",style: TextStyle(color: Colors.red,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))),]),
                              ),
                            )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          stop = true;
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="6"){
        return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[Container(margin: EdgeInsets.only(top: 10),child: InkWell( onTap: (){
                        stop = true;
                        Navigator.of(contexta).pop("dialog");
                      },child: Icon(Icons.close)),alignment: Alignment.centerRight,),
                        Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                            child:Center(
                              child: Directionality(textDirection: TextDirection.rtl,
                                child: Row(children:[
                                  Container( alignment: Alignment.centerRight,child: Text("اضغط لرؤية المنتج المتاح ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                                  ,Container(alignment: Alignment.centerRight ,child:InkWell(onTap: ()async{
                                    stop = true;
                                    Navigator.of(context).pop("dialog");
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return Productdetail(id:banner[0]["product_id"].toString() ,rating:"1" ,);
                                    }));
                                  },child: Text("هنا",style: TextStyle(color: Colors.red,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))),]),
                              ),
                            )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          stop = true;
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="1"){
        _controller = VideoPlayerController.network(banner[0]["video"])
          ..initialize().then((_) {
            viewvideo(adtime);
            _controller.play();});
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      }
    });
  }
  adsgotosubcats(cat,subcat,homedata){
    for(int i =0 ; i<homedata.length;i++){
      if(homedata[i]["ID"].toString() ==cat.toString()){
        //for(int y =0 ; y<homedata[i]["SubCategories"].length ; y++){
         // if(homedata[i]["SubCategories"][y]["ID"].toString() == subcat.toString()){
            Provider.of<Notifires>(contexta,listen: false).adsgotosubcats(contexta,homedata[i]["Name"].toString(),homedata[i]["SubCategories"],subcat);
         // }
        //}
      }
    }
      }
  adsgotocats(cat_id,homedata,tab){
    Navigator.of(contexta).pop("dialog");
    print(cat_id);
      if(cat_id.toString() == "9"){
        Navigator.of(contexta).push(MaterialPageRoute(builder: (context) {
          return Mazadshow(mazads: homedata[0]["Auctions"],);
        }));
      }
      else{
        for(int i =0 ; i<homedata.length;i++){
          if(homedata[i]["ID"].toString() ==cat_id.toString()){
            print(homedata[i]);
            Navigator.of(contexta).push(MaterialPageRoute(builder: (context) {
              return Showpage(
                id: homedata[i]["ID"], name: homedata[i]["Name"], subcategories: homedata[i]["SubCategories"],tabcontroller: tab,maincontext: contexta,navigate : true ,);
            }));
          }
      }
    }
  }
  VideoPlayerController _controller;
  viewvideo(adtime){
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setState){
            brogress(setState,adtime,true);
            return AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),backgroundColor: Colors.transparent,elevation: 0,insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content:Container(height: MediaQuery.of(context).size.height,
                  child:Column(children:[
                    Container(
                      child:Stack(children:[ Container(height: MediaQuery.of(context).size.height*0.9,width:MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),Positioned( top: 30,right: MediaQuery.of(context).size.width*0.9,child: Container(margin: EdgeInsets.zero,child: InkWell( onTap: (){
                stop = true;
                Navigator.of(contexta).pop("dialog");
              },child: Icon(Icons.close,color: Colors.white,size: 30,)),alignment: Alignment.centerRight,))],
                    )), Container(margin: EdgeInsets.zero,child:LinearProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                   // Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                   ///   stop = true;
                   //   Navigator.of(context).pop("dialog");
                   // },),)
                  ],
                  ),
                ));
          });
    },
    );
  }
}