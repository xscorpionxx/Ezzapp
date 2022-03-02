import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile2 extends StatefulWidget{
  var dataprofile;
  Profile2({this.dataprofile});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateprofile2(dataprofile:dataprofile);
  }
}
class Stateprofile2 extends State<Profile2>{
  TextEditingController name;
  TextEditingController id;
  GlobalKey<FormState> key ;
  var dataprofile;
  Stateprofile2({this.dataprofile});
  TextEditingController storename;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController timeedit1;
  TextEditingController timeedit2;
  TextEditingController desc;
  TextEditingController password;
  Profilelogic profilelogic;
  List region1list =["المنطقة"];
  List region2list =["المدينة"];
  List region3list =["المحافظة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  var value1 = "المنطقة";
  var value2 ="المدينة";
  var value3 = "المحافظة";
  var valuetime1 = "صباحا";
  var valuetime2 = "مساءا";
  List times1 =["مساءا" ,"صباحا"];
  List times2 =["مساءا" ,"صباحا"];
  var typevalue;
  List typelist =[];
  List subtypelist = [];
  List subtypevalues=[];
  var subtypevalue ;
  var photostroe;
  var photoprofile;
  changevaluetype(ind){
    print(subtypevalues);
    setState(() {
      subtypelist = subtypevalues[ind][(ind + 1).toString()];
    });
  }
  List regions =[];
  List citites =[];
  var download = true;
  List worktime =[];
  handletime() {
    print(worktime.length);
    if (worktime.length != 1 &&worktime.length != 0 ) {
      var time1 = worktime[0].toString().substring(worktime[0]
          .toString()
          .trim()
          .length - 2, worktime[0]
          .toString()
          .trim()
          .length);
      if (time1 == "am") {
        valuetime1 = "صباحا";
      } else {
        valuetime1 = "مساءا";
      }
      realtime1 = worktime[0].toString().trim().substring(0,worktime[0]
          .toString()
          .trim()
          .length - 3) ;
      var time2 = worktime[1].toString().trim().substring(worktime[1]
          .toString()
          .trim()
          .length - 2, worktime[1]
          .toString()
          .trim()
          .length);
      realtime2 = worktime[1].toString().trim().substring(0,worktime[1]
          .toString()
          .trim()
          .length - 3) ;
      if (time2 == "am") {
        valuetime2 = "صباحا";
      } else {
        valuetime2 = "مساءا";
      }
    }
  }
  getdata()async{
    var data = await profilelogic.getdata2();
    print(data);
    regions = data["listre1"];
    for(int f = 0 ; f<regions.length;f++){
      region1back.add({"name" :regions[f]["Name"],"ID" : regions[f]["ID"].toString()});
    }
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    typelist.add(dataprofile["StoreCat"]);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await slecetcity(dataprofile["Governorate"]);
    await selectgovern(dataprofile["City"]);
    value1  =dataprofile["Governorate"];
    value2 = dataprofile["City"];
    value3 = dataprofile["Region"];
    name.text = dataprofile["Name"];
    desc.text = dataprofile["Description"];
    worktime = dataprofile["WorkTime"].toString().split("-");
    handletime();
    phone.text = dataprofile["PhoneNumber"].toString();
    email.text = dataprofile["Email"];
    id.text = dataprofile["StoreNationalNumber"];
    password.text = sharedPreferences.getString("password");
    id.text = dataprofile["StoreNationalNumber"];
    photoprofile = dataprofile["ProfilePhoto"];
    photostroe = dataprofile["StorePhoto"];
    typevalue = dataprofile["StoreCat"];
    subtypevalue = dataprofile["StoreSubCat"];
    subtypevalues = data["subcats"];
    changevaluetype(typelist.indexOf(typevalue));
    storename.text = dataprofile["Store"];
    download = false;
    setState(() {});
  }
  slecetcity(name){
    citites.clear();
    region2back.clear();
    region2list.clear();
    region3back.clear();
    region3list.clear();
    for (int f = 0; f < regions.length; f++) {
      if (regions[f]["Name"].toString() == name.toString()) {
        citites = regions[f]["Cities"];
        for (int g = 0; g < regions[f]["Cities"].length; g++) {
          region2back.add({
            "name": regions[f]["Cities"][g]["Name"],
            "ID": regions[f]["Cities"][g]["ID"].toString()
          });
        }
      }
    }
    value2 = "المدينة" ;
    value3 ="المحافظة";
    region2list.add("المدينة");
    region3list.add("المحافظة");
    for (int i = 0; i < region2back.length; i++) {
      region2list.add(region2back[i]["name"].toString());
    }
    print(region2list);
    setState(() {

    });
  }
  selectgovern(name){
    region3back.clear();
    region3list.clear();
    for(int f =0 ; f<citites.length ; f++){
      if(citites[f]["Name"].toString() ==name.toString()) {
        for (int g = 0; g < citites[f]["Regions"].length; g++) {
          region3back.add({
            "name": citites[f]["Regions"][g]["Name"],
            "ID": citites[f]["Regions"][g]["ID"].toString()
          });
        }
      }
    }
    value3 ="المحافظة";
    region3list.add("المحافظة");
    for(int i =0 ; i<region3back.length ; i++){
      region3list.add(region3back[i]["name"].toString());
    }
    print(region3list);
    setState(() {
    });
  }
  @override
  void initState() {
    key = new GlobalKey<FormState>();
    print(dataprofile);
    profilelogic = new Profilelogic(context);
    getdata();
    name = new TextEditingController();
    id = new TextEditingController();
    storename = new TextEditingController();
    phone = new TextEditingController();
    email = new TextEditingController();
    desc = new TextEditingController();
    password = new TextEditingController();
    timeedit1 = new TextEditingController();
    timeedit2 = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child:download?Container(child: Center(child: CircularProgressIndicator()),) : ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
            Container(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.15),alignment: Alignment.center,child: Text("الملف الشخصي",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    ],),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.05),child: Text("اسم المستخدم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
                BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0))// shadow direction: bottom right
                ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: name,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المستخدم"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("اسم المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: storename,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المتجر"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("الهوية الوطنية",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: id,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "الهوية الوطنية"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.07),child: Text("رقم الجوال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),),
          Directionality(textDirection: TextDirection.ltr, child: Container(height: MediaQuery.of(context).size.height*0.08,
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )]),width: MediaQuery.of(context).size.width*0.7,
            child: Row(
              children:[Expanded(child: FittedBox(
                child: Container(height: MediaQuery.of(context).size.height*0.08,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )) ,child: Row(children: [
                    Container(margin: EdgeInsets.only(left: 20,right: 10),width:MediaQuery.of(context).size.width*0.08,height: MediaQuery.of(context).size.height*0.035,child: Image(fit: BoxFit.fill,image: AssetImage("images/flagicon.jpg"),),),
                  Container(margin: EdgeInsets.only(right: 5),child: Text("+966",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.015),),)
                ]),),
              )) ,Expanded(flex: 3,
                child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),keyboardType: TextInputType.phone,validator: Alertdialogazz.validateMobile,controller: phone ,decoration: InputDecoration(hintText: "رقم الجوال",border: InputBorder.none),),),
                ),
              )],
            ),
          )),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("البريد الالكتروني",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: email,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "البريد الالكتروني"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("نبذة عن المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              minLines: 3,maxLines: 5,controller: desc,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "نبذة عن المتجر"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("صورة المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),height: MediaQuery.of(context).size.height*0.2 ,child:newphoto ==null?
             photostroe ==null?Container(): InkWell(onTap: (){chooseimage();},child: Image(fit: BoxFit.fill,image: NetworkImage(photostroe),)) :  InkWell(onTap: (){chooseimage();},child: Image(fit: BoxFit.fill,image: FileImage(newphoto),)) ,),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),child: Text("مواعيد العمل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
           ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01 ) ,child: Row(children: [
           Expanded(child:  Directionality(textDirection: TextDirection.ltr, child: Container(
             margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,left:MediaQuery.of(context).size.width*0.03),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )]),width: MediaQuery.of(context).size.width*0.4,
             child: Row(
               children:[Expanded(flex: 2,child:  Directionality(textDirection: TextDirection.rtl,
            child: Container(
              child: FittedBox(child: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                    value: valuetime2
                    ,items: times2.map((e) => DropdownMenuItem(child: FittedBox(child: AutoSizeText('$e',maxLines: 1,)),value: e,)).toList(),
                    onChanged: (_) {
                       valuetime2 =_;
                      setState(() {});
                    },
                  ))),
            ),
          )),Expanded(child: Container(child: VerticalDivider(thickness: 2,),width: 20,height: MediaQuery.of(context).size.height*0.05,)),Expanded(flex: 3,
                 child: Directionality(textDirection: TextDirection.rtl,
                   child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: InkWell( onTap: (){
                      showtime2();
                   },child: Text(realtime2 ==null? "انتهاءا ب":realtime2.toString(),style: TextStyle(color: Colors.black26,fontSize: 15),)),),
                 ),
               )],
             ),
           ))), Expanded(child:  Directionality(textDirection: TextDirection.ltr, child: Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,left:MediaQuery.of(context).size.width*0.03),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )]),width: MediaQuery.of(context).size.width*0.4,
              child: Row(
                children:[ Expanded(flex: 2,child:  Directionality(textDirection: TextDirection.rtl,
                    child: Container(
                      child:  FittedBox(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                              value: valuetime1
                              ,items: times1.map((e) => DropdownMenuItem(child:FittedBox(child: AutoSizeText('$e',maxLines: 1,)),value: e,)).toList(),
                              onChanged: (_) {
                                valuetime1 =_;
                                setState(() {});
                              },
                            )),
                      ),
                    ),
                  )),
                Expanded(child: Container(child: VerticalDivider(thickness: 2,),width: 20,height: MediaQuery.of(context).size.height*0.05,)),Expanded(flex: 3,
                  child: Directionality(textDirection: TextDirection.rtl,
                    child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: InkWell( onTap: (){
                      showtime1();
                    },child: Text(realtime1 ==null? "ابتداء من":realtime1.toString(),style: TextStyle(color: Colors.black26,fontSize: 15))),),
                  ),
                )],
              ),
            )))
          ],),),Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("فئة المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: typevalue
                    ,items: typelist.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {

                    },
                  )),
            )),
          )
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المنطقة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value1
                    ,items: region1list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
    if(_.toString() != "المنطقة") {
      value1 = _;
      slecetcity(value1);
      setState(() {});
    }
                    },
                  )),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المدينة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value2
                    ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
    if(_.toString() != "المحافظة") {
      value2 = _;
      selectgovern(value2);
      setState(() {});
    }
                    },
                  )),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المحافظة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
         , Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value3
                    ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
    if(_.toString() != "المحافظة") {
      value3 = _;
      setState(() {});
    }
                    },
                  )),
            )),
          ),
         Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
           child: InkWell(onTap: (){
             print(realtime1.toString());
             print(realtime2.toString());
             profilelogic.update2(id.text,key,name.text, phone.text, email.text,
                storename.text, typevalue, subtypevalue, value1, value2, value3,region1back,region2back,region3back,newphoto , valuetime1.toString() , realtime1,valuetime2.toString() , realtime2,desc.text);
            },child:
            Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
              child:Text("حفظ ", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,)),
         )
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  deleteimage(){

  }
  var time2;
  var realtime2;
  var time1;
  var realtime1;
  showtime2(){
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child:CupertinoTimerPicker(onTimerDurationChanged: (val){
                            time2 = val.toString().substring(0,4);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
              setState(() {
                realtime2 = time2;
              });
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  showtime1(){
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child:CupertinoTimerPicker( onTimerDurationChanged: (val){
                            time1 = val.toString().substring(0,4);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
              setState(() {
                realtime1 = time1;
              });
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  var newphoto;
  chooseimage()async{
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 !=null){
      newphoto =File( image1.path);
      setState(() {});
    }
  }
  changepass(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Changepass();
    }));
  }
}