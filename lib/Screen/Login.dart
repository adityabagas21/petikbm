import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petik_bm/Components/CustomDialogBox.dart';
import 'package:petik_bm/Screen/HomeAdmin.dart';
import 'package:petik_bm/Screen/Homepage.dart';
import 'package:petik_bm/Service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNipValid;
  bool _isFieldPasswordValid;
  TextEditingController _controllerNip = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  String title;
  String body;

  String tokennotif;

  showNotification() async {
    if (!_initialized) {
      _firebaseMessaging.requestPermission();
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessagingToken : $token");

      tokennotif = token;
      _initialized = true;
    }
  }


  @override
  void initState() {
    super.initState();
    //getUser();
    this.showNotification();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Text(
                "PETIK BM",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Image.asset(
              'assets/images/logopu.jpg',
              height: 25,
              width: 25,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  child: Image.asset("assets/images/loginanimation.PNG"),
                ),
              ),
              Container(
                width: size.width * 0.8,
                child: Text(
                  "Pemenuhan Tingkat Layanan Jalan Sesuai Indikator Kinerja Jalan",
                  style: TextStyle(color: kTextColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: size.width * 0.6,
                child: TextFormField(
                  controller: _controllerNip,
                  decoration: InputDecoration(labelText: 'NIP'),
                  //validator: (value){};
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _isFieldNipValid) {
                      setState(() => _isFieldNipValid = isFieldValid);
                    }
                  },
                ),
              ),
              Container(
                width: size.width * 0.6,
                child: TextFormField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: _obscureText,
                  //validator: (value){};
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _isFieldPasswordValid) {
                      setState(() => _isFieldPasswordValid = isFieldValid);
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 200,
                  onPressed: () {
                    if (_isFieldNipValid == null ||
                        _isFieldPasswordValid == null ||
                        !_isFieldNipValid ||
                        !_isFieldPasswordValid) {
                      _scaffoldState.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Please fill all field"),
                        ),
                      );
                      return;
                    }
                    showLoaderDialog(context);
                    setState(() => _isLoading = true);
                    String nip1 = _controllerNip.text.toString();
                    String password1 = _controllerPassword.text.toString();
                    //String tanggal = formattedDate.toString();
                    _apiService.LoginUser(context, nip1, password1, tokennotif)
                        .then((isSuccess) {
                      setState(() {
                        _isLoading = false;

                      });
                      /*if (isSuccess != null) {

                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Berhasil Login"),
                        ));
                        *//*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeAdmin();
                            },
                          ),
                        );*//*
                      } else {
                        return CustomDialogBox(
                          title: "Login Salah",
                          descriptions: "Mohon Cek NIP dan Password anda",
                          text: "Kembali",
                          onPressed: (){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          },
                        );
                      }*/
                    });
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: FlatButton(
                  color: kTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  minWidth: 200,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Home Pengaduan",
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
    );
  }
}
