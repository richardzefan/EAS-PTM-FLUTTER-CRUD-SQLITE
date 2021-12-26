import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_coba/model/model_mahasiswa.dart';
import 'package:sqlite_coba/model/model_dosen.dart';
import 'package:sqlite_coba/pages/detail_mahasiswa.dart';
import 'package:sqlite_coba/pages/detail_dosen.dart';
import 'package:sqlite_coba/pages/form_mahasiswa.dart';
import 'package:sqlite_coba/pages/form_dosen.dart';
import 'package:sqlite_coba/pages/drawer.dart';
import 'package:sqlite_coba/utils/db_helper.dart';
import 'dart:io';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List<ModelMahasiswa> listMahasiswa = [];
  DatabaseHelper db = DatabaseHelper();

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

  Future<void> _openFormEdit(ModelMahasiswa mahasiswa, int position) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Form Mahasiswa'),
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
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _openFormEdit(mahasiswa, index);
                            }),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteMahasiswa(mahasiswa, index);
                            }),
                      ],
                    ),
                  ),
                ),
                Divider(thickness: 2)
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          _openFormCreate();
        },
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
