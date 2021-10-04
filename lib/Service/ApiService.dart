import 'dart:convert';
import 'dart:io';

//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petik_bm/Components/CustomDialogBox.dart';
import 'package:petik_bm/Model/LoginResponse.dart';
import 'package:petik_bm/Model/Pengaduan.dart';
import 'package:petik_bm/Screen/Form_Pengaduan.dart';
import 'package:petik_bm/Screen/HomeAdmin.dart';
import 'package:petik_bm/Screen/Homepage.dart';
import 'package:petik_bm/Screen/Login.dart';
import 'package:petik_bm/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

//enum LoginStatus { notSignIn, signIn }

class ApiService {
  final String baseUrl = "https://api.petikbm-bpjnlampung.com";

  Future<List<Datum>> getPengaduan() async {
    final response = await http.get(Uri.parse("$baseUrl/api/showallpg"));
    if (response.statusCode == 200) {
      //print(response.body);
      List<Datum> list = parse(response.body);
      return list;
    } else {
      throw Exception("Error");
    }
  }

  Future<http.Response> postData(
      BuildContext context,
      String name,
      String hp,
      String koordinat,
      String koordinatlong,
      String deskripsi,
      String ruasjalan,
      String jeniskerusakan,
      File file) async {
    var responseJson;
    var uri = Uri.parse("$baseUrl/api/insertPG/");
    var request = http.MultipartRequest("POST", uri);

    request.fields["nama_pengadu"] = name;
    request.fields["hp_pengadu"] = hp;
    request.fields["identifikasi_pengadu"] = deskripsi;
    request.fields["koordinat_lat_pengadu"] = koordinat.toString();
    request.fields["koordinat_long_pengadu"] = koordinatlong.toString();
    request.fields["pg_id_ruasjalan"] = ruasjalan;
    request.fields["no_id_ik"] = jeniskerusakan;

    request.headers.addAll({"Content-Type": "application/json"});
    // request.fields.addAll(param);

    if (file != null) {
      //var img = await http.MultipartFile.fromPath(file.path);
      //request.files.add(img);
      var filePath = file.path;
      var image = await http.MultipartFile.fromPath("images[]",  filePath);
        request.files.add(image);
    }
    final response = await request.send().timeout(const Duration(seconds: 60));
    var res = await http.Response.fromStream(response);
    responseJson = res;
    var kode = json.decode(res.body)['dataPG']['token'];
    print(res.body);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: kode.toString(),
            descriptions:
                "Pengaduan Berhasil! Mohon Screenshot Kode Unik anda untuk pengecekan mengenai pengaduan",
            text: "Lanjut",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormPengaduan();
                  },
                ),
              );
              //Navigator.pop(context);
            },
          );
        });
  }

  // LoginStatus _loginStatus = LoginStatus.notSignIn;

  Future<dynamic> LoginUser(
      BuildContext context, String nip, String password, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/loginppk"),
      body: {"nip": nip, "password": password, "token_notif": token},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    var msgcek = json.decode(response.body)['msg']['status'];
    if (msgcek == false) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Gagal Login",
              descriptions: "Mohon Cek NIP dan Password Anda",
              text: "Kembali",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
                //Navigator.pop(context);
              },
            );
          });
    }
    var id = json.decode(response.body)['data']['nama_user'];
    var userid = json.decode(response.body)['data']['no_id_ppk'];
    var idprofile = json.decode(response.body)['data']['id_user'];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isUser', true);
    preferences.setString('namaUser', id);
    preferences.setString('idUser', userid);
    preferences.setString('idProfile', idprofile.toString());
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeAdmin(
            name: id,
            id: idprofile,
          );
        },
      ),
    );
  }
}
