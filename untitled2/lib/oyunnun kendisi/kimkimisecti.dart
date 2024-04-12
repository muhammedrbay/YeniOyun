import 'dart:math';
import 'package:flutter/material.dart';
import 'kimekaçoy.dart';

class KimKimisecti extends StatefulWidget {
  final bool BuKim;
  KimKimisecti({required this.BuKim,});
  @override
  _KimKimisectiState createState() => _KimKimisectiState();
}

class _KimKimisectiState extends State<KimKimisecti> {
  // buraya key olarak seçen kişi value olarak seçilen kişi gelecek
  late Map<String, String> map = {};
  late int KacinciEl;
  late int KacinciTur;
 late bool SonrakiSayfa= false; //sonraki sayfaya geçilsin mi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('kim kime oy verdi'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children : [
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
                  itemCount: map.length,
                  itemBuilder: (context, index) {
                    final key = map.keys.elementAt(index);
                    final value = map.values.elementAt(index);

                    return Card(
                      color : _randomColor(),
                      child: InkWell(
                        onTap: () {
                          onTapKey(key);
                        },
                        child: ListTile(
                          title: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  key,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_forward),
                                Text(value),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
        )
    );
  }

  void onTapKey(String key) {
    print('$key tıklandı');
    // buradaki selectedvalue değeri kimi seçtiğini gösteriyor
    String? selectedValue = map[key];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seçilen Değer'),
          content: Text(
              'Seçmek istediğiniz isim: $selectedValue. Emin misiniz?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hayır'),
            ),
            ElevatedButton(
              onPressed: () {
                //burada internete SelectedValue değerini vereceksin. bu deer kaçıncı key değerinin seçildiğini gösterir
                if (SonrakiSayfa) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => KimeKacOy(BuKim:widget.BuKim)),
                  );
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PopScope(
                        child: AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text("diğerleri için bekleniyor..."),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                };

              },
              child: Text('Evet'),
            ),
          ],
        );
      },
    );
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
