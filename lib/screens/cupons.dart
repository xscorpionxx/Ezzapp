import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cupons extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statecupons();
  }
}
class Statecupons extends State<Cupons>{
  @override
  void initState() {
    super.initState();
  }
  deleteservice(int i){
    return showDialog( context: context, builder: (context) {
      return StatefulBuilder(builder: (Context , setState){
        return AlertDialog(
            content:Container(height: MediaQuery.of(context).size.height*0.25,
              child: Column(children: [
                Container(child: Text("حذف الخدمة"),)
                ,Container (child: Text("هل تريد حذف الخدمة"),),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  child: Row(
                      children:[ Expanded(flex: 3,
                        child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.black26 ,borderRadius: BorderRadius.circular(5)),
                          child: Text("رفض", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,),
                      ),Expanded(child: Container()),
                        Expanded(flex: 3,child:  Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
                          child: Text("موافق", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,)),
                      ]),
                )
              ],),
            )
        );},
      );
    });
  }
  List cupons =[{"name":"dwad","service":"adwwa,adawdas,asfe","price":15,"able":false}];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child:Row(children:[
              Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){},))),
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("كوبونات الخصم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.03),))),
              Expanded(child: Container())
            ])), ),Container(child:cupons.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.center ,child: Text("لا توجد كوبونات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),)
            :Column(
          children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),)),Expanded(child: Column(children: [
            Container(child: Text("الكوبونات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),),
            Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+cupons.length.toString()+"من الكوبونات " ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),)
          ],))],),),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.4 ,child: ListView.builder(itemCount: cupons.length,itemBuilder: (context,i){
              return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black54)),height: MediaQuery.of(context).size.height*0.21,width: MediaQuery.of(context).size.width,
                  child: Column(
                    children:[
                         Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerRight ,child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الكوبون : "),Text(cupons[i]["name"],style: TextStyle(color: Colors.black54),)]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("قيمة الخصم : "),Text(cupons[i]["price"].toString(),style: TextStyle(color: Colors.black54))]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("الخدمة : "),Text(cupons[i]["service"].toString(),style: TextStyle(color: Colors.black54))]),))
                        ],),),
                      Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                        Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:IconButton(icon:Icon( Icons.delete,color: Colors.red,),onPressed: ()=>deleteservice(i),)),
                        Container(child:Icon(Icons.edit,color: Colors.green,))
                        ,InkWell( onTap: (){
                          if(cupons[i]["able"] ==true){
                            print("true");
                            setState(() {
                              cupons[i]["able"] =false;
                            });
                          }
                        },child: Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:cupons[i]["able"]? Colors.black26:Colors.red ),child:Center(child: Text("معطل",style: TextStyle(color:cupons[i]["able"]? Colors.black38:Colors.white),)),)),
                        InkWell(onTap: (){
                          if(cupons[i]["able"] ==false){
                            print("false");
                            setState(() {
                              cupons[i]["able"] =true;
                            });
                          }
                        },child: Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:cupons[i]["able"]? Colors.green:Colors.black26.withOpacity(0.1) ),child: Center(child: Text("فعال",style: TextStyle(color:cupons[i]["able"]? Colors.white:Colors.black38),)),)),
                      ],),)
                    ],));
            }),)
          ],
        ))
      ],),
    ),);
  }
}