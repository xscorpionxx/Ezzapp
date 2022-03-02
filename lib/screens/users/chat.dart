import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/chat.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Chat extends StatefulWidget{
  var id;
  List messags = [];
  var providername;
  var able;
  Chat({this.id ,this.messags,this.providername,this.able});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices(notable: able,messages: messags,id: id,providername:providername);
  }
}
class Stateaddservices extends State<Chat>{
  var id;
  var userid;
  List messages =[];
  var notable;
  Profilelogic profilelogic;
  var providername;
  Stateaddservices({this.id  ,this.messages,this.providername,this.notable});
  TextEditingController message ;
  Chatlogic chatlogic;
  List messages1 =[];
  FlutterPusher pusher;
  BuildContext dialogcontexta;
  var timer;
  var connected = false;
  brogress(){
    Future.delayed(Duration(seconds: 10),(){
      if(connected ==false){
        if(Navigator.canPop(dialogcontexta)){
          Navigator.of(dialogcontexta).pop("dialog");
          Navigator.of(context).pop();
          Alertdialogazz.alert(context, "حدث خطأ في المحادثة الرجاء اعادة المحاولة والتأكد من الاتصال بالانترنت");
        }
      }
    });
  }
  loading(){
    return showDialog(
      barrierDismissible: false, context: context, builder: (context) {
      dialogcontexta = context;
      brogress( );
      return AlertDialog(content: Container(height:100,
        child:Column(children:[ Container(width: 30,height:30,
            child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),Spacer(),
          Container(child: Center(child: Text("يتم اعداد المحادثة",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 20),),),)]),
      ),
      );},
    );
  }
  setid()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userid= sharedPreferences.getString("id");
    print(userid);
  }
  @override
  void dispose() {
    super.dispose();
  }
  var username;
  var download = true;
  getname()async{
    var data = await profilelogic.getdata();
    username = data["name"];
    Provider.of<Notifires>(context,listen: false).getmessagesfireroom(userid,id);
    download = false;
    setState(() {});
  }
  @override
  void initState() {
    setid();
    print(notable);
    chatlogic = new Chatlogic(context);
    profilelogic = new Profilelogic(context);
    getname();
    //initPusher();
    message = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    messages = Provider.of<Notifires>(context).firemessageroom;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:download?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
            Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("محادثة",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.045),))),
            Expanded(child: Container())
          ],),),
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.7,child:messages.length==0?Container(child: Center(child: Text(""),),) :ListView.builder(physics: BouncingScrollPhysics(),itemCount: messages.length
            ,itemBuilder: (context,i){
         print(messages[i]);
              if(messages[i]["sender"].toString() =="User"){
                if(messages[i]["provider_id"].toString() ==messages[i]["SenderID"].toString() ){
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["SenderPhoto"], messages[i]["SenderName"]);
                }
                else{
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["RecivePhoto"] ,messages[i]["ReciveName"] );
                }
              }else{
                if(messages[i]["user_id"].toString() ==messages[i]["SenderID"].toString() ){
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,"", messages[i]["SenderName"]);
                }
                else{
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,"" ,messages[i]["ReciveName"] );
                }
              }
            }),),
        Container(
          child:notable!=null?Container(): Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05) ,
            decoration: BoxDecoration( color: Color.fromRGBO(243, 244, 245, 1),border: Border.all(color: Color.fromRGBO(204, 204, 204, 1),width: 1.5),borderRadius: BorderRadius.circular(10)), child: Directionality(textDirection: TextDirection.rtl,child:
            Row(children: [Expanded(child:  InkWell(onTap: (){chatlogic.sendfirbasemessage(id, message.text, providername, username) ;//chatlogic.sendmessage(message.text, id);
            message.text ="";
            },child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.black),child: Directionality(textDirection: TextDirection.ltr,child: Icon(Icons.send,color: Colors.white,)),)))
              ,Expanded(flex: 8 ,child: TextFormField(controller: message,decoration: InputDecoration(hintText: "اكتب هنا",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
            ]),),),
        )

      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  messagebuilder(msg,time,isme,photo ,name){
    DateTime dt = DateTime.parse(time.toString());
    print(dt);
    if(dt.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
      time = time.toString().substring(0,10);
    }
    else{
      time = time.toString().substring(11,19);
    }
    if(isme){
      return Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerRight ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black12.withOpacity(0.1) ,borderRadius: BorderRadius.circular(10)),child:
      Column(children: [
        Container(padding: EdgeInsets.all(5),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),))),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),),)
      ],),),);
    }
    else{
      return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Row(
        children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,child: Image(fit: BoxFit.fill,image: AssetImage("images/logoaz.png"),))),Expanded(flex: 6,
          child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black26.withOpacity(0.2) ,borderRadius: BorderRadius.circular(10)),child:
          Column(children: [
            Container( padding: EdgeInsets.all(5),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025,color: Colors.black38),),)
          ],),),),
        ) ],
      ));
    }
  }
}