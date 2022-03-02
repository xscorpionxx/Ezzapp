import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/allreviews.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/chat.dart';
import 'package:ezzproject/screens/location.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/productdetail.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'notification.dart';
class Detailpage extends StatefulWidget{
  var index;
  var title;
  var kitchen;
  var id;
  var detaildata;
  Detailpage({this.detaildata});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statedetailpage(detaildata: detaildata);
  }
}
class Statedetailpage extends State<Detailpage>{
  var index = 1;
  var title;
  var section = "1";
  List shoppinglist =[];
  var kitchens = false;
  var id;
  var datadetailpage;
  var detaildata;
  Detailpagelogic detailpagelogic;
  Statedetailpage({this.detaildata});
  @override
  void initState() {
    print(detaildata["Products"][0]);
    print("aaaaaaaaa");
    print(detaildata);
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  List housesimg = [5,3,2];
  int totalprice ;
  getdata()async{
    Provider.of<Notifires>(context,listen: false).getdatadetailpage(detaildata["Products"]);
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var value_type="";
  List value_types =[];
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    // datadetailpage = Provider.of<Notifires>(context).datadetailpage;
    // print(datadetailpage);
     shoppinglist = Provider.of<Notifires>(context).shoppinglist;
     totalprice = Provider.of<Notifires>(context).totalprice;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Container(
        child:detaildata == null?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
              decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Directionality( textDirection: TextDirection.rtl,child: Text(detaildata["Name"].toString(),style: TextStyle(color: Colors.white,fontSize: 17),)))),
                Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
              ],),) ),
            Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image:NetworkImage(detaildata["Photo"]) ,),),
            Positioned(left: MediaQuery.of(context).size.width*0.8,top: MediaQuery.of(context).size.height*0.05,
              child: Container(child:detaildata["BestSeller"].toString()=="1"?
              InkWell(onTap: ()=>null,
                child: Container(alignment: Alignment.centerRight ,width: 72,padding: EdgeInsets.all(3),
                  height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                  FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 16),),Container(width: 20,height: 20,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
              ):Container()),
            )]))
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,child: Row(children:[
                Expanded(flex: 4,child: Container(child: Text(detaildata["Name"].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)),
          Expanded(child:  Container())]),
            )),
          Directionality(textDirection: TextDirection.rtl, child: Container(child: Text(detaildata["Description"].toString(),style: TextStyle(fontSize: 12,color: Colors.black38),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),)),
          Container(child: Row(children: [
            Expanded(flex: 3,child: Container( child: Text(detaildata["Location"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
            Expanded(child: Container(child: Text("الموقع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
          ],),),
          Container(margin: EdgeInsets.only(right: 10) ,child: Row(children: [
            Expanded(flex: 2,child: Container(child: AutoSizeText(detaildata["WorkTime"].toString(),maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: 20 ,right: 1,top: MediaQuery.of(context).size.height*0.01),)),
           Expanded(child:  Container(child: AutoSizeText("مواعيد العمل",maxLines: 1,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),))
          ],),),
          Container( margin: EdgeInsets.only(top: 10,right: 7),child: Row(children: [
             Expanded(flex: 5,child: Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["ID"]),child: AutoSizeText("مشاهدة تقييم البائع",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromRGBO(246, 7, 7, 1)),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),))
            ,Expanded(child: Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,) ),
            Expanded(child: Container( child: Icon(Icons.star,color: Colors.yellow.withGreen(1000),size: 20,),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),))
             ,Expanded(flex: 3,child:  Container( child: Text("التقييم",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.13),))
          ],),)
          ,Container(
            child:Container(
              child: detaildata["Products"].length==0?Container(height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,child: Center(child: Text("لا يوجد عناصر في المتجر"),),) :Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ,top: MediaQuery.of(context).size.height*0.02),
                child: GridView.builder( physics: BouncingScrollPhysics(),scrollDirection: Axis.vertical,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: (180/235),),itemCount: detaildata["Products"].length,itemBuilder: (context,i){
                return Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black38),color: Colors.white),height: 2000,child: detaildata["Products"][i]["Status"].toString().trim()!= "متاح"
                    ?Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: 150,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:Stack(
                  children:[ Container(
                    child: Column(children: [
                      Container(width: MediaQuery.of(context).size.width,height: 170,child: ClipRRect( borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(detaildata["Products"][i]["Photo"]),)),),
                 Container(margin: EdgeInsets.only(top: 5),child: Row(children:[
                   Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: 5),child:  Directionality(textDirection: TextDirection.rtl,child:
                   Text(detaildata["Products"][i]["SalePrice"].toString()+"ريال",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(246, 7, 7, 1),fontSize: 14),)),)),
                   Expanded(flex: 2,child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,bottom: 1),child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(detaildata["Products"][i]["Name"].toString(),maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),))]),)
                    ],),
                  ),Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20) ,topLeft: Radius.circular(20)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 170,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container( decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)),child: Center(child:  AutoSizeText("غير متاح",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 13),)),)),)],
                ),
                ):InkWell(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Productdetail(id:detaildata["Products"][i]["ID"] ,rating:detaildata["Rating"].toString() ,);
                  }));
                },
                  child: Container(child:
                         Column(children: [
                    Container(width: MediaQuery.of(context).size.width,height: 150,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(detaildata["Products"][i]["Photo"]),)),),
                     Container( margin: EdgeInsets.only(top: 5),child :
                        false?//detaildata["Products"][i]["SalePrice"].toString()!="null" ?
                       Row(children:[
                      Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.ltr,child: Text(detaildata["Products"][i]["SalePrice"].toString(),style: TextStyle(color: Color.fromRGBO(246, 7, 7, 1),fontSize: 14,fontWeight: FontWeight.bold),)),)),
                       Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child:  Directionality(textDirection: TextDirection.rtl,child:detaildata["Products"][i]["SalePrice"].toString()!="null" ?
                       Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Color.fromRGBO(246, 7, 7, 1),decoration:TextDecoration.lineThrough,fontSize: 14),)
                           : Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Color.fromRGBO(246, 7, 7, 1),fontSize: 14),)),)),
                       Expanded(child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,bottom: MediaQuery.of(context).size.height*0.015),child: AutoSizeText(detaildata["Products"][i]["Name"].toString(),maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),))])
                           : Row(children:[
                          Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: 5),child:  Directionality(textDirection: TextDirection.rtl,child:
                             Text(detaildata["Products"][i]["SalePrice"].toString()+"ريال",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(246, 7, 7, 1),fontSize: 14),)),)),
                            Expanded(flex: 2,child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,bottom: 1),child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(detaildata["Products"][i]["Name"].toString(),maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),))]),
                    ),Spacer(),
                    InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).plus(detaildata["Products"][i]["ID"] ,i, num,detaildata["Products"][i]["Price"] , context) ,child: Container( height: 30,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:Radius.circular(20) ),color: Color.fromRGBO(69, 190, 0, 1)) ,margin: EdgeInsets.only()  ,child:  Center(child: AutoSizeText("اضافة للعربة",maxLines: 1,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),)),)),
                  ],)
                    ,),
                ),
                );
              }),),
            ),
          )
        ],),
      ),
    ),);
  }
  reservation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Location();
    }));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(rating : rat , id:id ,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
     Navigator.of(context).pop();
  }

}