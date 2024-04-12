import 'package:flutter/material.dart';

class NasilOynanirScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nasıl "Bu Kim" Oynanır'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"Bu Kim" Oyunu Nasıl Oynanır?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "'Bu Kim' oyunu 3-8 kişi arasında oynanabilecek bir kişilik tahmin oyunudur. Oyunun amacı oyunun içindeki ajanı bulmaktır.",
            ),
            SizedBox(height: 10.0),
            Text(
              "Oyunun Kuralları:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "- Oyunda bir ajan vardır. Bu ajan oyunun kendisi tarafından tamamen rastgele olarak belirlenir.",
            ),
        Text(
          "Ajan, ajan olarak isimlendirilirken, ajan hariç herkes masum diye isimlendirilir."),
            Text(
              "- Oyunun hostu oyunun kaç turdan oluşacağını belirler.",
            ),
            Text(
              "- Her tur 3 elden oluşur. Ajan bu 3 el sonucunda belirlenir.",
            ),
            Text(
              "- Her turda farklı bir ajan oyun tarafından seçilir.",
            ),
            Text(
              "- Oyunun toplam kaç turdan oluşacağı ise odanın sahibi tarafından seçilir.",
            ),
            Text(
              "- Eğer bu ellerde ajan yakalanırsa, ajan hariç herkes bir puan alır. Ajan ise eğer ilk elden sonra bulunduysa 3 puan kaybeder. İkinci elden sonra bulunduysa 2 puan kaybeder. Üçüncü elden sonra bulunduysa 1 puan kaybeder.",
            ),
            Text(
              "- Eğer ajan yakalanmazsa herkes bir puan kaybeder. Ajan ise 3 puan kazanır.",
            ),
            Text(
              "Oyunun İşleyişi:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "Oyunda ajan hariç herkese bir soru yönlendirilir. Ajana ise diğerlerine sorulan sorunun benzeri yönlendirilir. Ajan dahil herkes sorunun cevabı olarak birini işaretler. Oylamadan sonra kime farklı soru gittiği (ajanın kim olduğu) bulunmaya çalışılır. Ajana bulunma durumuna göre yukarıdaki gibi puanlama yapılır. En fazla puana sahip olan oyunu kazanır.",
            ),
          ],
        ),
      ),
    );
  }
}
