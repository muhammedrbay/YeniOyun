// burası profil sayfasının kodları içinde internetten gelmesi gereken veriler var. bunları şimdilik sallama bir şeyler koydum. sen ayarlarsın
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kullanıcıbilgileriaktarma.dart';


class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserProvider'ı dinleyerek kullanıcı bilgilerini al
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kullanıcı Adı: ${userProvider.username}', // Kullanıcı adı
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),


          ],
        ),
      ),
    );
  }
}
