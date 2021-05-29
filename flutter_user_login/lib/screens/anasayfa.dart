import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_user_login/screens/girisekrani.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnaSayfa"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((user) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => GirisEkrani(),), (
                          route) => false);
                });
              })
        ],
      ),
    );
  }
}