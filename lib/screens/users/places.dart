import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/chat.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/detailpage.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/partner.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/placedetail.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/profile.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/shoppingcart.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification.dart';

class Places extends StatefulWidget{
  List places =[];
  var name;
  var idprovider;
  Places({this.places,this.name,this.idprovider});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateplaces(places :places,name:name,idprovider:idprovider);
  }
}
class Stateplaces extends State<Places> with SingleTickerProviderStateMixin{
  List places =[];
  var name;
  var idprovider;
  List placessearch =[];
  Stateplaces({this.places,this.name,this.idprovider});
  TextEditingController query ;
  Showpagelogic showpagelogic;
  var download ;
  @override
  void initState() {
    print(idprovider);
    showpagelogic = new Showpagelogic(context);
    query = new TextEditingController();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
     placessearch = Provider.of<Notifires>(context).searchplaces;
     places = Provider.of<Notifires>(context).placep;
     download = Provider.of<Notifires>(context).downloadp2;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(
                child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Row(children: [
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText(name.toString(),style: TextStyle(color: Colors.white,fontSize: 17),))),
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                  ],),
                ), Spacer(), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(left: 26,right:20,bottom: 23 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                  ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                      Provider.of<Notifires>(context, listen: false)
                          .searchplace(places, val);
                  }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
          )),
        ),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04),height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width,child:download?Container(child: Center(child: CircularProgressIndicator(),),): places.length==0?Container(
          child: Center(child: Text("لا توجد أية عناصر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ): query.text==""? GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (160/210),
        ),itemCount: places.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 1.0,
              spreadRadius: 3.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 160,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight:Radius.circular(20) ) ,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(places[i]["Photos"][0]),)),),
                Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:Container(child: places[i]["UserFav"].toString()=="1"?
                InkWell(onTap:()async{
                  await showpagelogic.addtofavpalces(places[i]["ID"],context);
                }, child: Container(width: 27,
                    height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                ):InkWell(onTap: ()async{
                  await showpagelogic.addtofavpalces(places[i]["ID"],context);
                },
                  child: Container(width: 27,
                    height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black12.withOpacity(0.2)),child: Icon(Icons.favorite_border,color: Colors.white,size:20,),),
                ),)) ])),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 10) ,child: AutoSizeText(places[i]["Name"],maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: 15),),)
              ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                Expanded(flex: 20,child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                    child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 1,itemBuilder: (context,i){
                      return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Color.fromRGBO(255, 102, 118, 1),size: 15));
                    }),
                  ),
                )),Expanded(child: Container(height: MediaQuery.of(context).size.height*0.03,alignment: Alignment.center,child: FittedBox(child: Text(places[i]["Rating"].toString().substring(0,places[i]["Rating"].toString().length-3),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))),),
              ]) ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 12),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+places[i]["WeeklyRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),)))),
            ],)
              ,),
          );
        }):GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (160/210),
        ),itemCount: placessearch.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 1.0,
              spreadRadius: 3.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 160,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight:Radius.circular(20) ) ,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(placessearch[i]["Photos"][0]),)),),
                Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:Container(child: placessearch[i]["UserFav"].toString()=="1"?
                        InkWell(onTap: ()async{
                          await showpagelogic.addtofavpalces(placessearch[i]["ID"],context);
                          query.text = "";
                          setState(() {});
                        },
                          child: Container(width: 27,
                            height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                        ):InkWell(onTap: ()async{
                         await showpagelogic.addtofavpalces(placessearch[i]["ID"],context);
                         query.text = "";
                         setState(() {});
                           } ,
                          child: Container(width: 27,
                            height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black12.withOpacity(0.2)),child: Icon(Icons.favorite_border,color: Colors.white,size:20,),),
                        ),)) ])),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.025) ,child: AutoSizeText(placessearch[i]["Name"],maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: 15),),)
              ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                Expanded(flex: 20,child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                    child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 1,itemBuilder: (context,i){
                      return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Color.fromRGBO(255, 102, 118, 1),size: 15));
                    }),
                  ),
                )),Expanded(child: Container(height: MediaQuery.of(context).size.height*0.03,alignment: Alignment.center,child: FittedBox(child: Text(placessearch[i]["Rating"].toString().substring(0,placessearch[i]["Rating"].toString().length-3),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))),),
              ]) ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+placessearch[i]["WeeklyRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: 12,color: Color.fromRGBO(86, 86, 86, 1),fontWeight: FontWeight.bold),)))),
            ],)
              ,),
          );
        }))
            ],),),
          );
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  getdata() async{
   // print(subcategories);
    Future.delayed(const Duration(milliseconds: 200), () {
      Provider.of<Notifires>(context,listen: false).getplace2(idprovider);
    });
  }
  showdetail(i,search){
    var kitchen;
    //if(section =="1"){
    //  kitchen =false;
    // }
    //  if(section=="2"){
    kitchen = false;
    // }
    print(places[i]);
    if(search){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: placessearch[i],idprovider: idprovider,);
      }));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: places[i],idprovider: idprovider,);
      }));
    }
  }
}