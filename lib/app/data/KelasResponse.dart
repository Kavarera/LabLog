import 'package:get/get.dart';

class KelasResponse {
  RxList<Kelas> kelas = <Kelas>[].obs;

  KelasResponse();

  KelasResponse.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    if (snapshot['kelas'] != null) {
      (snapshot['kelas'] as List<dynamic>).forEach((v) {
        kelas.add(Kelas.fromSnapshot(Map<dynamic, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kelas'] = kelas.map((v) => v.toJson()).toList();
    return data;
  }
}

class Kelas {
  Items? items;
  String? kode;
  int? logo;
  String? nama;

  Kelas({this.items, this.kode, this.logo, this.nama});

  Kelas.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    items = snapshot['items'] != null
        ? Items.fromSnapshot(Map<dynamic, dynamic>.from(snapshot['items']))
        : null;
    kode = snapshot['kode'];
    logo = snapshot['logo'];
    nama = snapshot['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.toJson();
    }
    data['kode'] = kode;
    data['logo'] = logo;
    data['nama'] = nama;
    return data;
  }
}

class Items {
  int? kuis;
  int? project;
  int? responsi;
  List<int>? tugas;

  Items({this.kuis, this.project, this.responsi, this.tugas});

  Items.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    kuis = snapshot['kuis'];
    project = snapshot['project'];
    responsi = snapshot['responsi'];
    tugas = (snapshot['tugas'] as List<dynamic>).map((e) => e as int).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kuis'] = kuis;
    data['project'] = project;
    data['responsi'] = responsi;
    data['tugas'] = tugas;
    return data;
  }
}
