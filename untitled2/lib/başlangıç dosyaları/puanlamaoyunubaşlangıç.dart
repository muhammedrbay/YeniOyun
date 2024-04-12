import 'package:flutter/material.dart';
import '../oyununoluşturulması/misafirodasıkurulumsayfası.dart';
import '../oyununoluşturulması/odaoluşturmasayfası.dart';
import 'puanlamanasiloyanir.dart';

class PuanlamaOyunu extends StatelessWidget {
  bool BuKim = false;

  // Renkler
  Color button1Color = Colors.blue;
  Color button2Color = Colors.green;
  Color button3Color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Misafirodakurulumsayfasi(BuKim: BuKim),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: button1Color),
              child: Text('puanlama odaya katıl'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OdaKurScreen(BuKim: BuKim)),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: button2Color),
              child: Text('puanlama Oda Kur'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuanlamaNasilOynanirScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: button3Color),
              child: Text('Nasıl Oynanır'),
            ),
          ],
        ),
      ),
    );
  }
}
