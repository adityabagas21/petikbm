import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petik_bm/Screen/HomeAdmin.dart';
import 'package:petik_bm/Screen/Pengaduan_Perkerasan.dart';

import '../constants.dart';

class LamanPengaduan extends StatefulWidget {
  @override
  _LamanPengaduanState createState() => _LamanPengaduanState();
}

class _LamanPengaduanState extends State<LamanPengaduan> {
  @override
  Widget build(BuildContext context) {
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
                      )
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Laman Pelaporan",
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ))),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PengaduanPerkerasan();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Perkerasan",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {},
                  child: Text(
                    "Bahu",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {},
                  child: Text(
                    "Drainase",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {},
                  child: Text(
                    "Perlengkapan Jalan",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {},
                  child: Text(
                    "Bangunan Pelengkap",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 250,
                  height: 80,
                  onPressed: () {},
                  child: Text(
                    "Pengendalian Tanaman",
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
      ),
    );
  }
}
