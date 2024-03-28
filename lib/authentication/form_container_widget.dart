import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget(
      {this.controller,
      this.fieldkey,
      this.isPasswordField,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputType});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF98FB98)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: new TextFormField(
          style: TextStyle(color: Colors.white),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldkey,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: new InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xFF32343E),
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: widget.isPasswordField == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText == false ? Colors.white : Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
