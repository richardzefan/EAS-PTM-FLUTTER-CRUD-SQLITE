import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_coba/model/model_dosen.dart';
import 'package:sqlite_coba/pages/detail_dosen.dart';
import 'package:sqlite_coba/pages/form_dosen.dart';
import 'package:sqlite_coba/pages/drawer.dart';
import 'package:sqlite_coba/utils/db_helper.dart';
import 'dart:io';

class HomePage4 extends StatefulWidget {
  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  List<ModelDosen> listDosen = [];
  DatabaseHelper db = DatabaseHelper();

  Future<void> _getAllDosen() async {
    var list = await db.getAllDosen();
    setState(() {
      listDosen.clear();
      list.forEach((element) {
        listDosen.add(ModelDosen.fromMap(element));
      });
      print(list);
    });
  }

  Future<void> _deleteDosen(ModelDosen dosen, int position) async {
    await db.deleteDosen(dosen.id);

    setState(() {
      listDosen.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormDosen(),
      ),
    );

    if (result == 'save') {
      await _getAllDosen();
    }
  }

  Future<void> _openFormEdit(ModelDosen dosen) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormDosen(dosen: dosen),
      ),
    );

    if (result == 'update') {
      await _getAllDosen();
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllDosen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Laporan Dosen'),
        elevation: 0,
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listDosen.length,
          itemBuilder: (context, index) {
            ModelDosen dosen = listDosen[index];

            return Column(
              children: [
                ListTile(
                  title: Text("${dosen.nama}"),
                  subtitle: Text("${dosen.kode} | ${dosen.prodi}"),
                  leading:
                      dosen.foto == null ? getText(dosen) : getImage(dosen),
                  trailing: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      // DETAIL PAGE
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            dosen: dosen,
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

  Widget getText(ModelDosen dosen) {
    return CircleAvatar(
      child: Text(dosen.nama[0]),
    );
  }

  Widget getImage(ModelDosen dosen) {
    return CircleAvatar(
      backgroundImage: FileImage(File(dosen.foto)),
    );
  }
}
