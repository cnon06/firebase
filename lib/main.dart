import 'dart:collection';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/kisiler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var refTest = FirebaseDatabase.instance.ref().child("kisiler_tablo");


  Future <void> kisiEkle() async
  {

    var bilgi = HashMap<String, dynamic> ();
    bilgi ["kisi_ad"] = "Sinan";
    bilgi ["kisi_yas"] = 40;
    refTest.push().set(bilgi);
    bilgi ["kisi_ad"] = "Suzan";
    bilgi ["kisi_yas"] = 36;
    refTest.push().set(bilgi);

  }





  Future <void> kisiGuncelle() async
  {

    var bilgi = HashMap<String, dynamic> ();
    bilgi ["kisi_ad"] = "Sinem";
    bilgi ["kisi_yas"] = 0;
    refTest.child("-MzLHZ3095fUMrxUj8-R").update(bilgi);

  }

  Future <void> kisiSil() async
  {
    refTest.child("-MzLGKW1k253YirWMRuJ").remove();
  }


  Future <void> kisiListele() async
  {
  await  refTest.onValue.listen((event){
    var gelenDegerler = event.snapshot.value as dynamic;

    if(gelenDegerler != null)
      {
        final _resultList = Map<String, dynamic>.from(gelenDegerler as LinkedHashMap);
        for (var key in _resultList.keys) {
          Map<String, dynamic> map2 = Map.from(_resultList[key]);
          print('${map2["kisi_ad"]}, ${map2["kisi_yas"]}');
        }
      }
  });
  }


  Future <void> kisiAra() async
  {
    var sorgu = refTest.orderByChild("kisi_ad").equalTo("Sinem");

    await  sorgu.onValue.listen((event){
      var gelenDegerler = event.snapshot.value as dynamic;




      if(gelenDegerler != null)
      {
        final _resultList = Map<String, dynamic>.from(gelenDegerler as LinkedHashMap);
        print('**************************');
        for (var key in _resultList.keys) {
          Map<String, dynamic> map2 = Map.from(_resultList[key]);
          print('${map2["kisi_ad"]}, ${map2["kisi_yas"]}');
        }
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //kisiEkle();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(onPressed: ()
            {
             kisiSil();
            }, child: Text("Kayıt Sil")),


            ElevatedButton(onPressed: ()
                {
                  kisiEkle();
                }, child: Text("Kayıt Ekle")),

            ElevatedButton(onPressed: ()
            {
              kisiGuncelle();
            }, child: Text("Kayıt Guncelle")),
            ElevatedButton(onPressed: ()
            {
              kisiListele();
            }, child: Text("Kişi Listele")),
            ElevatedButton(onPressed: ()
            {
              kisiAra();
            }, child: Text("Kayıt Ara")),

          ],
        ),
      ),

    );
  }
}
