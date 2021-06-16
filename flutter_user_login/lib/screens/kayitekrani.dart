import 'package:flutter_user_login/screens/anasayfa.dart';
import 'package:flutter_user_login/screens/girisekrani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  String email, parola;
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Kayıt Ekranı"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formAnahtari,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (alinanMail) {
                      setState(() {
                        email = alinanMail;
                      });
                    },
                    validator: (alinanMail) {
                      return alinanMail.contains("@")
                          ? null
                          : "Mail Adresiniz Geçersiz! Lütfen Geçerli Bir Mail Adresi Giriniz!";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Adresinizi Giriniz",
                      hintText: "Lütfen Geçerli Bir Email Adresi Giriniz:",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (alinanParola) {
                      parola = alinanParola;
                    },
                    validator: (alinanParola) {
                      return alinanParola.length >= 6
                          ? null
                          : "Parolanız En Az 6 Karakter Olmalıdır!";
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Parolanızı Giriniz",
                      hintText: "Lütfen Parolanızı Giriniz:",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text("Kayıt Ol"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: GoogleFonts.roboto(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Giriş Sayfasına Yönlendirir
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GirisEkrani()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Mevcut Bir Hesabım Bulunmakta",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Email ve Parolayı Alıp Firebasede Kullanıcı Ekleme İşlemi
  void kayitEkle() {
    if (_formAnahtari.currentState.validate()) {
      /*setState(() {
        Fluttertoast.showToast(msg: "Kaydınız Başarılı...");
      });*/
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: parola)
          .then((user) {
        //Başarılıysa Ana Sayfaya Yönlendir
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AnaSayfa()),
            (Route<dynamic> route) => false);
      }).catchError((hata) {
        //Başarısız İse Hata Mesajı Göster
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
