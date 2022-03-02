import 'package:ezzproject/logic/profile.dart';
import "package:ezzproject/logic/apoutapp.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'users/notification.dart';

class Aboutapp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateterms();
  }
}
class Stateterms extends State<Aboutapp>{
  Applogic applogic;
  var about;
  getdata()async{
    about = await applogic.getabout();
    print(about);
    setState(() {});
  }
  @override
  void initState() {
    applogic = new Applogic(context);
    print("here");
    getdata();
    super.initState();
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:about==null ?Container(child: Center(child: CircularProgressIndicator(),),) : ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("عن التطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(flex: 3,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  //Expanded(flex: 2,child:InkWell(onTap: ()=>null,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                ],),
          )),
        ),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),child: Text("عن التطبيق",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.04),),),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Text("النسخة الحالية  v1.1",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),)),),
        Directionality(textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ] ,color: Colors.white ,borderRadius: BorderRadius.circular(10)) ,child: Column(children:[
             Text(about["about"].toString() ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.033),)]),),
          ),
        ),
        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
           Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07),width: MediaQuery.of(context).size.width*0.21,child: Divider(color: Colors.black26,thickness: 1.3,))
          , Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.05 ),alignment: Alignment.center,child: Text("روابط التواصل الاجتماعي",style: TextStyle(color: Colors.black45,fontSize: MediaQuery.of(context).size.width*0.035),))
         , Container(width: MediaQuery.of(context).size.width*0.21,child: Divider(color: Colors.black26,thickness: 1.3,))
        ],),),
        Container(margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.1 ,top: MediaQuery.of(context).size.height * 0.03),child: Row(children: [Expanded(child: Container()),Container(decoration: BoxDecoration( boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],color: Colors.blue,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12 ,child :InkWell(onTap:()=>applogic.gotofacebook(about["f"]),child: Center(child: Image(width: 15,height: 25,image: AssetImage("images/in4azz.png") ,)))),Container(decoration: BoxDecoration( boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],color: Colors.red,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12 ,child :InkWell(onTap: ()=> applogic.gotogoogle(about["g"]),child: Center(child: Image(width: 25,height: 25,image: AssetImage("images/in3azz.png") ,)))), Container(decoration: BoxDecoration( boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12,child :InkWell(onTap:()=>applogic.gototwiter(about["t"]),child: Center(child: Image(width: 25,height: 25,image: AssetImage("images/in1zaa.png") ,)))),
          Container(decoration: BoxDecoration( boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12,child :InkWell(onTap: ()=>applogic.gotoin(about["l"]),child: Center(child: Image(width: 25,height: 25,image: AssetImage("images/inazz.png") ,)))),Expanded(child: Container()),]),)
      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}