class ModelDosen {
  int id;
  String kode;
  String nama;
  String alamat;
  String ttl;
  String email;
  String mobileNumber;
  String prodi;
  String fakultas;
  String foto;

  ModelDosen({
    this.kode,
    this.nama,
    this.alamat,
    this.ttl,
    this.email,
    this.mobileNumber,
    this.prodi,
    this.fakultas,
    this.foto,
  });

  ModelDosen.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.kode = map['kode'];
    this.nama = map['Nama'];
    this.alamat = map['Alamat'];
    this.ttl = map['TTL'];
    this.email = map['email'];
    this.mobileNumber = map['mobileNumber'];
    this.prodi = map['Prodi'];
    this.fakultas = map['Fakultas'];
    this.foto = map['Foto'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['kode'] = kode;
    map['Nama'] = nama;
    map['Alamat'] = alamat;
    map['TTL'] = ttl;
    map['email'] = email;
    map['mobileNumber'] = mobileNumber;
    map['Prodi'] = prodi;
    map['Fakultas'] = fakultas;
    map['Foto'] = foto;

    return map;
  }
}
