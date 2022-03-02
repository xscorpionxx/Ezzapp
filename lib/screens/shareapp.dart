import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'users/notification.dart';

class Shareapp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateshareapp();
  }
}
class Stateshareapp extends State<Shareapp>{
  TextEditingController password ;
  TextEditingController passwordnewre ;
  TextEditingController passwordnew ;
  var data= {"stock" : "2000ريال"};
  List datas = [{"price" : "2000" , "name" :"ahmad"},{"price" : "2000" , "name" :"ahmad"},{"price" : "2000" , "name" :"ahmad"}];
  @override
  void initState() {
    password = new TextEditingController();
    passwordnewre = new TextEditingController();
    passwordnew = new TextEditingController();
    super.initState();
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
          Container(child:
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("شارك التطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  Expanded(flex: 2,child:InkWell(onTap: null,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                ],),
              )),
        ),
        Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.05,left: MediaQuery.of(context).size.width*0.05) ,decoration: BoxDecoration(color: Colors.green.withOpacity(0.2),borderRadius: BorderRadius.circular(10)) ,child: Row(children: [
          Expanded(child: Container(child: Column(children: [
            Container(child: Text("رابط المشاركة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),),),
            Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black38,width: 1.4),borderRadius: BorderRadius.circular(5)) ,child:Icon(Icons.share_outlined,color: Colors.green,) )
          ],),)),
          Expanded(child: Container(child: Container(width: MediaQuery.of(context).size.width*0.01,height: MediaQuery.of(context).size.height*0.07,child:
            VerticalDivider(color: Colors.black12,thickness: 1.7,),),))
          ,Expanded(child: Container(child: Column(children: [
            Container(child: Text("الرصيد المتاح",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),),
            Container(child: Text(data["stock"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),)
          ],),))
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03) ,alignment: Alignment.centerRight,child: Text("عملاء اشتروا من خلال رابطك",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),)
        ,Container(height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder( itemCount: datas.length,itemBuilder: (context,i){
          return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: Column(
            children:[Container(child: Row(children: [
              Expanded(flex: 2,child: Container(child: Column(children: [
                Container(child: Text("مشتريات بقيمة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),),),
                Container(child: Text(datas[i]["price"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.04),),),
              ],),)),
              Expanded(flex: 3,child:  Container(alignment: Alignment.centerRight,child: Text( datas[i]["name"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),),))
              ,Expanded(child: Container( child: Image(fit: BoxFit.fill,image: AssetImage("images/logoaz.png"),),))
            ],)),
              Container(child: Divider(color: Colors.black38,thickness: 1.3,),)
          ]),);
        }),)
      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}