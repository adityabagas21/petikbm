import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petik_bm/Model/Pengaduan.dart';

class tes extends StatefulWidget {
  @override
  _tesState createState() => _tesState();
}

class _tesState extends State<tes> {
  String _mySelection;

  final String url = "https://api.petikbm-bpjnlampung.com/api/showallruasjalan";

  List list = List(); //edited line

  Future<List<Map<String, dynamic>>> getSWData() async {
    http.Response response = await http.get(Uri.parse("$url"));
    //print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      var data = List<Map<String, dynamic>>.from(
          json.decode(response.body)['data']);

      setState(() {
        list =data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
      body: new Center(
        child: new DropdownButton(
          items: list.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['nama_ruas']),
              value: item['id_ruas'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}
