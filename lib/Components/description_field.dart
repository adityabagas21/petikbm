
import 'package:flutter/material.dart';
import 'package:petik_bm/Components/text_field_container.dart';
import 'package:petik_bm/constants.dart';

class DescriptionField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Function validator;
  final TextEditingController controller;

  const DescriptionField({
    Key key,
    this.onChanged, this.hintText, this.validator, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: false,
        onChanged: onChanged,
        maxLines: 5,
        maxLength: 500,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}