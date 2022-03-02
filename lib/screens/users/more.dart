import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/editcupon.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/editservice.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/partner.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/profile2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/Editauction.dart';
import '../provider/Editservicee3.dart';
import '../aboutapp.dart';
import '../provider/addauction.dart';
import '../provider/addcoupons.dart';
import '../provider/addservice.dart';
import '../provider/addservice2.dart';
import '../provider/addservice3.dart';
import '../changepassword.dart';
import '../provider/editservice2.dart';
import 'mazadat.dart';
import 'notification.dart';
import '../policy.dart';
import 'profile.dart';
import '../provider/providerchat.dart';
import '../recommend.dart';
import '../shareapp.dart';
import 'shoppingcart.dart';
import '../terms.dart';
import 'userchat.dart';

Widget more(context,tabController,homelogic){
  var downloadpro  = Provider.of<Notifires>(context).dwonloadpro;
  var profiledata = Provider.of<Notifires>(context).profiledata;
  return Directionality(textDirection: TextDirection.rtl,
    child: Container(child:downloadpro? Container(child: Center(child: CircularProgressIndicator(),),): SingleChildScrollView(
      child: Column(children: [
        Directionality(textDirection: TextDirection.ltr,
          child: Container(margin: EdgeInsets.only(top: 70, right: 40),
            alignment: Alignment.center,
            child: Row(children: [
              Expanded(flex: 3,
                child: Container(margin: EdgeInsets.only(right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05), child: Column(children: [
                  Container(margin: EdgeInsets.only(left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.07),
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(profiledata.toString() == "null"
                        ? ""
                        : profiledata["Name"].toString(), maxLines: 1,
                      style: TextStyle(color: Color.fromRGBO(11, 12, 58, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 22),),),
                  Container(alignment: Alignment.centerRight,
                    child: AutoSizeText(profiledata.toString() == "null"
                        ? ""
                        : profiledata["Email"].toString(), maxLines: 1,
                      style: TextStyle(fontSize: 14),),)
                ],)),
              )
              ,
              Expanded(
                  child: Container(decoration: BoxDecoration(border: Border
                      .all(color: Color.fromRGBO(86, 86, 86, 1).withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    child: ClipRRect(borderRadius: BorderRadius.circular(10),
                        child: profiledata == null ? Container() : Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              profiledata["ProfilePhoto"]),)),)),
            ],),),
        ),
        Container(margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.02),child:
        InkWell(onTap: () => navigatetolocation(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Text("الموقع", style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .textScaleFactor * 13),),
                  leading: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.11,
                    child: Image(fit: BoxFit.fill,
                        image: AssetImage("images/more1.png")),)),)))
        ,
        Container(
          child: InkWell(onTap: () {
            Provider.of<Notifires>(context, listen: false).getindex(
                tabController, "req", 2, context);
            Future.delayed(const Duration(milliseconds: 500), () {
              Provider.of<Notifires>(context, listen: false).getmyorders(
                  context);
            });
          }, child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.06,
            child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text("طلباتي", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .textScaleFactor * 13),),
              leading: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.11,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                child: Image(fit: BoxFit.fill,
                    image: AssetImage("images/more2.png")),),),),),
        )
        ,
        InkWell(onTap: () => navigatetoprofile(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              margin: EdgeInsets.zero,
              child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Text(
                    "الملف الشخصي", style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .textScaleFactor * 13),),
                  leading: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.11,
                    child: SvgPicture.asset(
                      "images/editprofile.svg", fit: BoxFit.fill,),)),)
        ),
        InkWell(onTap: () => navigatetopassword(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                  "تغيير كلمة المرور", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 13),),
                leading: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                  child: Image(fit: BoxFit.fill,
                      image: AssetImage("images/more3.png")),),),))
        ,
        InkWell(onTap: () => navigatetopchat(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text("محادثة", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 13),),
                leading: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.11,
                    child: SvgPicture.asset(
                      "images/chat.svg", fit: BoxFit.fill,)),),)
        ),
        InkWell(onTap: () => navigatetoppartner(context,profiledata),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Text(
                    "شركاء النجاح", style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .textScaleFactor * 13),),
                  leading: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.11,
                    child: Image(fit: BoxFit.fill,
                        image: AssetImage("images/more4.png")),),))),
        InkWell(onTap: () => homelogic.shareapp(),
          child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.06,
            child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text(
                "شارك التطبيق", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .textScaleFactor * 13),),
              leading: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.11,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                  child: Image(image:AssetImage("images/shareaz.png") ,fit: BoxFit.fill,)),),),
        ),
        InkWell(onTap: () => navigatetopcomplaints(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                  "الاقتراحات والشكاوى", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 13),),
                leading: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.11,
                  child: Image(fit: BoxFit.fill,
                      image: AssetImage("images/more6.png")),),),)),
        InkWell(onTap: () => navigatetopaboutapp(context),
          child: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.06,
            child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text("عن التطبيق", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .textScaleFactor * 13),),
              leading: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.11,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                child: Image(fit: BoxFit.fill,
                    image: AssetImage("images/more7.png")),),),),
        ),
        InkWell(onTap: () => navigatetoterms(context),
            child: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.06,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                  "الشروط والأحكام", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 13),),
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
                  "سياسة الاستخدام", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 13),),
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
        ,
        InkWell(onTap: () => signout(context), child: Container(height: MediaQuery
            .of(context)
            .size
            .height * 0.06,margin: EdgeInsets.only(bottom: 30),
          child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined),
            title: Text("تسجيل الخروج", style: TextStyle(fontSize: MediaQuery
                .of(context)
                .textScaleFactor * 13),),
            leading: Container(width: MediaQuery
                .of(context)
                .size
                .width * 0.11,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.11,
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green, Colors.blueAccent])),
                child: Icon(Icons.logout, color: Colors.white,)),),)
        )
      ],),
    )),
  );

}
navigatetolocation(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Location();
  }));
}
navigatetoshareapp(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Shareapp();
  }));
}
final googlesignin = GoogleSignIn();
signout(context)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var type = sharedPreferences.getString("logintype");
  if(type == "google" ||type == "facebook"){
    if(type == "google"){
      final googleusera = await googlesignin.currentUser;
      if( googleusera !=null){
        googleusera.clearAuthCache();
      }
    }else{
      final dataa = await FacebookAuth.instance..getUserData();
      await dataa.logOut();
      await FirebaseAuth.instance.signOut();
    }
    FirebaseAuth.instance.currentUser.delete();
    FirebaseAuth.instance.signOut();
  }
  sharedPreferences.clear();
  Provider.of<Notifires>(context,listen: false).dispose();
  FlutterRestart.restartApp();
  // await Provider.of<Notifires>(context,listen: false).resetdata();
  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //   return MyApp();
  // }));
}
navigatetoterms(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Terms();
  }));
}
navigatetopolicy(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Policy();
  }));
}
navigatetoprofile(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Profile();
  }));
}
navigatetopassword(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Changepass();
  }));
}
navigatetopchat(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Userchat();
  }));
}
navigatetoppartner(context,profiledata){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Partner(sharelink : profiledata["ShareLink"]);
  }));
}
navigatetopcomplaints(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Recommend();
  }));
}
navigatetopaboutapp(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Aboutapp();
  }));
}