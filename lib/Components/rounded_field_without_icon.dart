
import 'package:flutter/material.dart';
import 'package:petik_bm/Components/text_field_container.dart';
import 'package:petik_bm/constants.dart';

class RoundedFieldWithoutIcon extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Function validator;
  final TextEditingController controller;

  const RoundedFieldWithoutIcon({
    Key key,
    this.onChanged, this.hintText, this.validator, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        validator: validator,
        obscureText: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}