import 'package:flutter/material.dart';
import 'package:untitled2/ba%C5%9Flang%C4%B1%C3%A7%20dosyalar%C4%B1/anasayfa.dart';

class SonucSayfasi extends StatelessWidget {
  final Map<String, int> puantablosu;

  SonucSayfasi({required this.puantablosu});

  @override
  Widget build(BuildContext context) {
    // Haritayı değerine göre sırala
    var sortedKeys = puantablosu.keys.toList(growable: false)
      ..sort((k1, k2) => puantablosu[k2]!.compareTo(puantablosu[k1]!));

    // Sıralanmış haritadan yeni bir harita oluştur
    var sortedMap = Map.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => puantablosu[k]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuçlar'),
      ),
      body: ListView.builder(
        itemCount: sortedMap.length,
        itemBuilder: (context, index) {
          final key = sortedMap.keys.elementAt(index);
          final value = sortedMap.values.elementAt(index);
          return Card(
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
                    Text(value.toString()), // int'i stringe dönüştür
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Icon(Icons.home),
      ),
    );
  }
}