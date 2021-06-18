import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oturumislemleri/screens/anasayfa.dart';
import 'package:oturumislemleri/screens/kayitekrani.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  String email, parola;
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanici Giris Ekrani"),
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
                          : "Gecersiz Mail";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Adresinizi Giriniz",
                      hintText: "Lutfen Gecerli Bir Email Adresi Giriniz:",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (alinanParola) {
                      setState(() {
                        parola = alinanParola;
                      });
                    },
                    validator: (alinanParola) {
                      return alinanParola.length >= 6
                          ? null
                          : "Parolaniz en az 6 karakter olmalidir!";
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Parolanizi Giriniz",
                      hintText: "Lutfen parolanizi Giriniz:",
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
                      girisYap();
                    },
                    child: Text("GIRIS YAP"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: GoogleFonts.roboto(fontSize: 24)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KayitEkrani()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Kayit ol",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void girisYap() {
    if (_formAnahtari.currentState.validate()){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: parola).then((user) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => AnaSayfa()), (route) => false);
      }).catchError((hata){
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
