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
import '../provider/providerchat.dart';
import '../recommend.dart';
import 'shoppingcart.dart';
import '../terms.dart';
navigatetonotification(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Notifications();
  }));
}
navigatetoshopping(context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Shoppingcard();
  }));
}
Widget favourite(context,showpagelogic){
  List fav = Provider.of<Notifires>(context).favdata;
  var downloadfav = Provider.of<Notifires>(context).downloadfav;
  return Directionality(textDirection: TextDirection.ltr,
    child: Container(child: ListView(children: [
      Container(width: MediaQuery
          .of(context)
          .size
          .width, height: MediaQuery
          .of(context)
          .size
          .height * 0.12,
        decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))), child:
        Container(child:
        Container(margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.01),
          child: Row(children: [
            Expanded(flex: 5,
                child: Container(
                    margin: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3),
                    alignment: Alignment.center,
                    child: Text("المفضلة", style: TextStyle(
                        color: Colors.white, fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),))),
            Expanded(child: InkWell(
                onTap: () => navigatetonotification(context),
                child: SvgPicture.asset(
                  "images/Icon-alarm.svg", semanticsLabel: "wadca",))),
            Expanded(child: InkWell(onTap: () => navigatetoshopping(context),
                child: Container(
                    margin: EdgeInsets.only(right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.07),
                    child: SvgPicture.asset(
                      "images/Icon feather-shopping-cart.svg",
                      semanticsLabel: "wasdca",))))
          ],),
        )),
      ), Container(margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.03), height: MediaQuery
          .of(context)
          .size
          .height * 0.77, width: MediaQuery
          .of(context)
          .size
          .width, child: downloadfav ? Container(child: Center(child: CircularProgressIndicator(),),)
          :fav.length == 0 ? Container(
        child: Center(child: Text("لا توجد أية عناصر في المفضلة",
          style: TextStyle(fontSize: MediaQuery
              .of(context)
              .size
              .height * 0.02),)),
      ) : Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: GlowingOverscrollIndicator(color: Colors.transparent,axisDirection: AxisDirection.left,
          child: GridView.builder(physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (166 / 233),),
              itemCount: fav.length,
              itemBuilder: (context, i) {
                if(fav[i]["DayRental"] !=null){
                  return Container(decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.01),
                    child: InkWell(onTap: () {
                      if (fav[i]["Status"].toString() == "0") {
                      }
                    },child: Container( child: Column(children: [
                      Container(
                        child: Container(
                            child: Stack(children: [ Container(width: MediaQuery
                                .of(context)
                                .size
                                .width,
                              height: 185,
                              child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),
                                    image: NetworkImage(fav[i]["Photos"][0]),)),),
                              Positioned(child: Container(
                                margin: EdgeInsets.only(top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01, left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01),
                                child: Row(children: [
                                  Expanded(child: Container(
                                    child: fav[i]["UserFav"].toString() == "1" ?
                                    InkWell(onTap: () =>
                                        showpagelogic.cancelfav(
                                            fav[i]["ID"], context,"اماكن"),
                                      child: Container(width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.lightBlueAccent),
                                        child: Icon(Icons.favorite_border,
                                          color: Colors.white, size: 20,),),
                                    ) : InkWell(onTap: () =>
                                        showpagelogic.cancelfav(
                                            fav[i]["ID"], context,"اماكن"),
                                      child: Container(width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Icon(Icons.favorite_border,
                                          color: Colors.black26, size: 20,),),
                                    ),)), Expanded(flex: 2, child: Container()),Expanded(child: Container(),flex: 2,),
                                ],),
                              ))
                            ])),
                      ),
                      Container(margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.02, right: 10), child: Row(children: [
                        Expanded(child: Container(
                          margin: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01),
                          child: FittedBox(child: AutoSizeText(fav[i]["Rating"],
                            style: TextStyle(
                                color: Colors.black, fontSize: MediaQuery
                                .of(context)
                                .textScaleFactor * 10),)),))
                        ,
                        Expanded(child: Container(
                            margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                            child: Icon(
                              Icons.star, color: Colors.yellow.withGreen(2000),
                              size: 15,)),),
                        Expanded(flex: 6,
                          child: Container(alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01),
                              child: Directionality(textDirection: TextDirection.rtl,
                                child: AutoSizeText(fav[i]["Name"], maxLines: 1,
                                  style: TextStyle(
                                      color: Color.fromRGBO(2, 44, 67, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),),
                              )),)
                      ])),
                      Container(margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: Directionality(textDirection: TextDirection.rtl,
                            child: Text("ابتداء من "+"ريال"+
                                fav[i]["DayRental"].toString(), maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),)),),
                    ],)
                      ,),
                    ),
                  );
                }else {
                  return Container(decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ), margin: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.01),
                    child: InkWell(onTap: () {
                      if (fav[i]["Status"].toString() == "0") {

                      }
                    }, child: Container(child: Column(children: [
                      Container(
                        child: fav[i]["Status"].toString() == "1" ? Container(
                            child: Stack(children: [ Container(width: MediaQuery
                                .of(context)
                                .size
                                .width,
                              height: 185,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage(fit: BoxFit.fill,
                                    placeholder: AssetImage(
                                        "images/logoaz.png"),
                                    image: NetworkImage(fav[i]["Photo"]),)),),
                              Positioned(child: Container(
                                margin: EdgeInsets.only(top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01, right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01, left: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01),
                                child: Row(children: [
                                  Expanded(child: Container(
                                    child: fav[i]["UserFav"].toString() == "1" ?
                                    InkWell(onTap: () =>
                                        showpagelogic.cancelfav(
                                            fav[i]["ID"], context,"تاجر"),
                                      child: Container(width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.lightBlueAccent),
                                        child: Icon(Icons.favorite_border,
                                          color: Colors.white, size: 20,),),
                                    ) : InkWell(onTap: () =>
                                        showpagelogic.cancelfav(
                                            fav[i]["ID"], context,"تاجر"),
                                      child: Container(width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Icon(Icons.favorite_border,
                                          color: Colors.black26, size: 20,),),
                                    ),)), Expanded(flex: 2, child: Container()),
                                  Expanded(flex: 2,
                                      child: Container(
                                          child: fav[i]["BestSeller"]
                                              .toString() == "1" ?
                                          InkWell(onTap: () => null,
                                            child: Container(width: 36,
                                              padding: EdgeInsets.all(3),
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(10),
                                                  color: Color.fromRGBO(
                                                      254, 254, 115, 1)),
                                              child:
                                              FittedBox(child: Row(children: [
                                                Text("بائع مميز",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          8, 67, 143, 1),
                                                      fontSize: 8),),
                                                Container(width: 10,
                                                    height: 10,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "images/thumbs-up.png"),
                                                        fit: BoxFit.fill)),
                                              ])),),
                                          ) : Container()))
                                ],),
                              ))
                            ])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: Image(fit: BoxFit.fill,image: NetworkImage(fav[i]["Photo"]),),),
                          Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 185,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container( decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)),child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
                      ),
                      Container(margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.02, right: 10), child: Row(children: [
                        Expanded(child: Container(
                          margin: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01),
                          child: FittedBox(child: AutoSizeText(fav[i]["Rating"],
                            style: TextStyle(
                                color: Colors.black, fontSize: MediaQuery
                                .of(context)
                                .textScaleFactor * 10),)),))
                        ,
                        Expanded(child: Container(
                            margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                            child: Icon(
                              Icons.star, color: Colors.yellow.withGreen(2000),
                              size: 15,)),),
                        Expanded(flex: 6,
                          child: Container(alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: AutoSizeText(fav[i]["Name"], maxLines: 1,
                                  style: TextStyle(
                                      color: Color.fromRGBO(2, 44, 67, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),),
                              )),)
                      ])),
                      Container(margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: Directionality(textDirection: TextDirection.rtl,
                            child: Text(
                              fav[i]["Description"].toString(), maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),)),),
                    ],)
                      ,),
                    ),
                  );
                }
              }),
        ),
      ),)

    ],),),
  );
}