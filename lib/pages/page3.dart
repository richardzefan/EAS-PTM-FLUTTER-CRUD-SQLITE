import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_coba/model/model_mahasiswa.dart';
import 'package:sqlite_coba/pages/detail_mahasiswa.dart';
import 'package:sqlite_coba/pages/form_mahasiswa.dart';
import 'package:sqlite_coba/pages/drawer.dart';
import 'package:sqlite_coba/utils/db_helper.dart';
import 'dart:io';
import 'dart:convert';

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<ModelMahasiswa> listMahasiswa = [];
  DatabaseHelper db = DatabaseHelper();
  Database database;

  Future<void> _getAllMahasiswa() async {
    var list = await db.getAllMahasiswa();
    setState(() {
      listMahasiswa.clear();
      list.forEach((element) {
        listMahasiswa.add(ModelMahasiswa.fromMap(element));
      });
      print(list);
    });
  }

  Future<void> _deleteMahasiswa(ModelMahasiswa mahasiswa, int position) async {
    await db.deleteMahasiswa(mahasiswa.id);

    setState(() {
      listMahasiswa.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormMahasiswa(),
      ),
    );

    if (result == 'save') {
      await _getAllMahasiswa();
    }
  }

  Future<void> _openFormEdit(ModelMahasiswa mahasiswa) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormMahasiswa(mahasiswa: mahasiswa),
      ),
    );

    if (result == 'update') {
      await _getAllMahasiswa();
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllMahasiswa();
  }

  //final PublishSubject subject = PublishSubject<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Laporan Mahasiswa'),
        elevation: 0,
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            ModelMahasiswa mahasiswa = listMahasiswa[index];

            return Column(
              children: [
                ListTile(
                  title: Text("${mahasiswa.nama}"),
                  subtitle: Text("${mahasiswa.nbi} | ${mahasiswa.prodi}"),
                  leading: mahasiswa.foto == null
                      ? getText(mahasiswa)
                      : getImage(mahasiswa),
                  trailing: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      // DETAIL PAGE
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            mahasiswa: mahasiswa,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(thickness: 2)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getText(ModelMahasiswa mahasiswa) {
    return CircleAvatar(
      child: Text(mahasiswa.nama[0]),
    );
  }

  Widget getImage(ModelMahasiswa mahasiswa) {
    return CircleAvatar(
      backgroundImage: FileImage(File(mahasiswa.foto)),
    );
  }
}
