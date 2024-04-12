import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../başlangıç dosyaları/kullanıcıbilgileriaktarma.dart';
import 'package:provider/provider.dart';
import 'misafirodakurulum2.dart';


class Misafirodakurulumsayfasi extends StatefulWidget {
  final bool BuKim;
//bunu da internete vermen lazım. oyunun bukim mi yoksa puanlama mı olduğunu gösteriyor
  Misafirodakurulumsayfasi({required this.BuKim,});
  @override
  _MisafirodakurulumsayfasiState createState() => _MisafirodakurulumsayfasiState();
}

class _MisafirodakurulumsayfasiState extends State<Misafirodakurulumsayfasi> {
  late Future<List<String>> odaIsmiListFuture;
  late Future<List<int>> OyunSayisiListFuture;
  late Future<List<String>> sifreListFuture;
  late Future<List<int>> countListFuture;
  late String _username;
  late DatabaseReference _odaRef;
  late bool OdayaKatildi = false;
  TextEditingController sifreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _odaRef = FirebaseDatabase.instance.ref().child('odalar');
    _username = Provider
        .of<UserProvider>(context, listen: false)
        .username;
  }

    Future<void> _showInputDialog(BuildContext context, int index, String sifre,
        String odaIsmi, int Oyunsayisi, int count) async {
      if (sifre.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('sonraki sayfaya geç'),
              content: Text(
                  '$odaIsmi odasına katılmak istediğinize emin misiniz?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('İptal'),
                ),
                TextButton(
                  onPressed: () {
                    OdayaKatildi = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Oyunkurulumsayfasi(
                                odaIsmi: odaIsmi,
                                password: '',
                                // Boş şifre
                                BuKim: widget.BuKim,
                                Oyunsayisi: Oyunsayisi,
                                count: count
                            ),
                      ),
                    );
                  },
                  child: Text('Evet'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oyun Şifresi'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: sifreController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('İptal'),
                ),
                TextButton(
                  onPressed: () {
                    if (sifreController.text == sifre) {
                      OdayaKatildi = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Oyunkurulumsayfasi(
                                  odaIsmi: odaIsmi,
                                  password: sifreController.text,
                                  BuKim: widget.BuKim,
                                  Oyunsayisi: Oyunsayisi,
                                  count: count
                              ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Yanlış şifre!')));
                    }
                  },
                  child: Text('Giriş'),
                ),
              ],
            );
          },
        );
      }
    }


    @override
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.BuKim
              ? 'BuKim oyunu odaya katılma'
              : 'Puanlama oyunu odaya katılma',),
        ),
        body: FutureBuilder(
          future: Future.wait([
            odaIsmiListFuture,
            OyunSayisiListFuture,
            sifreListFuture,
            countListFuture,
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              List<String> odaIsmiList = snapshot.data![0];
              List<int> OyunsayisiList = snapshot.data![1];
              List<String> sifreList = snapshot.data![2];
              List<int> countList = snapshot.data![3];

              return ListView.builder(
                itemCount: odaIsmiList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        _showInputDialog(context, index, sifreList[index],
                            odaIsmiList[index], OyunsayisiList[index],
                            countList[index]);
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Oda İsmi: ${odaIsmiList[index]}'),
                              Text('oyun sayısı: ${OyunsayisiList[index]
                                  .toString()}'),
                              Text('kişi sayısı: ${countList[index]
                                  .toString()}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _privateRoomSearch(
                context,
                odaIsmiListFuture,
                sifreListFuture,
                widget.BuKim,
                OyunSayisiListFuture,
                countListFuture
            );
          },
          child: Icon(Icons.search),
        ),
      );
    }
  }


  void _privateRoomSearch(context,
      Future<List<String>> odaIsmiListFuture,
      Future<List<String>> sifreListFuture,
      bool BuKim,
      Future<List<int>>OyunSayisiListFuture,
      Future<List<int>>countListFuture) async {
    TextEditingController odaIsmiControllerController = TextEditingController();
    TextEditingController sifreController = TextEditingController();


    List<String> odaIsmiList = await odaIsmiListFuture;
    List<String> sifreList = await sifreListFuture;
    List<int> OyunSayisiList = await OyunSayisiListFuture;
    List<int> countList = await countListFuture;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Private Room Girişi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: odaIsmiControllerController,
                decoration: InputDecoration(
                  hintText: 'oda ismi',
                ),
              ),
              TextField(
                controller: sifreController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Şifre',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                String odaIsmi = odaIsmiControllerController.text;
                String password = sifreController.text;
                // Kullanıcı adı ve şifre kontrolü yapılır
                int index = odaIsmiList.indexWhere((item) => item == odaIsmi);
                if (index != -1 && sifreList[index] == password) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        Oyunkurulumsayfasi(odaIsmi: odaIsmiList[index],
                            password: sifreList[index],
                            BuKim: BuKim,
                            Oyunsayisi: OyunSayisiList[index],
                            count: countList[index])),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Yanlış kullanıcı adı veya şifre!')));
                }
              },
              child: Text('Giriş'),
            ),
          ],
        );
      },
    );
  }

