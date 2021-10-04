import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:intl/intl.dart';
import 'package:petik_bm/Screen/Form_Pengaduan.dart';
import 'package:petik_bm/Screen/Laman_Pengaduan.dart';
import 'package:petik_bm/Screen/Login.dart';
import 'package:petik_bm/Screen/Memenuhi_IK.dart';
import 'package:petik_bm/Screen/PengaduanDitangguhkan.dart';
import 'package:petik_bm/Screen/Pengaduan_Perkerasan.dart';
import 'package:petik_bm/Screen/Profile_User.dart';
import 'package:petik_bm/Service/ApiService.dart';
import 'package:petik_bm/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'Tidak_Memenuhi_IK.dart';

class HomeAdmin extends StatefulWidget {
  final name;
  final id;

  const HomeAdmin({Key key, this.name, this.id}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  bool loginColor = false;

  Widget _namaakun() {
    return Text("Halo, " + widget.name);
  }

  var profile;
  Future<List<Map<String, dynamic>>> getProfile() async {
    var codec = latin1.fuse(base64);
    var idid = codec.encode(widget.id.toString());
    final response = await http
        .get(Uri.parse(url + "/api/detailusers/" + idid));
    //print(idid);
    //print(response.body);
    if (response.statusCode != 200) {
      print("Gagal");
    } else {
      var data3 = json.decode(response.body)['data'];
      print(data3);
      setState(() {
        profile = data3;
      });
    }
  }

  Widget _builddrawerku() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileUser(
                      nama: profile['nama_user'],
                      email: profile['email_user'],
                      nip: profile['nip'],
                      foto: profile['foto_user'],
                      password: profile['password'],
                    );
                  },
                ),
              );
            },
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logopu.jpg"),
            ),
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            accountEmail: Text(
             profile['nama_user'],
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            selected: loginColor,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              //prefs.remove('isUser');
              prefs.remove('namaUser');
              prefs.remove('idProfile');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
              setState(() {
                loginColor = true;
              });
            },
            title: Text("Logout"),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

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



  void initState() {
    super.initState();
    this.getData();
    this.getProfile();

  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _key,
          //backgroundColor: Colors.blue,
          drawer: _builddrawerku(),
          appBar: AppBar(
            title: Text(
              "PETIK BM",
              style: TextStyle(
                  color: kTextColor, fontSize: 30, fontWeight: FontWeight.w300),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: kTextColor,
              ),
              onPressed: () {
                _key.currentState.openDrawer();
              },
            ),
          ),
          body: Container(
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Image.asset("assets/images/Capture.PNG"),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(10),
                      minWidth: 200,
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: _namaakun()),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: Colors.blueGrey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: FlatButton(
                          color: kTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          minWidth: 250,
                          height: 50,
                          onPressed: () {
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
                          child: Text(
                            "Pelaporan",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      new Positioned(
                        right: 0,
                        top: 15,
                        child: new Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            /* border: Border.all(color: kTextColor, width: 2)*/
                          ),
                          constraints: BoxConstraints(
                            minWidth: 30,
                            minHeight: 30,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              _posts.length.toString(),
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: FlatButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      minWidth: 250,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MemenuhiIK();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Memenuhi IK",
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
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      minWidth: 250,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TidakMemenuhiIK();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Tidak Memenuhi IK",
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
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      minWidth: 250,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PengaduanDitangguhkan();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Pengaduan Ditangguhkan",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }
}
