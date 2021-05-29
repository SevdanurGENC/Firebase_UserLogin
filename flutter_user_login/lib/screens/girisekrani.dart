import 'package:flutter_user_login/screens/anasayfa.dart';
import 'package:flutter_user_login/screens/kayitekrani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  //---------- Giriş Parametreleri
  String email, parola;

  //Doğrulama Anahtarı
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: Form(
        key: _formAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (alinanMail) {
                    email = alinanMail;
                  },
                  validator: (alinanMail) {
                    return alinanMail.contains("@") ? null : "Geçersiz Email!";
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (alinanParola) {
                    parola = alinanParola;
                  },
                  validator: (alinanParola) {
                    return alinanParola.length >= 6
                        ? null
                        : "6 Karakterden Az Parola Giremezsiniz!";
                  },
                  decoration: InputDecoration(
                    labelText: "Parola",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8.0),
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      girisYap();
                    },
                    child: Text("Giriş Yap"),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => KayitEkrani()));
                },
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Girilen Email ve Parola Bilgisine Göre Doğrulama Yapılacak
  void girisYap() {
    if (_formAnahtari.currentState.validate()) {
      //Giriş Yap
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: parola)
          .then((user) {
        //Doğrulama Başarılı İse Anasayfaya Git
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => AnaSayfa()), (route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}