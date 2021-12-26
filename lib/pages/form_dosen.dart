import 'package:flutter/material.dart';
import 'package:sqlite_coba/model/model_dosen.dart';
import 'package:sqlite_coba/utils/db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:image_picker/image_picker.dart';

class FormDosen extends StatefulWidget {
  final ModelDosen dosen;

  FormDosen({this.dosen});

  @override
  _FormDosenState createState() => _FormDosenState();
}

class _FormDosenState extends State<FormDosen> {
  DatabaseHelper db = DatabaseHelper();
  File imagefile;
  DateTime _selectedDateTime = DateTime.now();

  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController ttlController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telpController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController fakultasController = TextEditingController();
  TextEditingController fotoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.dosen != null) {
      kodeController = TextEditingController(text: widget.dosen.kode);
      namaController = TextEditingController(text: widget.dosen.nama);
      alamatController = TextEditingController(text: widget.dosen.alamat);
      ttlController = TextEditingController(text: widget.dosen.ttl);
      emailController = TextEditingController(text: widget.dosen.email);
      telpController = TextEditingController(text: widget.dosen.mobileNumber);
      prodiController = TextEditingController(text: widget.dosen.prodi);
      fakultasController = TextEditingController(text: widget.dosen.fakultas);

      //fotoController = TextEditingController(text: widget.mahasiswa.foto);

    }
  }

  void captureImage1() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagefile = File(pickedFile.path);
      });
    }
  }

  var _datePicked = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1700),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _datePicked = value;
      });
    });
  }

  Future<void> createOrUpdateDosen() async {
    String imagepath;
    if (widget.dosen == null) {
      // create
      if (imagefile != null) {
        imagepath = imagefile.path;
      }
      await db.saveDosen(ModelDosen(
        kode: kodeController.text,
        nama: namaController.text,
        alamat: alamatController.text,
        ttl: _datePicked.toString(),
        mobileNumber: telpController.text,
        email: emailController.text,
        prodi: selectedValue.toString(),
        fakultas: selectedValue1.toString(),
        foto: imagepath,

        //Foto: _jurusanController.text,
      ));
      Navigator.pop(context, 'save');
    } else {
      // update
      if (imagefile != null) {
        imagepath = imagefile.path;
      }
      await db.updateDosen(
        ModelDosen.fromMap({
          'id': widget.dosen.id,
          'kode': kodeController.text,
          'Nama': namaController.text,
          'Alamat': alamatController.text,
          'TTL': _datePicked.toString(),
          'email': emailController.text,
          'mobileNumber': telpController.text,
          'Prodi': selectedValue.toString(),
          'Fakultas': selectedValue1.toString(),
          'Foto': imagepath,
        }),
      );
      Navigator.pop(context, 'update');
    }
  }

  List _prodi = [
    "Administrasi Publik",
    "Akuntansi",
    "Arsitektur",
    "Ilmu Hukum",
    "Ilmu Ekonomi",
    "Psikologi",
    "Teknik Elektro",
    "Teknik Industri",
    "Teknik Informatika",
    "Teknik Sipil",
  ];
  List _fakultas = [
    "Ekonomi",
    "Hukum",
    "Ilmu Sosial dan Politik",
    "Psikologi",
    "Sastra",
    "Teknik",
  ]; // Option 2 // Option 2
  String selectedValue = "Administrasi Publik";
  String selectedValue1 = "Ilmu Sosial dan Politik";

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Form Dosen'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: kodeController,
                      decoration: InputDecoration(
                        labelText: 'Kode Dosen',
                      ),
                    ),
                    TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                      ),
                    ),
                    TextFormField(
                      controller: alamatController,
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                          color: Colors.white,
                          child: Text('Pilih Tanggal Lahir')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black45)),
                      ),
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _datePicked == null
                                  ? 'Pilih tanggal'
                                  : '${DateFormat.yMd().format(_datePicked)}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            tooltip: 'Tekan untuk Pilih tanggal',
                            onPressed: () => _showDatePicker(),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: telpController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'No Telp.',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 40,
                      child: Container(
                          color: Colors.white, child: Text('Pilih Jurusan')),
                    ),
                    DropdownButton(
                      value: selectedValue,
                      onChanged: (String namaNew) {
                        setState(() {
                          selectedValue = namaNew;
                        });
                      },
                      items: _prodi.map<DropdownMenuItem<String>>((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 40,
                      child: Container(
                          color: Colors.white, child: Text('Pilih Fakultas')),
                    ),
                    DropdownButton(
                      value: selectedValue1,
                      onChanged: (String namaNew) {
                        setState(() {
                          selectedValue1 = namaNew;
                        });
                      },
                      items:
                          _fakultas.map<DropdownMenuItem<String>>((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 40,
                      child: Container(
                          color: Colors.white, child: Text('Upload Foto')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new RawMaterialButton(
                        onPressed: () {
                          captureImage1();
                        },
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: new Icon(
                            Icons.add_a_photo,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        shape: new CircleBorder(),
                        fillColor: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () {
                        createOrUpdateDosen();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: widget.dosen == null
                          ? Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )
                          : Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
