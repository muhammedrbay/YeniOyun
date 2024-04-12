import 'package:flutter/material.dart';

import '../oyunnun kendisi/kişiseçmesayfasi.dart';


class Oyunkurulumsayfasi extends StatefulWidget {
  final String odaIsmi;
  final String password;
  final bool BuKim;
  final int Oyunsayisi;
  final int count;

  const Oyunkurulumsayfasi({
    Key? key,
    required this.odaIsmi,
    required this.password,
    required this.BuKim,
    required this.Oyunsayisi,
    required this.count,
  }) : super(key: key);

  @override
  _OyunkurulumsayfasiState createState() => _OyunkurulumsayfasiState();
}

class _OyunkurulumsayfasiState extends State<Oyunkurulumsayfasi> {
  @override
  late List<String> _internettenGelenVeriler; // Internetten gelen kimlerin odada olduğunu tutacak liste
  late bool SonrakiSayfayaGecilsinmi; //herkes geçe tıkladı mı
  bool _dataLoaded = false; //dokunma


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('BuKim oyun kuruldu'),
      ),
      body: _dataLoaded
          ? Center(
            child: ListView(
                    children: [
            Text('Oda İsmi: ${widget.odaIsmi}'),
            SizedBox(height: 10),
            Text('Şifre: ${widget.password.isEmpty ? 'Herkese Açık' : widget.password}'),
            SizedBox(height: 10),
            Text('oynanacak el sayısı: ${widget.Oyunsayisi}'),
            SizedBox(height: 10),
            SizedBox(height: 20),
            ..._generateContainers(), // Dışarıya taşıdığımız için direkt bu şekilde çağırabiliriz
                    ],
                  ),
          )
          : Center(
        child: CircularProgressIndicator(), // Veriler yüklenene kadar gösterilecek loading indicator
      ),

    );
  }
  void _navigateToKisiSecmeListesi(BuildContext context, ) {
    // Eğer isAccepted true ise, KisiSecmeListesi sayfasına geç
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KisiSecmeListesi(BuKim:widget.BuKim)),
    );
  }
  List<Widget> _generateContainers() {
    List<Widget> containers = [];
    for (int i = 0; i < widget.count ; i++) {
      containers.add(
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          color: Colors.blue,
          child: Text(
            _internettenGelenVeriler[i], // Internetten gelen veriyi burada kullan
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),

      );
    }
    return containers;
  }
}


