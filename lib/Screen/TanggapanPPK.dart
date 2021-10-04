import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petik_bm/Components/CustomDialogBox.dart';
import 'package:petik_bm/Components/description_field.dart';

import '../constants.dart';
import 'DetailPengaduan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Pengaduan_Perkerasan.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TanggapanPPK extends StatefulWidget {
  const TanggapanPPK({Key key, this.token, this.name, this.id}) : super(key: key);

  @override
  _TanggapanPPKState createState() => _TanggapanPPKState();

  final token;
  final name;
  final id;
}

class _TanggapanPPKState extends State<TanggapanPPK> {

  bool _isLoading = false;
  bool _isSanggahValid;
  TextEditingController _controllerSanggah = TextEditingController();

  Future<dynamic> SanggahButton(BuildContext context, String sanggahan) async {
    final response = await http.put(Uri.parse(
      "https://api.petikbm-bpjnlampung.com/api/simpansanggahppk/" +
          widget.token),
      body: {"sanggah_ppk": sanggahan},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    var data = json.decode(response.body)['data'];

    if (data != null) {
      print(response.body);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sanggahan Anda",
              descriptions:
              "Sanggahan Berhasil Dikirim",
              text: "Lanjut",
              onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PengaduanPerkerasan(
                      name: widget.name,
                      id: widget.id,
                    );
                  },
                ),
              );},
            );
          });
    }
  }

  Future<dynamic> SanggahButton2(BuildContext context, String sanggahan) async {
    final response = await http.put(Uri.parse(
      "https://api.petikbm-bpjnlampung.com/api/simpansanggahdantangguhkan/" +
          widget.token),
      body: {"sanggah_ppk": sanggahan},
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    var data = json.decode(response.body)['data'];

    if (data != null) {
      print(response.body);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sanggahan Anda",
              descriptions:
              "Sanggahan Berhasil Dikirim",
              text: "Lanjut",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PengaduanPerkerasan(
                        name: widget.name,
                        id: widget.id,
                      );
                    },
                  ),
                );
              },
            );
          });
    }
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      "Sanggah",
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ))),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 50, top: 10),
                    child: Text(
                      "Sanggahan",
                      style: TextStyle(color: kTextColor, fontSize: 15),
                    ),
                  ),
                ),
                DescriptionField(
                  controller: _controllerSanggah,
                  hintText: "Tulis Sanggahan",
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _isSanggahValid) {
                      setState(() => _isSanggahValid = isFieldValid);
                    }
                  },
                ),
              ],
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
                  if (_isSanggahValid == null || !_isSanggahValid) {
                    _scaffoldState.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Please fill all field"),
                      ),
                    );
                    return;
                  }
                  showLoaderDialog(context);
                  setState(() => _isLoading = true);
                  String sanggah = _controllerSanggah.text.toString();
                  SanggahButton(context, sanggah).then((isSuccess) {
                    setState(() => _isLoading = false);
                    if (isSuccess != null) {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Berhasil Mengirim Sanggahan"),
                      ));
                    } else if (isSuccess == null) {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Gagal Mengirim Sanggahan"),
                      ));
                    }
                  });
                },
                child: Text(
                  "Sanggah dan Lanjutkan",
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
                  if (_isSanggahValid == null || !_isSanggahValid) {
                    _scaffoldState.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Please fill all field"),
                      ),
                    );
                    return;
                  }
                  showLoaderDialog(context);
                  setState(() => _isLoading = true);
                  String sanggah = _controllerSanggah.text.toString();
                  SanggahButton2(context, sanggah).then((isSuccess) {
                    setState(() => _isLoading = false);
                    if (isSuccess != null) {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Berhasil Mengirim Sanggahan"),
                      ));
                    } else if (isSuccess == null) {
                      _scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text("Gagal Mengirim Sanggahan"),
                      ));
                    }
                  });
                },
                child: Text(
                  "Sanggah dan Selesaikan",
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
    );
  }
}
