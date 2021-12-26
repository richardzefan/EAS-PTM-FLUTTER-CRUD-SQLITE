class ModelMahasiswa {
  int id;
  String nbi;
  String nama;
  String alamat;
  String ttl;
  String email;
  String mobileNumber;
  String prodi;
  String fakultas;
  String ipk;
  String doswal;
  String foto;

  ModelMahasiswa({
    this.nbi,
    this.nama,
    this.alamat,
    this.ttl,
    this.email,
    this.mobileNumber,
    this.prodi,
    this.fakultas,
    this.ipk,
    this.doswal,
    this.foto,
  });

  ModelMahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nbi = map['nbi'];
    this.nama = map['Nama'];
    this.alamat = map['Alamat'];
    this.ttl = map['TTL'];
    this.email = map['email'];
    this.mobileNumber = map['mobileNumber'];
    this.prodi = map['Prodi'];
    this.fakultas = map['Fakultas'];
    this.ipk = map['IPK'];
    this.doswal = map['Doswal'];
    this.foto = map['Foto'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['nbi'] = nbi;
    map['Nama'] = nama;
    map['Alamat'] = alamat;
    map['TTL'] = ttl;
    map['email'] = email;
    map['mobileNumber'] = mobileNumber;
    map['Prodi'] = prodi;
    map['Fakultas'] = fakultas;
    map['IPK'] = ipk;
    map['Doswal'] = doswal;
    map['Foto'] = foto;

    return map;
  }
}
