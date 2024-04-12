import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'kimkimisecti.dart';


class KisiSecmeListesi extends StatefulWidget {
  final bool BuKim;
//bunu da internete vermen lazım. oyunun bukim mi yoksa puanlama mı olduğunu gösteriyor
  KisiSecmeListesi({required this.BuKim,});

  @override
  _KisiSecmeListesiState createState() => _KisiSecmeListesiState();
}

class _KisiSecmeListesiState extends State<KisiSecmeListesi> {
  late List<String> kullanicilar = []; // burada oyuna giren herkesin ismi yazması lazım. internetten bu bilgiyi ver
  int secilenIndex = -1; // bu kaçıncı sıradaki kişinin seçildiğini gösteriyor. bunu internete vermen lazım
  bool SonrakiSayfa = false; // burada diğer kullanıcıların ileri tuşuna tıklayıp tıklamadığını gösteriyor. bunu da internetten alman lazım
  bool IleritiklandiMi= false; //bu sayfada ileri tıklanıp tıklanmadığını gösterir
  late String Soru;
  late int KacinciEl;
  late int KacinciTur;
  String? randomQuestion;

  @override
  void initState() {
    super.initState();
    fetchRandomQuestion();
  }

  void fetchRandomQuestion() async {
    String? question = await getRandomQuestion();
    setState(() {
      randomQuestion = question;
    });
  }


  @override
  Future<String?> getRandomQuestion() async {
    try {
      // Firestore bağlantısını al
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // "questions" koleksiyonundaki belgelerden bir tanesini rastgele seç
      QuerySnapshot querySnapshot = await firestore
          .collection("sorular")
          .orderBy("field to sort by", descending: false) // Sıralama için kullanılan alanı ve sıralama türünü belirtin
          .limit(1)
          .get();

      // Seçilen belgenin "text" alanını al ve geri döndür
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0]["text"];
      } else {
        return "Soru bulunamadı."; // Eğer koleksiyonda soru yoksa
      }
    } catch (error) {
      print("Soru alınırken bir hata oluştu: $error");
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Soruya en uygun gördüğünüzü seçin'),

        ),

        body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('El sayısı: ${KacinciEl.toString()}'),
                    Text('Tur sayısı: ${KacinciTur.toString()}'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, right: 16),
                    child: Text(randomQuestion ?? 'Soru yükleniyor...'),

                ),

              Expanded(child:
              ListView.builder(
                itemCount: kullanicilar.length,
                itemBuilder: (context, index) {
                  Color color = _randomColor();
                  return Padding(

                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Seçmek istediğinize emin misiniz?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      IleritiklandiMi= true;
                                      secilenIndex = index;
                                    });
                                    Navigator.of(context).pop();

                                    if (SonrakiSayfa) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => KimKimisecti(BuKim: widget.BuKim)),
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
                                    }
                                  },
                                  child: Text('Evet'),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Hayır'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        color: color
                        ,child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${kullanicilar[index]}'),
                          ],
                        ),
                      ),
                      ),
                    ),
                  );
                },
              )
              )
            ]
        )
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
