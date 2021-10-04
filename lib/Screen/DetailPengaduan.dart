import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petik_bm/Components/rounded_field_without_icon.dart';
import 'package:petik_bm/Screen/Laman_Pengaduan.dart';
import 'package:petik_bm/Screen/Pengaduan_Perkerasan.dart';
import 'package:petik_bm/Screen/TanggapanPPK.dart';
import 'package:petik_bm/Screen/TindakLanjutPPK.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

import '../constants.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DetailPengaduan extends StatefulWidget {
  const DetailPengaduan(
      {Key key,
      this.koordinat_lat,
      this.koordinat_long,
      this.namaruas,
      this.deskripsi,
      this.jeniskerusakan,
      this.tanggalpengaduan,
      this.gambar,
      this.token, this.name, this.id})
      : super(key: key);

  @override
  _DetailPengaduanState createState() => _DetailPengaduanState();

  final koordinat_lat;
  final koordinat_long;
  final namaruas;
  final deskripsi;
  final jeniskerusakan;
  final tanggalpengaduan;
  final gambar;
  final token;
  final name;
  final id;
}

class _DetailPengaduanState extends State<DetailPengaduan> {

  bool _isLoading = false;
  TextEditingController _controllerName = TextEditingController();
  bool _isFieldNameValid;

  Future<dynamic> ShareButton(BuildContext context, String namappk) async {
    final response = await http.put(Uri.parse(
      "https://api.petikbm-bpjnlampung.com/api/setpenyediajasa/" + widget.token),
      body: {"penyedia_jasa": namappk},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    var data = json.decode(response.body)['data'];

    if (data != null) {
      print(response.body);
      final RenderBox box = context.findRenderObject();
      Share.share(
          "\n Link Pengaduan: " +
              "\n https://petikbm-bpjnlampung.com/#/view/pengaduan/" +
              widget.token +
              "\n Mohon untuk di kerjakan segera",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Widget _gambar(double width) {
    return Container(
      height: 200,
      width: width,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kTextColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              "https://api.petikbm-bpjnlampung.com/fotojalan/" + widget.gambar),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: kTextColor,
                        size: 25,
                      ),
                      Text(
                        "Kembali",
                        style: TextStyle(color: kTextColor, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Detail Pelaporan",
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ))),
              Container(
                margin: EdgeInsets.only(
                    top: 30, left: kDefaultPadding, right: kDefaultPadding),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Foto",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        _gambar(size.width),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Koordinat",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.koordinat_lat + widget.koordinat_long,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Nama Ruas",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.namaruas,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Deskripsi",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.deskripsi,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Jenis Kerusakan",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.jeniskerusakan,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Tanggal Pengaduan",
                              style: TextStyle(color: kTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.tanggalpengaduan,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: FlatButton(
                        color: kTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        minWidth: 200,
                        height: 50,
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: size.height/6,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          RoundedFieldWithoutIcon(
                                            controller: _controllerName,
                                            hintText: "Masukkan Nama Penyedia Jasa",
                                            onChanged: (value) {
                                              bool isFieldValid =
                                                  value.trim().isNotEmpty;
                                              if (isFieldValid != _isFieldNameValid) {
                                                setState(() =>
                                                    _isFieldNameValid = isFieldValid);
                                              }
                                            },
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: FlatButton(
                                              color: kTextColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15)),
                                              padding: EdgeInsets.all(10),
                                              minWidth: 50,
                                              onPressed: () {
                                                if (_isFieldNameValid == null ||
                                                    !_isFieldNameValid) {
                                                  _scaffoldState.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Please fill field"),
                                                    ),
                                                  );
                                                  return;
                                                }
                                                setState(() => _isLoading = true);
                                                String name1 =
                                                    _controllerName.text.toString();
                                                ShareButton(context, name1)
                                                    .then((isSuccess) {
                                                  setState(() => _isLoading = false);
                                                  if (isSuccess != null) {
                                                    _scaffoldState.currentState
                                                        .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Berhasil Share data"),
                                                    ));
                                                  } else if (isSuccess == null) {
                                                    _scaffoldState.currentState
                                                        .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Gagal Share data"),
                                                    ));
                                                  }
                                                });
                                              },
                                              child: Text(
                                                "Go",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20),
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
                        },
                        child: Text(
                          "Share",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: FlatButton(
                        color: kTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        minWidth: 200,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TindakLanjutPPK(
                                  token: widget.token,
                                  namaruas: widget.namaruas,
                                  jeniskerusakan: widget.jeniskerusakan,
                                  name: widget.name,
                                  id: widget.id,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Tindak Lanjut",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      child: FlatButton(
                        color: kTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        minWidth: 200,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TanggapanPPK(
                                  token: widget.token,
                                  name: widget.name,
                                  id: widget.id,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Sanggahan",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
