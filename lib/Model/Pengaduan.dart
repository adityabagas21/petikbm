/*
import 'dart:convert';


class Pengaduan {
  String nama_pengadu;
  String hp_pengadu;
  int pg_id_ruasjalan;
  String identifikasi_pengadu;
  String koordinat_lat_pengadu;
  String koordinat_lang_pengadu;
  String record_tgl_pengadu;

  Pengaduan(
      {this.nama_pengadu,
      this.hp_pengadu,
      this.pg_id_ruasjalan,
      this.identifikasi_pengadu,
      this.koordinat_lang_pengadu,
      this.koordinat_lat_pengadu,
      this.record_tgl_pengadu});

  factory Pengaduan.fromJson(Map<String, dynamic> map) {
    return Pengaduan(
        nama_pengadu: map["nama_pengadu"],
        hp_pengadu: map["hp_pengadu"],
        pg_id_ruasjalan: map["pg_id_ruasjalan"],
        identifikasi_pengadu: map["identifikasi_pengadu"],
        koordinat_lang_pengadu: map["koordinat_lang_pengadu"],
        koordinat_lat_pengadu: map["koordinat_lat_pengadu"],
        record_tgl_pengadu: map["record_tgl_pengadu"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "nama_pengadu": nama_pengadu,
      "hp_pengadu": hp_pengadu,
      "pg_id_ruasjalan": pg_id_ruasjalan,
      "identifikasi_pengadu": identifikasi_pengadu,
      "koordinat_lang_pengadu": koordinat_lang_pengadu,
      "koordinat_lat_pengadu": koordinat_lat_pengadu,
      "record_tgl_pengadu": record_tgl_pengadu
    };
  }

  @override
  String toString() {
    return 'Pengaduan{'
        'nama_pengadu: $nama_pengadu, '
        'hp_pengadu:$hp_pengadu, '
        'pg_id_ruasjalan:$pg_id_ruasjalan, '
        'identifikasi_pengadu:$identifikasi_pengadu,'
        'koordinat_lang_pengadu:$koordinat_lang_pengadu,'
        'koordinat_lat_pengadu:$koordinat_lat_pengadu,'
        'record_tgl_pengadu:$record_tgl_pengadu}';
  }
}

List<Pengaduan> pengaduanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Pengaduan>.from(data.map((item) => Pengaduan.fromJson(item)));
}

String pengaduanToJson (Pengaduan data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

*/
// To parse this JSON data, do
//
//     final headerResponse = headerResponseFromJson(jsonString);

import 'dart:convert';


HeaderResponse headerResponseFromJson(String str) =>
    HeaderResponse.fromJson(json.decode(str));

String headerResponseToJson(HeaderResponse data) => json.encode(data.toJson());

class HeaderResponse {
  HeaderResponse({
    this.msg,
    this.data,
  });

  Msg msg;
  List<Datum> data;

  factory HeaderResponse.fromJson(Map<String, dynamic> json) => HeaderResponse(
        msg: Msg.fromJson(json["msg"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.idPengaduan,
    this.namaPengadu,
    this.hpPengadu,
    this.pgIdRuasjalan,
    this.identifikasiPengadu,
    this.koordinatLatPengadu,
    this.koordinatLongPengadu,
    this.recordTglPengadu,
    this.noIdIk,
    this.koordinatLatTanggapan,
    this.koordinatLongTanggapan,
    this.identifikasiTanggapan,
    this.recordTglTanggapan,
    this.sanggahPpk,
    this.penyediaJasa,
    this.token,
    this.statusPg,
    this.ketepatanTanggap,
    this.timePg,
  });

  int idPengaduan;
  String namaPengadu;
  dynamic hpPengadu;
  dynamic pgIdRuasjalan;
  dynamic identifikasiPengadu;
  dynamic koordinatLatPengadu;
  dynamic koordinatLongPengadu;
  dynamic recordTglPengadu;
  dynamic noIdIk;
  dynamic koordinatLatTanggapan;
  dynamic koordinatLongTanggapan;
  dynamic identifikasiTanggapan;
  dynamic recordTglTanggapan;
  dynamic sanggahPpk;
  dynamic penyediaJasa;
  String token;
  int statusPg;
  dynamic ketepatanTanggap;
  DateTime timePg;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPengaduan: json["id_pengaduan"],
        namaPengadu: json["nama_pengadu"],
        hpPengadu: json["hp_pengadu"],
        pgIdRuasjalan: json["pg_id_ruasjalan"],
        identifikasiPengadu: json["identifikasi_pengadu"],
        koordinatLatPengadu: json["koordinat_lat_pengadu"],
        koordinatLongPengadu: json["koordinat_long_pengadu"],
        recordTglPengadu: json["record_tgl_pengadu"],
        noIdIk: json["no_id_ik"],
        koordinatLatTanggapan: json["koordinat_lat_tanggapan"],
        koordinatLongTanggapan: json["koordinat_long_tanggapan"],
        identifikasiTanggapan: json["identifikasi_tanggapan"],
        recordTglTanggapan: json["record_tgl_tanggapan"],
        sanggahPpk: json["sanggah_ppk"],
        penyediaJasa: json["penyedia_jasa"],
        token: json["token"],
        statusPg: json["status_pg"],
        ketepatanTanggap: json["ketepatan_tanggap"],
        //timePg: DateTime.parse(json["time_pg"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pengaduan": idPengaduan,
        "nama_pengadu": namaPengadu,
        "hp_pengadu": hpPengadu,
        "pg_id_ruasjalan": pgIdRuasjalan,
        "identifikasi_pengadu": identifikasiPengadu,
        "koordinat_lat_pengadu": koordinatLatPengadu,
        "koordinat_long_pengadu": koordinatLongPengadu,
        "record_tgl_pengadu": recordTglPengadu,
        "no_id_ik": noIdIk,
        "koordinat_lat_tanggapan": koordinatLatTanggapan,
        "koordinat_long_tanggapan": koordinatLongTanggapan,
        "identifikasi_tanggapan": identifikasiTanggapan,
        "record_tgl_tanggapan": recordTglTanggapan,
        "sanggah_ppk": sanggahPpk,
        "penyedia_jasa": penyediaJasa,
        "token": token,
        "status_pg": statusPg,
        "ketepatan_tanggap": ketepatanTanggap,
        //"time_pg": timePg.toIso8601String(),
      };


  @override
  String toString() {
    return 'Datum(id_pengaduan: $idPengaduan,nama_pengadu: $namaPengadu, hp_pengadu: $hpPengadu,pg_id_ruasjalan: $pgIdRuasjalan,identifikasi_pengadu: $identifikasiPengadu,koordinat_lat_pengadu: $koordinatLatPengadu,koordinat_long_pengadu: $koordinatLongPengadu,record_tgl_pengadu: $recordTglPengadu,no_id_ik: $noIdIk,koordinat_lat_tanggapan: $koordinatLatTanggapan,koordinat_long_tanggapan: $koordinatLongTanggapan,identifikasi_tanggapan: $identifikasiTanggapan,record_tgl_tanggapan: $recordTglTanggapan,sanggah_ppk: $sanggahPpk,penyedia_jasa: $penyediaJasa,token: $token,status_pg: $statusPg,ketepatan_tanggap: $ketepatanTanggap)';
  }
}

List<Datum> parse(String jsonData) {
  //List data = json.decode(jsonData.toString()) as List;
  /*final parsed = jsonDecode(jsonData).cast<Map<String, dynamic>>();
  return parsed.map<Datum>((json) => Datum.fromJson(json));*/
  final Map<String, dynamic> parsed = json.decode(jsonData);
  return List<Datum>.from(
      parsed["response"].map((x) => Datum.fromJson(x)));
}

String pengaduanToJson(Datum data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
  //json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class Msg {
  Msg({
    this.status,
    this.msg,
  });

  bool status;
  String msg;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
