import 'package:flutter/material.dart';

import 'SonucSayfasi.dart';
import 'kişiseçmesayfasi.dart';

class PuanlamaWidget extends StatefulWidget {
  final bool BuKim;
  PuanlamaWidget({required this.BuKim,});
  @override
  _PuanlamaWidgetState createState() => _PuanlamaWidgetState();
}

class _PuanlamaWidgetState extends State<PuanlamaWidget> {
  late Map<String, int> puantablosu = {
    'Öğe 1': 5,
    'Öğe 2': 4,
    'Öğe 3': 3,
    'Öğe 4': 2,
    'Öğe 5': 1,
  };
  late int KacinciTur;

//bu ikisi bir sonraki sayfaya geçiş için burada kontrol edeceksin ona göre sonraki sayfaya geçicen
  //internetegidende bu sayfada devama tıklanmış mı onu kontrol edeceksin
  late bool SonrakiSayfa = false;
  // internetten gelende diğerleri tıklamış m onu kontrol edeceksin
  late bool tiklandimi = false;
  // oyundaki bütün eller bitti mi onu soracaksın
  late bool OyunBittimi;

  void sonrakiSayfayaAktar() {
    if (OyunBittimi) {
      // Oyun bittiği durumda sonuç sayfasına yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SonucSayfasi(puantablosu : puantablosu)),
      );
    } else {
      // Oyun bitmediği durumda kişi seçme listesine yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => KisiSecmeListesi(BuKim:widget.BuKim)),
      );
    }
  }


  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puan Tablosu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: puantablosu.length,
              itemBuilder: (context, index) {
                String key = puantablosu.keys.elementAt(index);
                int value = puantablosu.values.elementAt(index);
                return Card(
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
              },
            ),
          ),
          Text('Kaçıncı Tur:${KacinciTur.toString()}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tiklandimi = true;
              });
              if (!SonrakiSayfa) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Bekleniyor'),
                    content: Text('Diğer oyuncular için bekleniyor...'),
                  ),
                );
              }
              if (SonrakiSayfa) {
                sonrakiSayfayaAktar();
              }
            },
            child: Text('İleri'),
          ),
        ],
      ),
    );
  }
}
