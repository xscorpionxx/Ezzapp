import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/screens/codeconirmation.dart';
import 'package:ezzproject/screens/complete.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  alertmessage(message) {
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content: Container(padding: EdgeInsets.all(MediaQuery
            .of(context)
            .size
            .width * 0.02), height: MediaQuery
            .of(context)
            .size
            .height * 0.2, child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(child: FittedBox(child: new Text(
                    message, style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .textScaleFactor * 20, fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.05),
              child: InkWell(onTap: () {
                Navigator.of(context).pop();
              }, child: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width, padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.02), decoration: BoxDecoration(color: Colors
                  .green), child: Center(child: Text("حسنا",
                style: TextStyle(color: Colors.white, fontSize: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      //await dataa.logOut();
      //await FirebaseAuth.instance.signOut();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      // Create a credential from the access token
      final data = await FacebookAuth.instance.getUserData();
      alertwait();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
          .credential(loginResult.accessToken.token);
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      loginfacebookgoogle("facebook", loginResult.accessToken.token);
      print(loginResult.accessToken.token);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (Navigator.maybePop(contexta) == true) {
        Navigator.of(contexta).pop();
      }
      alertmessage(e.message.toString());
    }
  }

  final googlesignin = GoogleSignIn();
  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;
  googlelogin() async {
    //_translated = await translation.translate(text: "welcome", to: 'ar');
    final googleusera = await googlesignin.signInOption;
    final googleable = await googlesignin.isSignedIn();
    if (googleable) {
      await googlesignin.signOut();
    }
    final googleuser = await googlesignin.signIn();
    if (googleuser == null) {
      return;
    }
    else {
      _user = googleuser;
    }
    try {
      alertwait();
      final googleauth = await googleuser.authentication;
      final cred = GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken,
          idToken: googleauth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(cred);
      print(cred.accessToken);
      loginfacebookgoogle("google", cred.accessToken);
    }
    on FirebaseAuthException catch (e) {
      if (Navigator.maybePop(contexta) == true) {
        Navigator.of(contexta).pop();
      }
      alertmessage(e.message.toString());
    }
  }
  Future loginfacebookgoogle(type,token)async{
    //put here the url to add account
    var url;
    if(type == "google"){
      url = "https://azz-app.com/api/auth/callback/google/"+token.toString();
    }
    else{
      url = "https://azz-app.com/api/auth/callback/facebook/"+token.toString();
    }
    var response = await http.post(Uri.parse(url));
    Navigator.of(contexta,rootNavigator: true).pop('dialog');
    var body = jsonDecode(response.body);
    print(body);
    if (body["status"].toString() == "true") {
      if( body["data"]["Governorate"].toString().trim() != ""&&body["data"]["City"].toString().trim() != ""){
        Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta) {
          return Home();
        }));
      }
      else {
        Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta) {
          return Complete(typevalue:type ,tokenvalue: body["data"]["API_Key"].toString()
              ,namevalue : body["data"]["Name"].toString() , emailvalue :body["data"]["Email"].toString(),id:body["data"]["ID"].toString() );
        }));
      }
    }
    else {
      Alertdialogazz.alert(contexta,body["msg"].toString());
    }
  }
  void savedata(token, name, phone, password, email, re1, re2, re3) async {
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

  alertwait() {
    showDialog(
        barrierDismissible: false, context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(width: 30, height: 30,
            child: Center(child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator()))),
      );
    });
  }
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  void login(GlobalKey<FormState> key, email, password) async {
    if (key.currentState.validate()) {
     fire.getToken().then((value)async {
      var data = {
        "phone": email.toString(),
        "password": password.toString(),
        "fb_token": value.toString()
      };
      var url = "https://azz-app.com/api/login";
      alertwait();
      var response = await http.post(Uri.parse(url), body: data);
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body["status"] == true) {
        await savedata(
            body["data"]["API_Key"],
            body["data"]["Name"],
            body["data"]["PhoneNumber"].toString(),
            password,
            email,
            body["data"]["Governorate"].toString(),
            body["data"]["City"].toString(),
            body["data"]["Region"].toString());
        if (body["data"]["Type"] == "تاجر") {
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          sharedPreferences.setString("servicetype", body["data"]["StoreCat"]);
          if(body["data"]["StoreSubCatType"].toString()=="1"){
            sharedPreferences.setString("servicetypespec","true");
          }
          sharedPreferences.setString("id", body["data"]["ID"].toString());
          if( body["data"]["AccountStatus"].toString().trim() =="2"){
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Codeconf(phone: body["data"]["PhoneNumber"].toString(),
                    type:body["data"]["Type"] ,);
                }));
          }else{
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Home2();
                }));
          }
        }
        else {
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          sharedPreferences.setString("id", body["data"]["ID"].toString());
          if(body["data"]["AccountStatus"].toString().trim() =="2"){
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Codeconf(phone: body["data"]["PhoneNumber"].toString(),
                    type:body["data"]["Type"] ,);
                }));
          }else{
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Home();
                }));
          }
        }
      }
      else {
        alertmessage(body["msg"].toString());
      }
    });
         }
  }
}