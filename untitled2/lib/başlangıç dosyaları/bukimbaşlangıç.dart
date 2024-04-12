import 'package:flutter/material.dart';



import '../oyununoluşturulması/misafirodasıkurulumsayfası.dart';
import 'bukimnasiloynanir.dart';
import '../oyununoluşturulması/odaoluşturmasayfası.dart';

class bukimsayfasi extends StatelessWidget {
bool BuKim= true;
Color primaryColor = Colors.orange;
Color secondaryColor = Colors.yellow;
Color backgroundColor = Colors.white;
Color thirdColor = Colors.red;
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
                      builder: (context) => Misafirodakurulumsayfasi(BuKim: BuKim,)),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: thirdColor),
              child: Text('"bu kim" Odaya Katıl',
                style: TextStyle(color: backgroundColor),
              )
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OdaKurScreen(BuKim:BuKim)),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text('"bu kim" Oda Kur',
                style: TextStyle(color: backgroundColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NasilOynanirScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: secondaryColor ),
              child: Text(
                'Nasıl Oynanır',
                style: TextStyle(color: backgroundColor),
            ),)
          ],
        ),
      ),
    );
  }
}