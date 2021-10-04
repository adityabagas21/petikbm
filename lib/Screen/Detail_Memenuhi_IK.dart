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

class DetailMemenuhiIK extends StatefulWidget {
  const DetailMemenuhiIK(
      {Key key,
        this.koordinat_lat,
        this.koordinat_long,
        this.namaruas,
        this.deskripsi,
        this.jeniskerusakan,
        this.tanggalpengaduan,
        this.gambar,
        this.token, this.koordinat_lat_tanggapan, this.koordinat_long_tanggapan, this.deskripsi_tanggapan, this.tanggaltanggapan, this.gambartanggapan})
      : super(key: key);

  @override
  _DetailMemenuhiIKState createState() => _DetailMemenuhiIKState();

  final koordinat_lat;
  final koordinat_long;
  final namaruas;
  final deskripsi;
  final jeniskerusakan;
  final tanggalpengaduan;
  final gambar;
  final token;
  final koordinat_lat_tanggapan;
  final koordinat_long_tanggapan;
  final deskripsi_tanggapan;
  final tanggaltanggapan;
  final gambartanggapan;
}

class _DetailMemenuhiIKState extends State<DetailMemenuhiIK> {


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

  Widget _gambartanggapan(double width) {
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
              "https://api.petikbm-bpjnlampung.com/fotojalan/" + widget.gambartanggapan),
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
              Divider(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Detail Pengaduan",
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
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
                  ],
                ),
              ),
              Divider(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Detail Tanggapan",
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
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
                        _gambartanggapan(size.width),
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
                              widget.koordinat_lat_tanggapan + widget.koordinat_long_tanggapan,
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
                              widget.deskripsi_tanggapan,
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
                              widget.tanggaltanggapan,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
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
