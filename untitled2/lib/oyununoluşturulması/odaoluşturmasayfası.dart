
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/ba%C5%9Flang%C4%B1%C3%A7%20dosyalar%C4%B1/kullan%C4%B1c%C4%B1bilgileriaktarma.dart';
import '../oyunnun kendisi/kişiseçmesayfasi.dart';

class OdaKurScreen extends StatefulWidget {
  final bool BuKim;
//bunu da internete vermen lazım. oyunun bukim mi yoksa puanlama mı olduğunu gösteriyor
  OdaKurScreen({required this.BuKim,});
  @override
  _OdaKurScreenState createState() => _OdaKurScreenState();
}

class _OdaKurScreenState extends State<OdaKurScreen> {
  final TextEditingController _odaIsmiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  int Tursayisi = 3;
  int KisiSayisi= 3;
  late String username;
  final DatabaseReference _odaRef = FirebaseDatabase.instance.ref().child('odalar');

  void initState() {
    username = Provider
        .of<UserProvider>(context, listen: false)
        .username;
  }
  void _navigateToSecondPage(BuildContext context) {
    if (_odaIsmiController.text.isNotEmpty) {
      _odaRef.push().set({
        'Tursayisi': Tursayisi,
        'odaIsmi': _odaIsmiController.text,
        'sifre': _sifreController.text,
        'KisiSayisi': KisiSayisi,
        'BuKim': widget.BuKim,
        'kullaniciadi':username
      }).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OdaKur2(
              Tursayisi: Tursayisi,
              odaIsmi: _odaIsmiController.text,
              sifre: _sifreController.text,
              KisiSayisi: KisiSayisi,
              BuKim: widget.BuKim,
            ),
          ),
        );
      }).catchError((error) {
        print('Firebase kaydetme hatası: $error');
        // Hata işleme buraya eklenebilir
      });
  } else {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  content: Text('Oda ismi boş olamaz.'),
  ),
  );
  }
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(

  appBar: AppBar(
  title: Text(
  widget.BuKim ? 'BuKim oyunu oda oluşturma' : 'Puanlama oyunu oda oluşturma',
  )
  ),
  body: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  SizedBox(height: 20),
  Padding(
  padding: const EdgeInsets.all(16.0),
  child: TextField(
  controller: _odaIsmiController,
  decoration: InputDecoration(labelText: 'Oda İsmi'),
  ),
  ),
  Padding(
  padding: const EdgeInsets.all(16.0),
  child: TextField(
  controller: _sifreController,
  obscureText: true,
  decoration: InputDecoration(
  labelText: 'Şifre (isteğe bağlı)',
  hintText: 'Eğer odanızın herkese açık olmasını istiyorsanız şifre girmeyiniz',
  ),
  ),
  ),


  Column(
  children: [
  Text('Tur sayisi'),
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: () {
  setState(() {
  Tursayisi--;
  });
  },
  ),
  Text(
  '$Tursayisi',
  style: TextStyle(fontSize: 24),
  ),
  IconButton(
  icon: Icon(Icons.arrow_forward),
  onPressed: () {
  setState(() {
  Tursayisi++;
  });;
  },
  ),
  ],
  ),


  Column(
  children: [
  Text('kaç kişi'),
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: () {
  setState(() {
  KisiSayisi--;
  });
  },
  ),
  Text(
  '$KisiSayisi',
  style: TextStyle(fontSize: 24),
  ),
  IconButton(
  icon: Icon(Icons.arrow_forward),
  onPressed: () {
  setState(() {
  KisiSayisi++;
  });;
  },
  ),
  ],
  ),
  ],
  ),
  ],
  ),
  ],
  ),
  ElevatedButton(
  onPressed: () => _navigateToSecondPage(context),
  child: Text('İleri'),
  ),
  ],
  ),
  ),
  );
  }
  }
class OdaKur2 extends StatefulWidget {
  final int Tursayisi;
  final String odaIsmi;
  final String sifre;
  final int KisiSayisi;
  final bool BuKim;


  OdaKur2({
    required this.Tursayisi,
    required this.odaIsmi,
    required this.sifre,
    required this.KisiSayisi,
    required this.BuKim,
  });

  @override
  _OdaKur2State createState() => _OdaKur2State();
}

class _OdaKur2State extends State<OdaKur2> {
  bool _dataLoaded = true; //false yapılacak Verilerin yüklenip yüklenmediğini kontrol etmek için bir değişken

  late List<String> _internettenGelenVeriler; // Internetten gelen verileri tutacak liste
  late String _username;
  late bool OyunBaslama= false;
  @override
  void initState() {
    super.initState();
    _username = Provider
        .of<UserProvider>(context, listen: false)
        .username;

  }

  // Fake data get fonksiyonu simüle edelim


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.BuKim ? 'BuKim oyunu oda oluşturma' : 'Puanlama oyunu oda oluşturma',),
      ),
      body: _dataLoaded
          ? ListView(
        children: [
          Text('Oda İsmi: ${widget.odaIsmi}'),
          SizedBox(height: 10),
          Text('Şifre: ${widget.sifre.isEmpty ? 'Herkese Açık' : widget
              .sifre}'),
          SizedBox(height: 10),
          Text('oynanacak el sayısı: ${widget.Tursayisi}'),
          SizedBox(height: 10),
          SizedBox(height: 20),
          ..._generateContainers(),
          // Dışarıya taşıdığımız için direkt bu şekilde çağırabiliriz
          SizedBox(height: 20),
          Text('Kullanıcı Adı: $_username'),
          // Değişkene atanan ismi kullan
        ],
      )
          : Center(
        child: CircularProgressIndicator(), // Veriler yüklenene kadar gösterilecek loading indicator
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Yeni bir bool değişken tanımla
              bool isAccepted = false;

              return AlertDialog(
                title: Text('Sonraki sayfaya geçmek isteediğinize emin misiniz?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      // Evet'e basıldığında isAccepted değerini true yap
                      isAccepted = true;
                      Navigator.of(context).pop();
                    },
                    child: Text('Evet'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Hayır'),
                  ),
                ],
              );
            },
          ).then((value) {
            // AlertDialog kapatıldıktan sonra burası çalışır
            if (value != null && value && OyunBaslama==true) {
              // Eğer isAccepted true ise, KisiSecmeListesi sayfasına geç
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KisiSecmeListesi(BuKim:widget.BuKim)),
              );
            } else {
              print('İptal edildi.');
            }
          }
          );
        },
        label: Text('İleri'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 6.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }



  List<Widget> _generateContainers() {
    List<Widget> containers = [];
    for (int i = 0; i < widget.KisiSayisi &&
        i < _internettenGelenVeriler.length; i++) {
      containers.add(
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          color: Colors.blue,
          child: Text(
            _internettenGelenVeriler[i],
            // Internetten gelen veriyi burada kullan
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