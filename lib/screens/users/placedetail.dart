import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/allreviews.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/allreviewsplace.dart';
import 'package:ezzproject/screens/location.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/reservation.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'notification.dart';
class Placedetail extends StatefulWidget{
  var detaildata;
  var idprovider;
  Placedetail({this.detaildata,this.idprovider});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateplacedetail(detaildata: detaildata,idprovider:idprovider);
  }
}
class Stateplacedetail extends State<Placedetail>{
  var index = 1;
  var title;
  List titles = ["بائعين جملة","بائعين الذبائح" ,"اسر منتجة","الطهاة والمطابخ" ,"ملاحم الجزيرة","أماكن","مأكولات بحرية","مزارع بيع الطيور","مراسيل","مزاد"];
  var section = "1";
  List shoppinglist =[];
  var kitchens = false;
  var idprovider;
  var datadetailpage;
  var detaildata;
  Showpagelogic showpagelogic;
  List photos =[];
  Detailpagelogic detailpagelogic;
  List features =[];
  Stateplacedetail({this.detaildata,this.idprovider});
  @override
  void initState() {
    print(idprovider);
    print(datadetailpage);
    for(int g = 0; g<detaildata["Photos"].length ; g++){
      if(g!=0) {
        photos.add(detaildata["Photos"][g]);
      }
    }
    if(detaildata["Feature"].toString().trim() != "[]") {
      features =
          detaildata["Feature"].toString().substring(1, detaildata["Feature"]
              .toString()
              .length - 1).split(",");
    }showpagelogic = new Showpagelogic(context);
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  List housesimg = [5,3,2];
  int totalprice ;
  var download ;
  getdata()async{
    Provider.of<Notifires>(context,listen: false).getplace3(detaildata["ID"]);
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
    detaildata = Provider.of<Notifires>(context).detailplacep;
    download = Provider.of<Notifires>(context).downloadp3;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:download?Container(child: Center(child: CircularProgressIndicator(),),):ListView(children: [
        Container(child:Stack(children:[Container(height: MediaQuery.of(context).size.height*0.5,width: MediaQuery.of(context).size.width,child:FadeInImage(placeholder: AssetImage("images/logoaz.png"),image:  NetworkImage(detaildata["Photos"][0]),fit: BoxFit.fill,),)
          ,Positioned(top: MediaQuery.of(context).size.height*0.32,child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.16 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black38.withOpacity(0.2)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
          Column(children: [
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.08,right:MediaQuery.of(context).size.width*0.08 ),child: Row(children: [
              Expanded(child: Container(child:Container(child: detaildata["UserFav"].toString()=="1"?
        InkWell(onTap: ()async{
          await showpagelogic.addtofavpalces(detaildata["ID"],context);
        }, child: Container(width: 27,
          height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
        ):InkWell(onTap: ()async{
          var result =await showpagelogic.addtofavpalces(detaildata["ID"],context);
          if(result =="done"){
            detaildata["UserFav"] = "1";
            setState(() {});
          }
        },
          child: Container(width: 27,
            height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black12.withOpacity(0.2)),child: Icon(Icons.favorite_border,color: Colors.white,size:20,),),
        ),)))
              ,Expanded(flex: 8,child: Container(alignment: Alignment.centerRight,child: Text(detaildata["Name"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.white),)))
            ],),)
            ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.08,right:MediaQuery.of(context).size.width*0.08 ),child: Row(children: [
              Expanded(flex: 3,child: InkWell(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return Allriviewsplaces(reviews: detaildata["reviews"] ==null?[] :detaildata["reviews"],idprovider:  idprovider,idplace: detaildata["ID"],rating: detaildata["Rating"].toString(),name: detaildata["Name"].toString(),photo: detaildata["Photos"][0],);
                }));
              },child: Container(decoration: BoxDecoration(color: Color.fromRGBO(126, 126, 126, 0.7) ,borderRadius: BorderRadius.circular(20) ), padding: EdgeInsets.all(2),alignment: Alignment.center,child: Center(child: FittedBox(child: AutoSizeText("مشاهدة تقييم المكان",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),))),))),
              Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width*0.05,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),decoration: BoxDecoration(),alignment: Alignment.center,child: Row(children:[Container(child:Center(child: AutoSizeText(detaildata["Rating"].toString(),maxLines: 1,style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold),))), Icon(Icons.star,color: Colors.yellow.withGreen(200),size: 20)]),)),)
              , Expanded(child: Container(alignment: Alignment.centerRight,child: Center(child:FittedBox(child: AutoSizeText("التقييم",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),))),))
            ],),)],)
            ,)),Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,child: InkWell(onTap: (){
              navigateback();
          },
              child: Container(padding: EdgeInsets.only( left:10 ,bottom: 10,top: 10) ,decoration: BoxDecoration(shape: BoxShape.circle,color: Color.fromRGBO(117, 117, 117, 1).withOpacity(0.1)),
                child:Center(child:  Icon( Icons.arrow_back_ios,color: Colors.white,size: 30,))
              ),
            )),
        ] )),
        Container(
          child:photos.length ==0?Container(): Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,child: ListView.builder(itemCount: photos.length,scrollDirection: Axis.horizontal ,itemBuilder:(context,i){
            return Container(width: MediaQuery.of(context).size.width*0.3,height:MediaQuery.of(context).size.width*0.1,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image(image: NetworkImage(photos[i]),fit: BoxFit.fill,)),);
          }),),
        ),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: Row(children: [
          Expanded(child:InkWell(child: Container( alignment: Alignment.centerLeft,margin: EdgeInsets.only(right: 52),child: Center(child: Directionality(textDirection: TextDirection.rtl,
              child:ListTile(title:Text(detaildata["DayRental"].toString()+" ريال",style: TextStyle(fontSize: 22),) ,subtitle: Text("لليلة/",style: TextStyle(fontSize: 10)),) )),))),
          Expanded(child:InkWell(onTap: ()=>reservation(detaildata["DayRental"] , detaildata["ID"],),child: Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(),color: Color.fromRGBO(69, 190, 0, 1),child: Center(child: Text("احجز الان",style: TextStyle(color: Colors.white),)),)))
        ],),),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.rtl,
          child: Row(children: [
            Container(child: Icon(Icons.location_on_rounded,color: Colors.red,size: MediaQuery.of(context).size.width*0.06,),),
            Container(child: Text(detaildata["Address"].toString(),style: TextStyle(fontSize: 10,color: Color.fromRGBO(152, 152, 152, 1)),),)
          ],),
        ),),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("وصف الاستراحة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),) ,),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),child:AutoSizeText(detaildata["Desc"],maxLines: 2,style: TextStyle(fontSize: 14,color: Color.fromRGBO(117, 117, 117, 1)),) ,)),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("التفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),) ,),
        Container(
          child:features.length==0?Container(): Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),height: MediaQuery.of(context).size.height*0.2,child: GridView.builder( physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio: 3),scrollDirection: Axis.vertical,itemCount:features.length ,itemBuilder: (context,i){
            return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,decoration:BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(20)),child: Center(child: Text(features[i],style: TextStyle(color: Colors.black26,fontSize: MediaQuery.of(context).size.width*0.03),)),);
          }),),
        ),
        Container(margin: EdgeInsets.only(right: 23),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م "+detaildata["Area"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)),)),)),
          Expanded(child: Container(alignment: Alignment.centerRight,child: Text("المساحة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: 23),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["SpaceCount"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)),)),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد الاشخاص",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: 21),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["LevelCount"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)),)),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("عدد الادوار",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: 25),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["RoomCount"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)),)),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد الغرف",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.only(right:25),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["BathroomCount"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)))),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد دورات المياه",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: 25),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["KitchenRoomCount"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 86, 86, 1)))),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("المطبخ",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold,color: Color.fromRGBO(69, 190, 0, 1)),),)),
        ],),),
        Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child: Divider(color: Colors.black26,thickness: 1.2,),)
        ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("الأسعار",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),) ,),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center,child:Directionality(textDirection: TextDirection.rtl,child:FittedBox(child: Text("SAR  "+detaildata["DayRental"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12)))),)),
          Expanded(child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Text("سعر تأجيره الأيام العادية",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold),)),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,top: MediaQuery.of(context).size.height*0.01),
          child: Row(children: [
            Expanded(child: Container(alignment: Alignment.center,child:Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: Text("SAR  "+detaildata["WeeklyRental"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12)))),)),
            Expanded(child: Container(alignment: Alignment.centerRight,child:FittedBox(child: Text("سعر تأجيره نهاية اللأسبوع",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold),)),)),
          ],),
        ),
        Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child: Divider(color: Colors.black26,thickness: 1.2,),),
       Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.02 ) ,child: Directionality(textDirection: TextDirection.rtl,
         child: Row(children: [
           Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("الموقع على الخريطة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold),) ,)),
           Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:InkWell(onTap: ()async{
if (await canLaunch(detaildata["address_link"])) {
      await launch(detaildata["address_link"]);
    } else {
      throw 'Could not launch ';
    }
           },child: Text("اضغط هنا",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*14,fontWeight: FontWeight.bold),)) ,))
         ],),
       ),)
      ])));
  }
  reservation(price,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Reservation(price: price,id: id,price2: detaildata["WeeklyRental"],idprovider: idprovider,);
    }));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(rating : rat , id:id);
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }

}