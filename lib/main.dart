
import 'dart:io';

import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/codeconirmation.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/resetpass2.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'logic/mainlogic.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Mainlogic mainlogic = new Mainlogic();
void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(
 ChangeNotifierProvider(create: (_){
   return Notifires();
 },child: MyApp(),)
      );
}
class MyApp extends StatelessWidget {
  Mainlogic mainlogic = new Mainlogic();
  @override
  Widget build(BuildContext context) {
    mainlogic.gettoken();
    return
//  MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Ezz",debugShowCheckedModeBanner: false,
// home:Home2()
      // Section1(username: data,)
 // );
      FutureBuilder(future: mainlogic.getdata() , builder: (context ,snapshot ){
      if(snapshot.hasError){
        return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),
            title: "Azz",debugShowCheckedModeBanner: false,
          home: Loginpage());
      }
      if(snapshot.connectionState ==ConnectionState.done){
        if(mainlogic.data["token"] !=null &&mainlogic.data["phone"] !=null ) {
          if (mainlogic.data["logintype"].toString() == "google" ||
              mainlogic.data["logintype"] == "facebook") {
            return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),
                title: "Azz",
                debugShowCheckedModeBanner: false,
                home:  Home() //Section1(username: data,)
            );
          }
          else {
            return FutureBuilder(future: mainlogic.login(
                mainlogic.data["phone"], mainlogic.data["password"]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),
                        title: "Azz",
                        debugShowCheckedModeBanner: false,
                        home: Loginpage());
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (mainlogic.status == true) {
                      print(mainlogic.accountstatus);
                      if(mainlogic.accountstatus.toString().trim() =="1") {
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Tajawal'),
                            title: "Azz",
                            debugShowCheckedModeBanner: false,
                            home: mainlogic.type == "تاجر"
                                ? Home2()
                                : Home() //Section1(username: data,)
                        );
                      }
                      else{
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Tajawal'),
                            title: "Azz",
                            debugShowCheckedModeBanner: false,
                            home: Codeconf(type: mainlogic.type,phone:mainlogic.data["phone"] ,) // mainlogic.type == "تاجر"
                                 //Section1(username: data,)
                        );
                      }
                    }
                    else {
                      return MaterialApp(
                          theme: ThemeData(fontFamily: 'Tajawal'),
                          title: "Azz",
                          debugShowCheckedModeBanner: false,
                          home: Loginpage()
                      );
                    }
                  }
                  return MaterialApp(
                    title: "Loading", debugShowCheckedModeBanner: false,
                    theme: ThemeData(fontFamily: 'Tajawal'),
                    home: Scaffold(
                      body: Center(child: CircularProgressIndicator()),),);
                });
          }
        }
        else{
          return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Flatery",debugShowCheckedModeBanner: false,
              home: Loginpage()
          );
        }
      }
      return MaterialApp(title:"Loading",debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Tajawal'),
        home: Scaffold(body: Center(child: CircularProgressIndicator()),),);
    },);
  }
}
