import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petik_bm/Components/CustomDialogBox.dart';
import 'package:petik_bm/Components/description_field.dart';
import 'package:petik_bm/Components/rounded_field.dart';
import 'package:petik_bm/Components/rounded_field_pilihan.dart';
import 'package:petik_bm/Components/rounded_field_without_icon.dart';
import 'package:petik_bm/Components/text_field_container.dart';
import 'package:petik_bm/Screen/DetailPengaduan.dart';
import 'package:petik_bm/Screen/HomeAdmin.dart';
import 'package:petik_bm/Screen/Homepage.dart';
import 'package:petik_bm/Screen/Pengaduan_Perkerasan.dart';
import 'package:petik_bm/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Form_Pengaduan.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TindakLanjutPPK extends StatefulWidget {
  const TindakLanjutPPK({Key key, this.token, this.namaruas, this.jeniskerusakan, this.name, this.id}) : super(key: key);

  @override
  _TindakLanjutPPKState createState() => _TindakLanjutPPKState();

  final token;
  final namaruas;
  final jeniskerusakan;
  final name;
  final id;
}

class _TindakLanjutPPKState extends State<TindakLanjutPPK> {
  bool _isLoading = false;
  bool _isDeskripsiValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerHP = TextEditingController();
  TextEditingController _controllerKoordinat = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();

  Future<http.Response> postTanggapan(String koordinat, String koordinatlong,
      String deskripsi, File file) async {
    var responseJson;
    var uri = Uri.parse(
        "https://api.petikbm-bpjnlampung.com/api/simpantanggapanppk/" +
            widget.token);
    var request = http.MultipartRequest("PUT", uri);

    request.fields["identifikasi_tanggapan"] = deskripsi;
    request.fields["koordinat_lat_tanggapan"] = koordinat.toString();
    request.fields["koordinat_long_tanggapan"] = koordinatlong.toString();

    request.headers.addAll({"Content-Type": "application/json"});
    // request.fields.addAll(param);

    if (file != null) {
      //var img = await http.MultipartFile.fromPath(file.path);
      //request.files.add(img);
      var filePath = file.path;
      var image = await http.MultipartFile.fromPath("images", filePath);
      request.files.add(image);
    }
    final response = await request.send().timeout(const Duration(seconds: 60));
    var res = await http.Response.fromStream(response);
    responseJson = res;
    print(res.body);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Mohon Kembali ke Halaman Detail",
            descriptions:
                "Mengirim Tanggapan Terhadap Tindak Lanjut Pengaduan Sudah Berhasil",
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

  File _images;

  Future getImage(bool camera) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user get new photo from camera
    if (camera) {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
    // Otherwise open gallery to select photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }

    setState(() {
      if (pickedFile != null) {
        // _images.add(File(pickedFile.path));
        _images =
            File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  Geolocator geolocator = Geolocator();
  Position userLocation;

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
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
                        "Mohon Isi Form Tindak Lanjut",
                        style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ))),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Text(
                          "Upload Gambar",
                          style: TextStyle(color: kTextColor, fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              getImage(true);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  kTextColor,
                                  Color(0xFFD1C4E9)
                                ]),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Container(
                                width: size.width / 4,
                                height: size.height / 8,
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 50.0),
                                // min sizes for Material buttons
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Atau",
                            style: TextStyle(color: kTextColor, fontSize: 15),
                          ),
                          RaisedButton(
                            onPressed: () {
                              getImage(false);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  kTextColor,
                                  Color(0xFFD1C4E9)
                                ]),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Container(
                                width: size.width / 4,
                                height: size.height / 8,
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 50.0),
                                // min sizes for Material buttons
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.photo_library,
                                      size: 50.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              "Tekan Untuk Melihat Unggahan Terbaru",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            setState(() {
                              File gambar = _images;
                              if (gambar != null){
                                return Text(gambar.toString());
                              }
                            });
                          },
                          child: Container(
                            height: 200,
                            width: size.width * 0.8,
                            margin: EdgeInsets.only(bottom: 10, top: 5),
                            child: _images == null
                                ? Center(child: Text("Mohon Unggah Gambar"))
                                : Image.file(
                              _images,
                              fit: BoxFit.cover,
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
                            margin: EdgeInsets.only(left: 50, top: 10),
                            child: Text(
                              "Koordinat",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            color: kTextColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.all(10),
                            minWidth: size.width * 0.8,
                            onPressed: () {
                              _getLocation().then((value) {
                                setState(() {
                                  userLocation = value;
                                });
                              });
                            },
                            //color: Colors.blue,
                            child: Text(
                              "Tekan Untuk Mendapatkan Lokasi Anda",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        userLocation == null
                            ? CircularProgressIndicator()
                            : Text(userLocation.latitude.toString() +
                                " , " +
                                userLocation.longitude.toString()),
                        RoundedFieldWithoutIcon(
                          hintText: "Koordinat (isi jika tidak dapat lokasi)",
                          controller: _controllerKoordinat,
                          onChanged: (value) {},
                        ),
                      ],
                    ), //koordinat
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 50, top: 10),
                            child: Text(
                              "Nama Ruas",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width * 0.8,
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
                            margin: EdgeInsets.only(left: 50, top: 10),
                            child: Text(
                              "Deskripsi",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        DescriptionField(
                          controller: _controllerDeskripsi,
                          hintText: "Tulis Deskripsi Daerah",
                          onChanged: (value) {
                            bool isFieldValid = value.trim().isNotEmpty;
                            if (isFieldValid != _isDeskripsiValid) {
                              setState(() => _isDeskripsiValid = isFieldValid);
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 50, top: 10),
                            child: Text(
                              "Jenis Kerusakan",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width * 0.8,
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
                    ),//jenis kerusakan
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: FlatButton(
                        color: kTextColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        minWidth: 200,
                        onPressed: () {
                          if (_isDeskripsiValid == null || !_isDeskripsiValid) {
                            _scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Please fill all field"),
                              ),
                            );
                            return;
                          }
                          setState(() => _isLoading = true);
                          showLoaderDialog(context);
                          String deskripsi =
                              _controllerDeskripsi.text.toString();
                          String koordinat = userLocation.latitude.toString();
                          String koordinatlong =
                              userLocation.longitude.toString();
                          postTanggapan(
                                  koordinat, koordinatlong, deskripsi, _images)
                              .then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess != null) {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Berhasil Mengirim Tanggapan"),
                              ));
                            } else if (isSuccess == null) {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Gagal Mengirim Tanggapan"),
                              ));
                            }
                          });
                        },
                        child: Text(
                          "Kirim Tanggapan",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
