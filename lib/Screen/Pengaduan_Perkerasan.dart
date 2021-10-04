import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petik_bm/Screen/DetailPengaduan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'HomeAdmin.dart';

class PengaduanPerkerasan extends StatefulWidget {

  final name;
  final id;

  const PengaduanPerkerasan({Key key, this.name, this.id}) : super(key: key);
  @override
  _PengaduanPerkerasanState createState() => _PengaduanPerkerasanState();
}

_buildpengaduan(
    BuildContext context, String jenis, String tanggal, Function onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(3.0),
      color: kTextColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              jenis,
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              tanggal,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PengaduanPerkerasanState extends State<PengaduanPerkerasan> {
  String url = 'https://api.petikbm-bpjnlampung.com';

  List _posts = [];

  Future<List<Map<String, dynamic>>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('idUser');

    final res = await http.get(Uri.parse(url + "/api/showpgppk/" + id));

    if (res.statusCode != 200) {
      return null;
    } else {
      var data2 =
          List<Map<String, dynamic>>.from(json.decode(res.body)['data']);
      setState(() {
        _posts = data2;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeAdmin(
                        name: widget.name,
                        id: widget.id,
                      );
                    },
                  ),
                );
                //Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      color: kTextColor,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        title: Text(
          "Laman Pengaduan",
          style: TextStyle(
              color: kTextColor, fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, int index) {
          return _buildpengaduan(
              context,
              _posts[index]['keterangan_ik'] ?? 'default',
              _posts[index]['record_tgl_pengadu'] ?? 'default', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPengaduan(
                    deskripsi: _posts[index]['identifikasi_pengadu'],
                    jeniskerusakan: _posts[index]['keterangan_ik'],
                    koordinat_lat: _posts[index]['koordinat_lat_pengadu'],
                    koordinat_long: _posts[index]['koordinat_long_pengadu'],
                    namaruas: _posts[index]['nama_ruas'],
                    tanggalpengaduan: _posts[index]['record_tgl_pengadu'],
                    gambar: _posts[index]['file_foto_pg'],
                    token: _posts[index]['token'],
                    name: widget.name,
                    id: widget.id,
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }
}
