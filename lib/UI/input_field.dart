import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InputField extends StatefulWidget {
  final Icon fieldIcon;
  final String hintText;
  final TextEditingController _text;

  const InputField(this._text, this.fieldIcon, this.hintText, {Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Material(
        elevation: 5.0,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.fieldIcon,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              width: 200,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: TextField(
                    //TestField
                    controller: widget._text,

                    decoration: InputDecoration(
                      errorText: _validate ? "Please enter valid ${widget.hintText}" : null,
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}