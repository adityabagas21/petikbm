import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser(
      {Key key, this.nama, this.nip, this.email, this.password, this.foto})
      : super(key: key);

  @override
  _ProfileUserState createState() => _ProfileUserState();

  final nama;
  final nip;
  final email;
  final password;
  final foto;

}

class _ProfileUserState extends State<ProfileUser> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            top: 30, left: kDefaultPadding, right: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 0.5),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/logopu.jpg"),
                  radius: 60.0,
                ),
              ),
            ),
            Text(
              widget.nama,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Nama",
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.nama,
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
                      "NIP",
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.nip ?? "Tidak Ada Data NIP",
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
                      "Email",
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.email ?? "Tidak Ada Data email",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
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
                    onPressed: () {_key.currentState
                        .showSnackBar(
                      SnackBar(
                        content:
                        Text("Coming Soon !"),
                      ),
                    );},
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }
}
