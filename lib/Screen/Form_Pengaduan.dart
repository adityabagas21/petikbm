import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:petik_bm/Components/description_field.dart';
import 'package:petik_bm/Components/rounded_field_without_icon.dart';
import 'package:petik_bm/Screen/Homepage.dart';
import 'package:petik_bm/Service/ApiService.dart';
import 'package:petik_bm/constants.dart';
import 'package:http/http.dart' as http;

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormPengaduan extends StatefulWidget {
  @override
  _FormPengaduanState createState() => _FormPengaduanState();
}

class Ruas {
  String name;
  String id;

  Ruas({this.name, this.id});

  @override
  String toString() {
    return '${name} ${id}';
  }
}

class _FormPengaduanState extends State<FormPengaduan> {
  String _mySelection;

  final String url = "https://api.petikbm-bpjnlampung.com/api/showallruasjalan";

  List list = []; //edited line

  Future<List<Map<String, dynamic>>> getSWData() async {
    http.Response response = await http.get(Uri.parse("$url"));
    //print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      var data =
          List<Map<String, dynamic>>.from(json.decode(response.body)['data']);

      setState(() {
        list = data;
      });
    }
  }

  String _mySelection2;
  final String url2 =
      "https://api.petikbm-bpjnlampung.com/api/showAllindikator";
  List list2 = [];

  Future<List<Map<String, dynamic>>> getSWData2() async {
    http.Response res = await http.get(Uri.parse("$url2"));
    print(res.body);
    if (res.statusCode != 200) {
      return null;
    } else {
      var data2 =
          List<Map<String, dynamic>>.from(json.decode(res.body)['data']);

      setState(() {
        list2 = data2;
      });
    }
  }

  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldHPValid;
  bool _isKoordinatValid;
  bool _isDeskripsiValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerHP = TextEditingController();
  TextEditingController _controllerKoordinat = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();


  //List<File> _images = [];
  File _image;
  File _images2;



  Future getImage(bool camera) async {
    ImagePicker picker = ImagePicker();
    XFile pickedFile;
    List<XFile> _imageFileList = <XFile>[];
    // Let user select photo from gallery
    if (camera) {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }
    // Otherwise open camera to get new photo
    else {
      _imageFileList = await picker.pickMultiImage();
    }

    setState(() {
      if (pickedFile != null) {
         _image = File(pickedFile.path);
         print(pickedFile.path);
         print("Foto Berhasil"); // Use if you only need a single picture
         return _scaffoldState.currentState.showSnackBar(
           SnackBar(
             content: Text("Gambar Dipilih"),
           ),
         );
      }
      if(_imageFileList != null){

         for(var i = 0; i < _imageFileList.length; i++){
           var element = _imageFileList[i];
           var tes = element.path;
           //File _images2;
           _images2 = File(tes);
          // _images = [_images2];
           print(tes);

         }
         //_images = File(pickedFile.path); //
         print("Multi Foto Berhasil"); // Use if you only need a single picture
         return _scaffoldState.currentState.showSnackBar(
           SnackBar(
             content: Text("Gambar Dipilih"),
           ),
         );
      }else{
        print("Tidak Ada Gambar");
      }
    });
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
            image:
                FileImage(_image) ?? Image.asset("assets/images/logopu.jpg")),
      ),
    );
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
    this.getSWData();
    this.getSWData2();
    //this.getCode();
  }

  //String dropdownValue = "Pematang Panggang - Sp. Pematang";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //key: _scaffoldState,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ),
                    );
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
                          "Mohon Isi Form Pengaduan",
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ))),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            "Nama Pengadu",
                            style: TextStyle(color: kTextColor, fontSize: 15),
                          ),
                        ),
                      ),
                      RoundedFieldWithoutIcon(
                        controller: _controllerName,
                        hintText: "Nama Pengadu",
                        onChanged: (value) {
                          bool isFieldValid = value.trim().isNotEmpty;
                          if (isFieldValid != _isFieldNameValid) {
                            setState(() => _isFieldNameValid = isFieldValid);
                          }
                        },
                      ),
                    ],
                  ),
                ), //nama
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 50, top: 10),
                        child: Text(
                          "Nomor Telepon",
                          style: TextStyle(color: kTextColor, fontSize: 15),
                        ),
                      ),
                    ),
                    RoundedFieldWithoutIcon(
                      hintText: "Nomor Handphone",
                      controller: _controllerHP,
                      onChanged: (value) {
                        bool isFieldValid = value.trim().isNotEmpty;
                        if (isFieldValid != _isFieldHPValid) {
                          setState(() => _isFieldHPValid = isFieldValid);
                        }
                      },
                    ),
                  ],
                ), //nomor telepon
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
                      Column(
                        children: <Widget>[
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        kTextColor,
                                        Color(0xFFD1C4E9)
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Container(
                                      width: size.width / 4,
                                      height: size.height / 8,
                                      constraints: const BoxConstraints(
                                          minWidth: 88.0, minHeight: 50.0),
                                      // min sizes for Material buttons
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.camera_alt,
                                            size: 50.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Camera",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Atau",
                                  style: TextStyle(
                                      color: kTextColor, fontSize: 15),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    getImage(false);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        kTextColor,
                                        Color(0xFFD1C4E9)
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Container(
                                      width: size.width / 4,
                                      height: size.height / 8,
                                      constraints: const BoxConstraints(
                                          minWidth: 88.0, minHeight: 50.0),
                                      // min sizes for Material buttons
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.photo_library,
                                            size: 50.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Gallery",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //upload gambar
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                "Tekan Untuk Melihat Unggahan Terbaru",
                                style:
                                    TextStyle(color: kTextColor, fontSize: 15),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                File gambar = _images2;
                                if (gambar != null) {
                                  return Text(_images2.toString());
                                }
                              });
                            },
                            child: Container(
                              height: 200,
                              width: size.width * 0.8,
                              margin: EdgeInsets.only(bottom: 10, top: 5),
                              child: _images2 == null
                                  ? Center(child: Text("Mohon Unggah Gambar"))
                                  : Image.file(
                                      _images2,
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
                                style:
                                    TextStyle(color: kTextColor, fontSize: 15),
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
                      Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 50, top: 10),
                            child: Text(
                              "Ruas Jalan",
                              style: TextStyle(color: kTextColor, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                            width: size.width * 0.8,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: kTextColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownSearch(
                              //style: const TextStyle(color: Colors.black),
                              showSearchBox: true,
                              items: list.map((item) {
                                return (item['id_ruas'].toString() +
                                    '. ' +
                                    item['no_ruas'].toString() +
                                    ' ' +
                                    item['nama_ruas'].toString());
                              }).toList(),
                              hint: "Ruas Jalan",
                              
                              /*items: list.map((item) =>
                                  "${item["no_ruas"]} ${item["nama_ruas"]}"),*/
                              onChanged: (newValue) {
                                setState(() {
                                  _mySelection = newValue;
                                });
                              },
                            )),
                      ]),
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 50, top: 10),
                              child: Text(
                                "Jenis Kerusakan",
                                style:
                                    TextStyle(color: kTextColor, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                              width: size.width * 0.8,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: kTextColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownSearch(
                                //style: const TextStyle(color: Colors.black),

                                showSearchBox: true,
                                items: list2.map((item) {
                                  return (item['id_ik'].toString() +
                                      '. ' +item['nama_ik'].toString() +
                                      ' ' +
                                      item['keterangan_ik'].toString());
                                }).toList(),
                                  hint: "Jenis Kerusakan",
                                onChanged: (newValue) {
                                  setState(() {
                                    _mySelection2 = newValue;
                                  });
                                },
                              )),
                        ],
                      ), //ruas jalan
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 50, top: 10),
                              child: Text(
                                "Deskripsi",
                                style:
                                    TextStyle(color: kTextColor, fontSize: 15),
                              ),
                            ),
                          ),
                          DescriptionField(
                            controller: _controllerDeskripsi,
                            hintText: "Tulis Deskripsi Daerah",
                            onChanged: (value) {
                              bool isFieldValid = value.trim().isNotEmpty;
                              if (isFieldValid != _isDeskripsiValid) {
                                setState(
                                    () => _isDeskripsiValid = isFieldValid);
                              }
                            },
                          ),
                        ],
                      ), //deskripsi
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 50, top: 10, bottom: 5),
                              child: Text(
                                "Tanggal Pengaduan",
                                style:
                                    TextStyle(color: kTextColor, fontSize: 15),
                              ),
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ), //tanggal pengaduan
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 30),
                        child: FlatButton(
                          color: kTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(10),
                          minWidth: 200,
                          onPressed: () {
                            if (_isFieldNameValid == null ||
                                _isFieldHPValid == null ||
                                _isDeskripsiValid == null ||
                                !_isFieldNameValid ||
                                !_isFieldHPValid ||
                                !_isDeskripsiValid) {
                              _scaffoldState.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Please fill all field"),
                                ),
                              );
                              return;
                            }
                            showLoaderDialog(context);
                            setState(() => _isLoading = true);
                            String name1 = _controllerName.text.toString();
                            String noHp = _controllerHP.text.toString();
                            String deskripsi =
                                _controllerDeskripsi.text.toString();
                            String koordinat = userLocation.latitude.toString();
                            String koordinatlong =
                                userLocation.longitude.toString();
                            String list1 = _mySelection;
                            String list2 = _mySelection2;
                            File gambar = _images2;
                            //String tanggal = formattedDate.toString();
                            _apiService
                                .postData(
                                    context,
                                    name1,
                                    noHp,
                                    koordinat,
                                    koordinatlong,
                                    deskripsi,
                                    list1,
                                    list2,
                                    gambar)
                                .then((isSuccess) {
                              setState(() => _isLoading = false);
                              if (isSuccess != null) {
                                _scaffoldState.currentState
                                    .showSnackBar(SnackBar(
                                  content: Text("Berhasil Meng-upload data"),
                                ));
                              }
                              /*else if(isSuccess == null) {
                                _scaffoldState.currentState.showSnackBar(SnackBar(
                                  content: Text("Gagal Meng-upload data"),
                                ));
                              }*/
                            });
                          },
                          child: Text(
                            "Lanjut",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
