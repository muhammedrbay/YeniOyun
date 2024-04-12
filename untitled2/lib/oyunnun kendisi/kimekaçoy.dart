import 'dart:math';
import 'package:flutter/material.dart';
import 'kişiseçmesayfasi.dart';
import 'puanlama.dart';

class KimeKacOy extends StatefulWidget {
  final bool BuKim;
  KimeKacOy({required this.BuKim,});
  @override
  _KimeKacOyState createState() => _KimeKacOyState();
}

class _KimeKacOyState extends State<KimeKacOy> {
  late Map<String, int> oyDurumu = {
    'Aday 1': 100,
    'Aday 2': 150,
    'Aday 3': 80,
  };
  late int KacinciEl;
  late int KacinciTur;
  late bool ajanSecildi = false;
  late String ajanIsmi = 'Aday 2';
  late bool SonrakiSayfa;
  late bool Basildi= false;

  Widget buildCard(String key, int value) {
    return Card(
      color: _randomColor(),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_forward),
            Text(value.toString()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kime Kaç Oy?'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Kaçıncı El: ${KacinciEl.toString()}'),
                Text('Kaçıncı Tur:${KacinciTur.toString()}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: oyDurumu.length,
              itemBuilder: (context, index) {
                String key = oyDurumu.keys.elementAt(index);
                int value = oyDurumu.values.elementAt(index);
                return buildCard(key, value);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(
          ajanSecildi ? '$ajanIsmi ajan olarak seçildi' : 'Ajan seçilemedi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: ajanSecildi ? Colors.green : Colors.red,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Basildi=true;
          navigateToPage();
        },
        child: Text('ilerle'),
      ),
    );
  }

  void navigateToPage() {
    if (SonrakiSayfa) {
      if (ajanSecildi) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PuanlamaWidget(BuKim: widget.BuKim),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KisiSecmeListesi(BuKim: widget.BuKim),
          ),
        );
      }
    }
  }
  Color _randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
