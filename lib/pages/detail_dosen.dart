import 'package:flutter/material.dart';
import 'package:sqlite_coba/model/model_dosen.dart';
import 'package:sqlite_coba/pages/page4.dart';
import 'dart:io';

class DetailPage extends StatelessWidget {
  final ModelDosen dosen;
  DetailPage({this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Page'),
      ),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              backgroundImage: FileImage(File(dosen.foto)),
              //backgroundImage: mages("${mahasiswa.foto}"),
            )),
            Text(
              "${dosen.nama}",
              style: TextStyle(
                  fontSize: 28, fontFamily: 'PR', color: Colors.black),
            ),
            Text(
              "${dosen.kode}",
              style: TextStyle(
                fontFamily: 'SSPL',
                color: Colors.black,
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 35,
              width: 250,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  Text(
                    "${dosen.alamat}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  Text(
                    "${dosen.ttl}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  Text(
                    "${dosen.email}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  Text(
                    " ${dosen.mobileNumber}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.book,
                    color: Colors.black,
                  ),
                  Text(
                    "${dosen.prodi}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.book_sharp,
                    color: Colors.black,
                  ),
                  Text(
                    "${dosen.fakultas}",
                    style: TextStyle(
                        fontFamily: 'SSPL',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
