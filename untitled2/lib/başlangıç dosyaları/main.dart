//burası da giriş sayfası. burada kayıt olma ve giriş yapma gibi şeyler yapılıyor.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'kullanıcıbilgileriaktarma.dart';
import 'anasayfa.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(apiKey: "AIzaSyCdDNu60bz9VGU5fO6vzIXBkJN7cghioog",
            authDomain: "bukim-1a232.firebaseapp.com",
            projectId: "bukim-1a232",
            storageBucket: "bukim-1a232.appspot.com",
            messagingSenderId: "797189190759",
            appId: "1:797189190759:web:8b04db83be54a28d2890c2",
            measurementId: "G-HFERYVSJZK"));}
  else{
    await Firebase.initializeApp();}
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giriş Sayfası',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}




class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Giriş Yap'),
            ),



          ],
        ),
      ),
    );
  }
}



class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı giriniz',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;

                // Kullanıcı bilgilerini kontrol et
                if (username.isNotEmpty) {
                  // Kullanıcı bilgilerini güncelle ve diğer sayfaya yönlendir
                  Provider.of<UserProvider>(context, listen: false)
                      .updateUser(username);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  // Eksik bilgi uyarısı verebilirsiniz
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lütfen kullanıcı adını girin.'),
                    ),
                  );
                }
              },
              child: Text('Giriş'),
            ),
          ],
        ),
      ),
    );
  }
}
