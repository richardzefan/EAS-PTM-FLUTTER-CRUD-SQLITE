import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_coba/utils/db_helper.dart';
import 'package:sqlite_coba/pages/login_page.dart';
import 'package:sqlite_coba/pages/page1.dart';
import 'package:sqlite_coba/pages/page3.dart';
import 'package:sqlite_coba/pages/page2.dart';
import 'package:sqlite_coba/pages/page4.dart';
import 'dart:io';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  DatabaseHelper db = DatabaseHelper();

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void getDosen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage2(),
      ),
    );
  }

  void getMhs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage1(),
      ),
    );
  }

  void getLmhs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage3(),
      ),
    );
  }

  void getLdosen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage4(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(minRadius: 30),
                Text("Welcome :)"),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Form Mahasiswa'),
            onTap: getMhs,
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Form Dosen'),
            onTap: getDosen,
          ),
          ListTile(
            leading: Icon(Icons.topic),
            title: Text('Laporan Mahasiswa'),
            onTap: getLmhs,
          ),
          ListTile(
            leading: Icon(Icons.topic),
            title: Text('Laporan Dosen'),
            onTap: getLdosen,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LOGOUT'),
            onTap: logout,
          ),
          Divider()
        ],
      ),
    );
  }
}
