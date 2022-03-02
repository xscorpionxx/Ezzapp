import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/alertdialog.dart';
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
Widget more(context,homelogic){
  var downloadmore = Provider.of<Notifires>(context).dwonloadpro;
  var profiledata = Provider.of<Notifires>(context).profiledata;
  return Directionality(textDirection: TextDirection.rtl,
    child: Container(child:downloadmore?Container(child:Center(child: CircularProgressIndicator(),) ,): ListView(children: [
      Directionality(textDirection: TextDirection.ltr,
        child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: 40) ,alignment: Alignment.center ,child: Row(children: [
          Expanded(flex: 3,
            child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Column(children: [
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07) ,alignment: Alignment.centerRight ,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Name"].toString(),maxLines: 1,style: TextStyle(color: Color.fromRGBO(11, 12, 58, 1),fontWeight: FontWeight.bold,fontSize: 22),),),
              Container(alignment: Alignment.centerRight,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Email"].toString(),maxLines: 1,style: TextStyle(fontSize: 14),),)
            ],)),
          )
          ,Expanded(child:  Container( decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(86, 86, 86, 1)),borderRadius: BorderRadius.circular(10)),width: MediaQuery.of(context).size.width*0.2,height: MediaQuery.of(context).size.width*0.2,child: ClipRRect(borderRadius: BorderRadius.circular(10),child:profiledata==null?Container(): Image( fit: BoxFit.fill,image: NetworkImage(profiledata["ProfilePhoto"]),)),)),
        ],),),
      )
      ,InkWell(onTap: ()=>navigatetoprofile(context,profiledata) ,child: Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(top: 8),child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الملف الشخصي"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11,child: SvgPicture.asset("images/editprofile.svg",fit: BoxFit.fill,), )),)
      ),InkWell(onTap: ()=>navigatetopassword(context),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تغيير كلمة المرور"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more3.png")),), ),))
      ,InkWell(onTap: ()=>navigatetopchat(context),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("محادثة"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: SvgPicture.asset( "images/chat.svg",fit: BoxFit.fill,)),),),
      ),InkWell(onTap: ()=>navigatetoppartner(context,profiledata),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("شركاء النجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more4.png")),),))),
      InkWell(onTap: ()=>homelogic.shareapp(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("شارك التطبيق",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(image:AssetImage("images/shareaz.png") ,fit: BoxFit.fill,)),),),
      ),InkWell(onTap: ()=>navigatetopcomplaints(context),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الاقتراحات والشكاوى"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more6.png")),),),)),
      InkWell(onTap: ()=>navigatetopaboutapp(context),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("عن التطبيق"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more7.png")),),),)),
      InkWell(onTap: () => navigatetoterms(context),
          child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.06,
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text(
                  "الشروط والأحكام"),
              leading: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.11,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                child: Image(fit: BoxFit.fill,
                    image: AssetImage("images/more8.png")),),),)),
      InkWell(onTap: () => navigatetopolicy(context),
          child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.06,
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text(
                  "سياسة الاستخدام"),
              leading: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.11,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                child: Image(fit: BoxFit.fill,
                    image: AssetImage("images/more8.png")),),),))
      ,InkWell(onTap: ()=>signout(context),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تسجيل الخروج"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,decoration: BoxDecoration(gradient:LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent]) ),child: Icon(Icons.logout,color: Colors.white,)),),)
      )],)),
  );
}
navigatetolocation(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Location();
  }));
}
signout(context)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  Provider.of<Notifires>(context,listen: false).dispose();
  FlutterRestart.restartApp();
}
navigatetoterms(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Terms();
  }));
}
navigatetoprofile(context,profiledata){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Profile2(dataprofile: profiledata,);
  }));
}
navigatetopassword(context)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.getString("logintype")=="facebook"||sharedPreferences.getString("logintype")=="google"){
    Alertdialogazz.alert(context, "لا يمكن تغيير كلمة السر لحساب التواصل الاجتماعي");
  }
  else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Changepass();
    }));
  }
}
navigatetopchat(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Providerchat();
  }));
}
navigatetoppartner(context,profiledata){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Partner(sharelink: profiledata["ShareLink"],);
  }));
}
navigatetopcomplaints(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Recommend();
  }));
}
navigatetopolicy(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Policy();
  }));
}
navigatetopaboutapp(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Aboutapp();
  }));
}