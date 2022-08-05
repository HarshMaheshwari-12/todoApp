import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String labelText;
  final bool isObscure;
  final String Function(String) textFieldValidator;
  final Color color;
  const CustomTextField(
      {Key key,
      this.editingController,
      this.labelText,
      this.isObscure,
      this.color,
      this.textFieldValidator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: editingController,
        obscureText: isObscure,
        textAlign: TextAlign.start,
        autofocus: false,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              style: BorderStyle.none,
            ),
          ),
          // labelText: labelText,
          hintText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: color,
          filled: true,
          contentPadding: EdgeInsets.all(14),
        ),
        validator: textFieldValidator,
      ),
    );
  }
}
