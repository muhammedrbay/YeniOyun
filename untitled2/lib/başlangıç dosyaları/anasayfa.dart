import 'package:flutter/material.dart';
import 'package:untitled2/ba%C5%9Flang%C4%B1%C3%A7%20dosyalar%C4%B1/profil.dart';

import 'ayarlar.dart';
import 'bukimbaşlangıç.dart';
import 'puanlamaoyunubaşlangıç.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PuanlamaOyunu()),
                    );
                  },
                  child: Text('puanlama oyna'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => bukimsayfasi()),
                    );
                  },
                  child: Text('bu kim oyna'),
                ),
              ],
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilScreen(),
                    )
                  );
                },
                child: Text('Profilim'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AyarlarScreen()),
                  );
                },
                child: Text('Ayarlar'),
              ),
            ],
          ),
        ],
      ),
      );

  }
}





