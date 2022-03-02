import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/home2.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/home.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/provider/home2.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/showpage.dart';
import 'file:///D:/androidprojects/ezzproject/lib/screens/users/subcats.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ezzproject/logic/reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Mainlogic{
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  var status ;
  var data;
  var accountstatus;
  var token ;
  var type;
 Future<String> gettoken(){
   fire.getToken().then((value){
      token = value;
      return value;
    });
  }
  Future login(email ,password)async{
      var data = {"phone": email, "password": password, "fb_token": token.toString()};
      //put here the url to add account
      var url = "https://azz-app.com/api/login";
      var response = await http.post(Uri.parse(url), body: data);
      var body = jsonDecode(response.body);
      if (body["status"] == true) {
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        sharedPreferences.setString("token", body["data"]["API_Key"]);
      }
      accountstatus = body["data"]["AccountStatus"];
      status = body["status"];
      type = body["data"]["Type"];
      return body["msg"];
  }
  Future getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.setString("basket", "null");
    var email =   sharedPreferences.getString("phone");
    var token = sharedPreferences.getString("token");
    var pass = sharedPreferences.getString("password");
    var logintype = sharedPreferences.getString("logintype");
    data ={
      "phone" :email , "token" : token,"password" : pass , "logintype" : logintype
    };
    return data ;
  }
}
class Notifires extends ChangeNotifier {
  Notifires({this.maincontext});
  var maincontext;
  List homedata = [];
  List banner = [];
  var adtime;
  List ads = [];
  var downloadhome = true;
  // جلب جميع بيانات صفحىة الرئيسية مستخدم مع ترتيبها بالاضافة لاعلان والسلايدر
  void getdatahomecats(context) async {
    if (homedata.length >= 1) {
      homedata.clear();
      notifyListeners();
    }
    if (!downloadhome) {
      downloadhome = true;
      notifyListeners();
    }
    Homelogic homelogic = Homelogic(context);
    var dats = await homelogic.getdata();
    homedata = dats["categories"];
    List homedatas = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null
    ];
    for (int f = 0; f < homedata.length; f++) {
      if (homedata[f]["Name"] == "مزاد") {
        homedatas[0] = homedata[f];
      } else {
        if (homedata[f]["Name"] == "مراسيل") {
          homedatas[1] = homedata[f];
        } else {
          if (homedata[f]["Name"] == "بائعين ذبائح") {
            homedatas[2] = homedata[f];
          }
          else {
            if (homedata[f]["Name"] == "بائعين جمله") {
              homedatas[3] = homedata[f];
            } else {
              if (homedata[f]["Name"] == "الطهاة والمطابخ") {
                homedatas[4] = homedata[f];
              } else {
                if (homedata[f]["Name"] == "أسر منتجة") {
                  homedatas[5] = homedata[f];
                }
                else {
                  if (homedata[f]["Name"] == "اماكن") {
                    homedatas[6] = homedata[f];
                  } else {
                    if (homedata[f]["Name"] == "ملاحم الجزارة") {
                      homedatas[7] = homedata[f];
                    } else {
                      if (homedata[f]["Name"] == "مزارع بيع الطيور") {
                        homedatas[8] = homedata[f];
                      }
                      else {
                        if (homedata[f]["Name"] == "ماكولات بحرية") {
                          homedatas[9] = homedata[f];
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    homedata = homedatas;
    print(homedata);
    adtime = dats["adtime"];
    banner = dats["banner"];
    ads = dats["ad"];
    print(ads);
    print(homedata);
    downloadhome = false;
    notifyListeners();
  }
  //من خلالها امنع عرض الاعلان مرة اخرى
  var adsable = true;
  setads() {
    adsable = false;
    notifyListeners();
  }
  //امكانية البحث
  var searchable = false;
  setsearch() {
    if (searchable) {
      searchable = false;
    }
    else {
      searchable = true;
    }
    notifyListeners();
  }
  //بيانات البروفايل
  var profiledata;
  var dwonloadpro = true;
  void getprofile(context, update) async {
    print(profiledata);
    if (profiledata == null || update) {
      if (!dwonloadpro) {
        dwonloadpro = true;
        notifyListeners();
      }
      Homelogic homelogic = Homelogic(context);
      var dats = await homelogic.getprofiledata();
      print("gere");
      print(dats);
      profiledata = dats["profiledata"];
      dwonloadpro = false;
      notifyListeners();
    }
  }

  var histfrom;
  var histto;
  homeproviderhist(type, value) {
    if (type == "1") {
      histfrom = value;
    } else {
      histto = value;
    }
    notifyListeners();
  }
  // عمل ريسيت للقيم
  resetdata() {
    profiledata = null;
    services = [];
  }
  List providers = [];
  var downloadshowpage = true;
  // عرض التجار
  void getdatashowpage(id, subcategories, context) async {
    if (providers.length >= 1) {
      providers.clear();
      notifyListeners();
    }
    if (!downloadshowpage) {
      downloadshowpage = true;
      notifyListeners();
    }
    Showpagelogic showpagelogic = new Showpagelogic(context);
    var dats = await showpagelogic.getshowpage(id, subcategories);
    if (dats == null) {
      providers = [];
    }
    else {
      providers = dats;
    }
    print(providers);
    downloadshowpage = false;
    notifyListeners();
  }

  //places
  var downloadp1 = true;
  var downloadp2 = true;
  var downloadp3 = true;
  var downloadp4 = true;
  List providerp = [];
  List placep = [];
  var detailplacep;

  List reviewsp = [];
  var idp1;
  var idp2;
  var subp;
  var idp0;
  // جلب تجار الاماكن
  void getplace1(id, subcategories, context) async {
    subp = subcategories;
    idp0 = id;
    idp1 = null;
    idp2 = null;
    if (providerp.length >= 1) {
      providerp.clear();
      downloadp1 = true;
      downloadp2 = true;
      downloadp3 = true;
      downloadp4 = true;
      notifyListeners();
    }
    Showpagelogic showpagelogic = new Showpagelogic(context);
    var dats = await showpagelogic.getshowpage(id, subcategories);
    if (dats == null) {
      providerp = [];
    }
    else {
      providerp = dats;
    }
    print(providerp);
    downloadp1 = false;
    notifyListeners();
  }
  // تحديث البيانات
  void updatepalce(context) async {
    providerp.clear();
    downloadp1 = true;
    downloadp2 = true;
    downloadp3 = true;
    downloadp4 = true;
    notifyListeners();
    Showpagelogic showpagelogic = new Showpagelogic(context);
    var dats = await showpagelogic.getshowpage(idp0, subp);
    if (dats == null) {
      providerp = [];
    }
    else {
      providerp = dats;
    }
    downloadp1 = false;
    if (idp1 != null) {
      getplace2(idp1);
      if (idp2 != null) {
        getplace3(idp2);
        getplace4();
      }
    }
    notifyListeners();
  }
  // جلب الاماكن لكل تاجر
  void getplace2(id) {
    for (int g = 0; g < providerp.length; g++) {
      if (providerp[g]["ID"].toString() == id.toString()) {
        print(providerp);
        placep = providerp[g]["Products"];
      }
    }
    print(placep);
    idp1 = id;
    downloadp2 = false;
    notifyListeners();
  }
  // جلب بيانات المكان
  void getplace3(id) {
    for (int g = 0; g < placep.length; g++) {
      if (placep[g]["ID"].toString() == id.toString()) {
        detailplacep = placep[g];
      }
    }
    idp2 = id;
    downloadp3 = false;
    notifyListeners();
  }
  // جلب تعليقات عل مكان
  void getplace4() {
    print(detailplacep);
    reviewsp = detailplacep["reviews"];
    downloadp4 = false;
    notifyListeners();
  }
  // جلب بيانات الهوم للتاجر
  Map<dynamic, dynamic> home_provider = {
    "ProviderCancelHint": " ",
    "ProviderCommission": "0",
    "ProviderTransport": "0",
    "ProviderInOrder": "0",
    "ProviderNewOrder": "0",
    "ProviderCancelOrder": "0",
    "ProviderCompleteOrder": "0",
    "ProviderStatus": "1",
    "ProviderTotalSales": "0"
  };
  var downloadhome2 = true;
  var plege;
  void gethome_provider(context) async {
    if (!downloadhome2) {
      downloadhome2 = true;
      notifyListeners();
    }
    Home2logic home2 = new Home2logic(context);
    var dats = await home2.gethomeprovider();
    home_provider = null;
    home_provider = dats["1"];
    plege = dats["2"];
    downloadhome2 = false;
    notifyListeners();
  }
   // جلب المستحقات للتاجر
  var rewards;
  void getrewards(context, histfrom, histto) async {
    Home2logic home2 = new Home2logic(context);
    var dats = await home2.getrewards(histfrom, histto);
    rewards = dats;
    notifyListeners();
  }
   // تخص الاعلانات
  adsgotosubcats(context, name, subcats, subid) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Subcats(name: name,
        data: subcats,
        tabcontroller: "",
        maincontext: context,
        idad: subid,);
    }));
  }
  adsgotosubcats2(context, subid, data, name) {
    for (int y = 0; y < data.length; y++) {
      if (data[y]["ID"].toString() == subid.toString()) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Showpage(
            cat: name,
            id: data[y]["ID"],
            name: data[y]["Name"],
            subcategories: data,
            tabcontroller: "",
            maincontext: context,
            navigate: false,
            ketchintype: data[y]["Type"].toString(),);
        }));
      }
    }
  }
  // جلب الطلبات مستخدم
  List myorders = [];
  var dwonloador = true;
  void getmyorders(context) async {
    if (!dwonloador) {
      dwonloador = true;
      notifyListeners();
    }
    Homelogic homelogic = Homelogic(context);
    var dats = await homelogic.getmyorders();
    if (dats.length == 0) {
      myorders = [];
      notifyListeners();
    }
    else {
      myorders = dats;
    }
    dwonloador = false;
    notifyListeners();
  }
   // جلب المنتجات في السلة
  List shoppinglist = [];
  void getdatadetailpage(products) async {
    shoppinglist.clear();
    totalprice = 0;
    for (int i = 0; i < products.length; i++) {
      shoppinglist.add({"id": products[i]["ID"], "num": 0});
    }
    print("done");
    print(shoppinglist);
    notifyListeners();
  }
  int totalprice = 0;
  //  اضافة منتج من صفحة التفاصيل
  plus(id, i, num, price, context) async {
    Detailpagelogic detailpagelogic = new Detailpagelogic(context);
    //shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
    // totalprice = totalprice + price;
    var trues = await detailpagelogic.addtocart(id.toString(), true);
    if (trues) {
      Alertdialogazz.alert(context, "تمت الاضافة للعربة");
      notifyListeners();
    }
    else {
      shoppinglist[i]["num"] = shoppinglist[i]["num"] - 1;
      totalprice = totalprice - price;
      notifyListeners();
    }
  }

  var valuehome2 = "يومي";

  setvalue(_) {
    valuehome2 = _;
    notifyListeners();
  }
  List shoppingcart = [];
  int totalpricecart = 0;
  // اضافة منتج من صفحة السلة
  plus2(id, i, num, price, context) async {
    Detailpagelogic detailpagelogic = new Detailpagelogic(context);
    //shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
    //totalpricecart = totalpricecart + price;
    var trues = await detailpagelogic.addtocart(id.toString(), true);
    if (trues) {
      Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
      var dats = await shoppingcartlogic.getcart();
      if (dats["data"]["products"].toString().trim() == "null") {}
      else {
        shoppingcart = dats["data"]["products"];
        totalpricecart = 0;
        for (int f = 0; f < dats["data"]["products"].length; f++) {
          print(totalpricecart.toString());
          print(int.parse(totalpricecart.toString()));
          totalpricecart =
              int.parse(dats["data"]["products"][f]["Total"].toString()) +
                  int.parse(totalpricecart.toString());
        }
      }
      notifyListeners();
    }
    else {
      shoppinglist[i]["num"] = shoppinglist[i]["num"] - 1;
      totalprice = totalprice - price;
      notifyListeners();
    }
  }
  // حذف منتج من صفحة السلة
  minus2(id, i, num, price, context) async {
    if (num != 1) {
      Detailpagelogic detailpagelogic = new Detailpagelogic(context);
      //shoppinglist[i]["num"] = shoppinglist[i]["num"]-1;
      //totalpricecart = totalpricecart - price;
      var trues = await detailpagelogic.addtocart(id.toString(), false);
      if (trues) {
        Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
        var dats = await shoppingcartlogic.getcart();
        if (dats["data"]["products"].toString().trim() == "null") {}
        else {
          shoppingcart = dats["data"]["products"];
          totalpricecart = 0;
          for (int f = 0; f < dats["data"]["products"].length; f++) {
            print(totalpricecart.toString());
            print(int.parse(totalpricecart.toString()));
            totalpricecart =
                int.parse(dats["data"]["products"][f]["Total"].toString()) +
                    int.parse(totalpricecart.toString());
          }
        }
        notifyListeners();
      }
      else {
        shoppinglist[i]["num"] = shoppinglist[i]["num"] + 1;
        totalprice = totalprice + price;
        notifyListeners();
      }
    }
  }
  // حذف منتج
  delete(i, price, context) async {
    Shoppingcartlogic shoppingcartlogic = new Shoppingcartlogic(context);
    var trues = await shoppingcartlogic.delteproduct(shoppinglist, i);
    if (trues) {
      var totalsprice = int.parse(price.toString()) *
          int.parse(shoppinglist[i]["num"].toString());
      totalprice = totalprice - totalsprice;
      shoppinglist.removeAt(i);
      shoppingcart.removeAt(i);
      print(totalsprice);
      notifyListeners();
    }
    else {}
  }
  // المفضلة
  List favdata = [];
  var downloadfav = true;
  void getfav(context) async {
    if (!downloadfav) {
      downloadfav = true;
      notifyListeners();
    }
    Homelogic homelogic = Homelogic(context);
    var dats = await homelogic.getfav(context);
    print(dats);
    print("here");
    downloadfav = false;
    if (dats == null) {
      notifyListeners();
    }
    else {
      favdata = dats;
      notifyListeners();
    }
  }
  // بحث
  List searchresult = [];
  search(List data, var query) async {
    var newlist = [];
    for (int r = 0; r < data.length; r++) {
      newlist.add(data[r]["Name"]);
    }
    newlist =
    query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest = [];
    for (int e = 0; e < data.length; e++) {
      for (int s = 0; s < newlist.length; s++) {
        if (data[e]["Name"].toString().trim() == newlist[s]) {
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchresult = newlistsuggest;
    print(searchresult);
    notifyListeners();
  }
   // بحث شات تاجر
  List searchresultchat = [];
  searchproviderchat(List data, var query) async {
    var newlist = [];
    for (int r = 0; r < data.length; r++) {
      if (data[r]["user_id"].toString() == data[r]["SenderID"].toString()) {
        newlist.add(data[r]["SenderName"]);
      } else {
        newlist.add(data[r]["ReciveName"]);
      }
    }
    newlist =
    query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest = [];
    for (int e = 0; e < data.length; e++) {
      for (int s = 0; s < newlist.length; s++) {
        if (data[e]["user_id"].toString() == data[e]["SenderID"].toString()) {
          if (data[e]["SenderName"].toString().trim() == newlist[s]) {
            newlistsuggest.add(data[e]);
          }
        } else {
          if (data[e]["ReciveName"].toString().trim() == newlist[s]) {
            newlistsuggest.add(data[e]);
          }
        }
      }
    }
    searchresultchat = newlistsuggest;
    notifyListeners();
  }
  // بحث مستخدم شات
  searchuserchat(List data, var query) async {
    var newlist = [];
    for (int r = 0; r < data.length; r++) {
      if (data[r]["provider_id"].toString() == data[r]["SenderID"].toString()) {
        newlist.add(data[r]["SenderName"]);
      } else {
        newlist.add(data[r]["ReciveName"]);
      }
    }
    newlist =
    query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest = [];
    for (int e = 0; e < data.length; e++) {
      for (int s = 0; s < newlist.length; s++) {
        if (data[e]["provider_id"].toString() ==
            data[e]["SenderID"].toString()) {
          if (data[e]["SenderName"].toString().trim() == newlist[s]) {
            newlistsuggest.add(data[e]);
          }
        } else {
          if (data[e]["ReciveName"].toString().trim() == newlist[s]) {
            newlistsuggest.add(data[e]);
          }
        }
      }
    }
    searchresultchat = newlistsuggest;
    notifyListeners();
  }

  List searchplaces = [];
  List searchresult2 = [];
  // بحث تجار
  search2(List data, var query) async {
    var newlist = [];
    for (int r = 0; r < data.length; r++) {
      newlist.add(data[r]["Name"]);
    }
    newlist =
    query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest = [];
    for (int e = 0; e < data.length; e++) {
      for (int s = 0; s < newlist.length; s++) {
        if (data[e]["Name"].toString().trim() == newlist[s]) {
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchresult2 = newlistsuggest;
    print(searchresult);
    notifyListeners();
  }
  // بحث اماكن
  searchplace(List data, var query) async {
    var newlist = [];
    for (int r = 0; r < data.length; r++) {
      newlist.add(data[r]["Name"]);
    }
    newlist =
    query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest = [];
    for (int e = 0; e < data.length; e++) {
      for (int s = 0; s < newlist.length; s++) {
        if (data[e]["Name"].toString().trim() == newlist[s]) {
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchplaces = newlistsuggest;
    for (int g = 0; g < searchplaces.length; g++) {
      print(searchplaces[g]["Name"]);
    }
    notifyListeners();
  }
  // تنقل بار في مستخدم
  var active = "home";
  void getindex(tab, name, ind, context) {
    active = name;
    tab.animateTo(ind);
    notifyListeners();
  }
  // بار في صفحة التجار
  void getindexshowpage(TabController tab, name, ind, context) async {
    active = name;
    tab.animateTo(ind, duration: Duration(milliseconds: 1));
    notifyListeners();
    if (active == "home") {
      Navigator.of(context).pop();
    }
    if (active == "favo") {
      getfav(context);
      Navigator.of(context).pop();
    }
    if (active == "req") {
      getmyorders(context);
      Navigator.of(context).pop();
    }
    if (active == "more") {
      getprofile(context, false);
      Navigator.of(context).pop();
    }
  }
  //  بار صفحة اساسية تاجر
  var active2 = "home";
  void getinde2x(tab, name, ind, context) {
    active2 = name;
    tab.animateTo(ind);
    notifyListeners();
  }

  void reset() {
    active2 = "home";
    active = "home";
    notifyListeners();
  }
  // خدمات التاجر
  List services = [];
  var downloadreq2 = true;
  void getservices(context) async {
    downloadreq2 = true;
    services.clear();
    notifyListeners();
    Home2logic home2logic = Home2logic(context);
    var dats = await home2logic.getservices();
    services = dats;
    downloadreq2 = false;
    notifyListeners();
  }
  // تغيير من مزاد لخدمات
  var sectionm = "1";
  changesecm(value) {
    sectionm = value;
    notifyListeners();
  }
  // جلب مزادات
  List mazads = [];
  var downloadmazad = true;
  void getmazads(context) async {
    downloadmazad = true;
    mazads.clear();
    notifyListeners();
    Home2logic home2logic = Home2logic(context);
    var dats = await home2logic.getmazads();
    mazads = dats;
    downloadmazad = false;
    notifyListeners();
  }
  // جلب طلبات تاجر
  var downloadreqs = true;
  List reqs = [];
  List onworklist = [];
  List donelist = [];
  List canceldlist = [];
  void getreqs(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
    var servicetypespec = sharedPreferences.getString("servicetypespec");
    if (servicetypespec == "true") {
      downloadreqs = true;
      reqs.clear();
      onworklist.clear();
      donelist.clear();
      canceldlist.clear();
      notifyListeners();
      Home2logic home2logic = Home2logic(context);
      var dats = await home2logic.getreqsevents();
      for (int f = 0; f < dats.length; f++) {
        if (dats[f]["EventStatus"].toString() == "1") {
          onworklist.add(dats[f]);
        }
        else if (dats[f]["EventStatus"].toString() == "4" ||
            dats[f]["EventStatus"].toString() == "5") {
          canceldlist.add(dats[f]);
        }
        else if (dats[f]["EventStatus"].toString() == "0") {
          reqs.add(dats[f]);
        }
        else {
          donelist.add(dats[f]);
        }
      }
      downloadreqs = false;
      notifyListeners();
    }
    else {
      if (servicetype == "مراسيل") {
        downloadreqs = true;
        reqs.clear();
        notifyListeners();
        Home2logic home2logic = Home2logic(context);
        var dats = await home2logic.getreqsmarasil();
        reqs = dats;
        downloadreqs = false;
        notifyListeners();
      }
      else {
        downloadreqs = true;
        reqs.clear();
        onworklist.clear();
        donelist.clear();
        canceldlist.clear();
        notifyListeners();
        Home2logic home2logic = Home2logic(context);
        List dats = await home2logic.getreqs();
        print(dats);
        for (int f = 0; f < dats.length; f++) {
          if (dats[f]["OrderKeyStatus"].toString() == "1") {
            onworklist.add(dats[f]);
          }
          else if (dats[f]["OrderKeyStatus"].toString() == "4" ||
              dats[f]["OrderKeyStatus"].toString() == "5") {
            canceldlist.add(dats[f]);
          }
          else if (dats[f]["OrderKeyStatus"].toString() == "0") {
            reqs.add(dats[f]);
          }
          else {
            donelist.add(dats[f]);
          }
        }
        print(donelist);
        downloadreqs = false;
        notifyListeners();
      }
    }
  }

  List cupons = [];
  var downloadcupons = true;
  void getcupon(context) async {
    downloadcupons = true;
    cupons.clear();
    notifyListeners();
    Home2logic home2logic = Home2logic(context);
    var dats = await home2logic.getcupons();
    cupons = dats;
    downloadcupons = false;
    notifyListeners();
  }

  List reviews = [];
  var downloadallreviews = true;
  void getallreview(id, context) async {
    reviews.clear();
    downloadallreviews = true;
    notifyListeners();
    Reviewslogic reviewslogic = Reviewslogic(context);
    var dats = await reviewslogic.getreview(id);
    reviews = dats;
    downloadallreviews = false;
    notifyListeners();
  }

  var location;
  void getcart(context) async {
    if (shoppingcart.length >= 1) {
      shoppingcart.clear();
      notifyListeners();
    }
    print("here");
    Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
    var dats = await shoppingcartlogic.getcart();
    print(dats);
    print(dats["data"]["products"].toString().trim());
    if (dats["data"]["products"].toString().trim() == "null") {}
    else {
      shoppingcart = dats["data"]["products"];
      totalpricecart = 0;
      for (int f = 0; f < dats["data"]["products"].length; f++) {
        print(totalpricecart.toString());
        print(int.parse(totalpricecart.toString()));
        totalpricecart =
            int.parse(dats["data"]["products"][f]["Total"].toString()) +
                int.parse(totalpricecart.toString());
      }
      print(totalpricecart);
      shoppinglist.clear();
      for (int i = 0; i < shoppingcart.length; i++) {
        shoppinglist.add(
            {"id": shoppingcart[i]["ID"], "num": shoppingcart[i]["Qt"]});
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      location = sharedPreferences.getString("region1");
    }
    notifyListeners();
  }

  ///chat
  ///user
  var downchatuser = true;
  List messages1 = [];
  List lastmessages1 = [];
  List ids1 = [];
  List sub1 = [];

  getmessages() async {
    downchatuser = true;
    ids1.clear();
    sub1.clear();
    lastmessages1.clear();
    notifyListeners();
    allmessages.forEach((element) {
      ids1.add(element["provider_id"].toString());
    });
    ids1 = ids1.toSet().toList();
    ids1.forEach((element) {
      sub1.add({element.toString(): []});
    });
    for (int g = 0; g < ids1.length; g++) {
      for (int f = 0; f < allmessages.length; f++) {
        if (allmessages[f]["provider_id"].toString() == ids1[g]) {
          sub1[g][ids1[g]].add(allmessages[f]);
        }
      }
    }
    print(sub1.length);
    for (int d = 0; d < sub1.length; d++) {
      var last_message = sub1[d][ids1[d]][sub1[d][ids1[d]].length-1];
      lastmessages1.add(last_message);
      print("hi");
      print(lastmessages1);
    }
    downchatuser = false;
    notifyListeners();
  }

  //provider
  var downchatuser2 = true;
  List messages2 = [];
  List lastmessages2 = [];
  List ids2 = [];
  List sub2 = [];
  List firemessageroom = [];

  getmessagesfireroom(user_id, proid) {
    firemessageroom.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(user_id)
        .collection('messages')
        .orderBy("time")
        .snapshots()
        .listen((event) {
      firemessageroom.clear();
      List messages = [];
      event.docs.forEach((element) {
        if (element.data()["provider_id"].toString() == proid.toString()) {
          messages.add(element.data());
        }
      });
      firemessageroom = messages;
      notifyListeners();
    });
  }

  List firemessageroom2 = [];
  getmessagesfireroom2(proid, userid) {
    firemessageroom2.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(proid)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      firemessageroom2.clear();
      List messages = [];
      event.docs.forEach((element) {
        if (element.data()["user_id"].toString() == userid.toString()) {
          messages.add(element.data());
        }
      });
      firemessageroom2 = messages;
      notifyListeners();
    });
  }

  List listmessages = [];
  List allmessages = [];
  List allmessages2 = [];
  getlistmessages(userid) {
    allmessages.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(userid)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      allmessages.clear();
      event.docs.forEach((element) {
        allmessages.add(element.data());
      });
      print(allmessages);
      getmessages();
    });
  }
  getlistmessages2(providerid) {
    allmessages2.clear();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(providerid)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      allmessages2.clear();
      event.docs.forEach((element) {
        allmessages2.add(element.data());
      });
      print(allmessages2);
      getmessages2();
    });
  }

  getmessages2() async {
    downchatuser2 = true;
    messages2.clear();
    lastmessages2.clear();
    ids2.clear();
    sub2.clear();
    notifyListeners();
    allmessages2.forEach((element) {
      ids2.add(element["user_id"].toString());
    });
    ids2 = ids2.toSet().toList();
    ids2.forEach((element) {
      sub2.add({element.toString(): []});
    });
    for (int g = 0; g < ids2.length; g++) {
      for (int f = 0; f < allmessages2.length; f++) {
        if (allmessages2[f]["user_id"].toString() == ids2[g]) {
          sub2[g][ids2[g]].add(allmessages2[f]);
        }
      }
    }
    for (int d = 0; d < sub2.length; d++) {
      var last_message = sub2[d][ids2[d]][sub2[d][ids2[d]].length-1];
      lastmessages2.add(last_message);
    }
  downchatuser2 = false;
  notifyListeners();
}
}