import 'package:flutter/material.dart';

class PuanlamaNasilOynanirScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nasıl "Puanlama" Oynanır'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"puanlama" Oyunu Nasıl Oynanır?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "'puanlama' oyunu bir tahmin oyunudur. Oyunun amacı oyunun içindeki ajanı bulmaktır.",
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
              "Ajan, ajan olarak isimlendirilirken, ajan hariç herkes masum diye isimlendirilir.",
            ),
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
              "Masumlara herhangi bir özellikte belirli bir sıradaki kişinin kim olduğu sorulur. Ancak 'ajan' için sorulan soruda, rakamın yanına ek rakam veya rakamlar eklenir; bu eklenen rakamlardan en az biri doğrudur. Örneğin, 'En kıskanç beşinci kişi kim?' sorusu masumlara yöneltilirken, ajan için 'En kıskanç dördüncü, beşinci veya altıncı kişi kim?' şeklinde sorulur. Ajan, stratejisine bağlı olarak en uygun cevabı verir. Herkes, sorunun cevabı olarak birini işaretler. Oylamadan sonra kime farklı soru gittiği (ajanın kim olduğu) bulunmaya çalışılır. Bu sürecin ardından puanlama yapılır ve en yüksek puana sahip olan oyunu kazanır..",
            ),
          ],
        ),
      ),
    );
  }
}
