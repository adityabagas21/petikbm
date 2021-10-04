
import 'package:flutter/material.dart';
import 'package:petik_bm/Components/text_field_container.dart';
import 'package:petik_bm/constants.dart';

class RoundedFieldPilihan extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Function validator;

  const RoundedFieldPilihan({
    Key key,
    this.onChanged, this.hintText, this.validator, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        obscureText: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(Icons.keyboard_arrow_down),
            color: kTextColor,
          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}