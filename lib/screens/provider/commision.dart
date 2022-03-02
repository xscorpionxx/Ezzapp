

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/editcupon.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/editservice.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/partner.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/profile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Editauction.dart';
import 'Editservicee3.dart';
import '../aboutapp.dart';
import 'addauction.dart';
import 'addcoupons.dart';
import 'addservice.dart';
import 'addservice2.dart';
import 'addservice3.dart';
import '../changepassword.dart';
import 'editservice2.dart';
import '../users/mazadat.dart';
import '../policy.dart';
import 'providerchat.dart';
import '../recommend.dart';
import '../terms.dart';

Widget commision(context,home2logic, transportcollection,setState,transportingnote,transportingdate,dateable){
  var home2_data = Provider.of<Notifires>(context).home_provider;
  return Container(child: ListView(children: [
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.11,
      decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
        Expanded(child: Container(alignment: Alignment.center,child: Text("عمولة التطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
      ],),) ),
    Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.05) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text("حسابات البنكية الخاصة للتطبيق :",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
    , Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text(home2_data["BankAccounts"]==null?" ":home2_data["BankAccounts"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
    ,Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.02) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text("ارفاق وصل التحويل :",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
    ,Directionality(textDirection: TextDirection.rtl,
      child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.02 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015), controller: transportcollection,validator: home2logic.validate,keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "قيمة التحويل"),
      )),
    ),
    Directionality(textDirection: TextDirection.ltr,
      child: Container(
        child:Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02
            ,right:MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05 ),
          decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05))
          ,child: Center(
            child: InkWell( onTap: (){
              setState(() {
                if(!dateable) {
                  dateable = true;
                }
                else{
                  dateable = false;
                }
              });
            },child: ListTile(leading:dateable?InkWell(child: FittedBox(child: Text("تم",style: TextStyle(color: Color.fromRGBO(69, 190, 0, 1)),)),onTap: (){
              setState(() {
                dateable = false;
              });
            },) :Icon(Icons.arrow_drop_down),title: Container(alignment: Alignment.centerRight,child:transportingdate !=null?Text(transportingdate.toString()): Text("موعد التحويل",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015))),trailing: Icon(Icons.date_range,color: Color.fromRGBO(69, 190, 0, 1),),),),
          ),),
      ),
    ),
    Container( child:!dateable?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
      setState(() {
        transportingdate = val.toString().substring(0,10);
      });
    },),)),
    Container(width: MediaQuery.of(context).size.width*0.9,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),
      decoration: BoxDecoration(color: Colors.white),child: Column(children: [
        InkWell(onTap: () =>chooseimage(setState)
            ,child: Container(child: Center(child:photo == null? Image(image: AssetImage("images/emptyphoto.png"),):Image(image: FileImage(photo)) ,),)),
        Container(child: Center(child: Text("صورة وصل التحويل",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02)),),)
      ],),),
    Directionality(textDirection: TextDirection.rtl,
      child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
        controller: transportingnote,textInputAction: TextInputAction.send,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم التحويل"),
      )),
    ),
    Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
      child: InkWell(onTap: ()=>home2logic.sendinfocommesion( photo, transportcollection.text, transportingdate, transportingnote.text),
        child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
          child:Text("ارسال المعلومات", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
      ),
    )

  ],),);
}
File photo;
chooseimage(setState)async{
  var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image1 !=null){
       photo = File(image1.path);
    setState(() {});
  }
}
List servicesa = [1,2,3];
List checks = [false , false , false];
showdialog(context){
  return showDialog( context: context, builder: (context) {
    return StatefulBuilder(builder: (Context , setState){
      return AlertDialog(
          content:Container(height: MediaQuery.of(context).size.height*0.45,
            child: Column(children: [
              Container(alignment: Alignment.centerRight,child: Text("المنتجات التي يطبق عليها الكوبون",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),)
              ,Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.22 ,child: ListView.builder(itemCount: servicesa.length,itemBuilder: (context,i){
                return CheckboxListTile(activeColor: Colors.green,title: Directionality(textDirection: TextDirection.rtl,child: Text("خدمة-"+servicesa[i].toString())),value: checks[i], onChanged: (val){ setState((){checks[i] = val;});});;
              }),),
              Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                child: Text("اضافة ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,)
            ],),
          )
      );},
    );
  });
}