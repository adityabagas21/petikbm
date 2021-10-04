import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petik_bm/Components/CustomDialogBox.dart';
import 'package:petik_bm/Components/rounded_field_without_icon.dart';
import 'package:petik_bm/Screen/Form_Pengaduan.dart';
import 'package:petik_bm/Screen/Login.dart';
import 'package:petik_bm/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomeAdmin.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String messageTitle = "Empty";
  String notificationAlert = "alert";

  /* static String dataName = '';
  static String dataAge = '';*/

  Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'title.toString()', 'body.toString()', platform,
        payload: 'item x');
    return null;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void displayNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title.toString(), body.toString(), platformChannelSpecifics,
        payload: 'item x');
  }

  bool _isLoading = false;
  bool loginColor = false;
  bool _isFieldKodeValid;
  TextEditingController _controllerKode = TextEditingController();

  Widget _builddrawerku() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            selected: loginColor,
            onTap: () {
              setState(() async {
                loginColor = true;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String namaUser = prefs.getString('namaUser');
                String userId = prefs.getString('idProfile');
                print(namaUser);
                print(userId);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (c) => namaUser != null && userId != null
                            ? HomeAdmin(
                                name: namaUser,
                                id: userId,
                              )
                            : LoginPage()));
              });
            },
            title: Text("Login"),
            leading: Icon(Icons.login),
          ),
        ],
      ),
    );
  }

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
      useRootNavigator: false,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String url = 'https://api.petikbm-bpjnlampung.com';

  var data;

  CarouselController buttonCarouselController = CarouselController();

  Future<List<Map<String, dynamic>>> getData(
      String token, double height) async {
    final res = await http.get(Uri.parse(url + "/api/detailpgppk/" + token));

    if (res.statusCode != 200) {
      return null;
    } else {
      var data2 = json.decode(res.body)['data'];
      setState(() {
        if (data2 == null) {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Kode Salah",
                  descriptions: "Mohon Cek Kembali Kode Anda",
                  text: "Lanjut",
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
                );
              });
        } else if (data2['file_foto_tg'] == null) {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            isDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Homepage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Close"),
                              Icon(Icons.close),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Pengaduan dengan kode :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          _controllerKode.text.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        endIndent: 20,
                        indent: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Text("Pengaduan Masih Dalam Proses"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            isDismissible: false,
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Homepage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Close"),
                              Icon(Icons.close),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Pengaduan dengan kode :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          _controllerKode.text.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        endIndent: 20,
                        indent: 20,
                      ),
                      Column(
                        children: <Widget>[
                          CarouselSlider(
                            items: [
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Before",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://api.petikbm-bpjnlampung.com/fotojalan/" +
                                                data2['file_foto_pg']),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      data2['identifikasi_pengadu'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "After",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://api.petikbm-bpjnlampung.com/fotojalan/" +
                                                data2['file_foto_tg']),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      data2['identifikasi_tanggapan'] ??
                                          'Belum Ada Data',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              initialPage: 2,
                              enableInfiniteScroll: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getMessage();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings);

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message);
      // var data = json.decode(message);
      String title = message.notification.title;
      String body = message.notification.body;
      displayNotification(title, body);
      setState(() {
        messageTitle = message.notification.title;
        notificationAlert = "New Notification Alert";
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      setState(() {
        messageTitle = message.notification.title;
        notificationAlert = "Application opened from Notification";
      });
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _key,
          //backgroundColor: Colors.blue,
          drawer: _builddrawerku(),
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
                        fontWeight: FontWeight.w300),
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
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset("assets/images/PUPR.png",
                          height: size.height / 6),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset("assets/images/homeanimation.PNG"),
                    ),
                  ),
                  Text(
                    "Ada Jalan Yang Rusak ?",
                    style: TextStyle(color: kTextColor, fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: FlatButton(
                      color: kTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(10),
                      minWidth: 250,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FormPengaduan();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Adukan Sekarang !",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Text(
                              "Cek Proses Pengaduan!",
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "Masukkan kode unik untuk melihat pengaduan anda",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedFieldWithoutIcon(
                              hintText: "Masukkan Kode Unik",
                              controller: _controllerKode,
                              onChanged: (value) {
                                bool isFieldValid = value.trim().isNotEmpty;
                                if (isFieldValid != _isFieldKodeValid) {
                                  setState(
                                      () => _isFieldKodeValid = isFieldValid);
                                }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: FlatButton(
                                color: kTextColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.all(10),
                                minWidth: 50,
                                onPressed: () {
                                  if (_isFieldKodeValid == null ||
                                      !_isFieldKodeValid) {
                                    _key.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Please fill all field"),
                                      ),
                                    );
                                    return;
                                  }
                                  showLoaderDialog(context);
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  String kode = _controllerKode.text.toString();
                                  getData(kode, size.height / 0.5);
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
