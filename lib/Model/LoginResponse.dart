// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.msg,
    this.data,
  });

  Msg msg;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    msg: Msg.fromJson(json["msg"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.idUser,
    this.namaUser,
    this.nip,
    this.telpUser,
    this.jabatan,
    this.level,
    this.password,
    this.noIdSatkerUser,
    this.noIdPpk,
    this.fotoUser,
    this.statusAktif,
    this.timeUser,
  });

  int idUser;
  String namaUser;
  String nip;
  String telpUser;
  String jabatan;
  String level;
  String password;
  String noIdSatkerUser;
  dynamic noIdPpk;
  String fotoUser;
  String statusAktif;
  DateTime timeUser;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUser: json["id_user"],
    namaUser: json["nama_user"],
    nip: json["nip"],
    telpUser: json["telp_user"],
    jabatan: json["jabatan"],
    level: json["level"],
    password: json["password"],
    noIdSatkerUser: json["no_id_satker_user"],
    noIdPpk: json["no_id_ppk"],
    fotoUser: json["foto_user"],
    statusAktif: json["status_aktif"],
    timeUser: DateTime.parse(json["time_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nama_user": namaUser,
    "nip": nip,
    "telp_user": telpUser,
    "jabatan": jabatan,
    "level": level,
    "password": password,
    "no_id_satker_user": noIdSatkerUser,
    "no_id_ppk": noIdPpk,
    "foto_user": fotoUser,
    "status_aktif": statusAktif,
    "time_user": timeUser.toIso8601String(),
  };
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
