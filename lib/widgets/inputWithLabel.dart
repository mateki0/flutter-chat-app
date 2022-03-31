import 'package:flutter/material.dart';

class InputWithLabel extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String inputKey;
  final Function validator;
  final bool obscureText;

  const InputWithLabel(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.inputKey,
      required this.validator,
      required this.obscureText})
      : super(key: key);

  @override
  _InputWithLabelState createState() => _InputWithLabelState();
}

class _InputWithLabelState extends State<InputWithLabel> {
  bool inputObscure = true;
  @override
  Widget build(BuildContext context) {
    void onPasswordIconClick() {
      setState(() {
        inputObscure = !inputObscure;
      });
    }

    return (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextFormField(
          key: Key(widget.inputKey),
          obscureText: inputObscure,
          validator: (value) => widget.validator(value, widget.inputKey),
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? InkWell(
                    child: Icon(
                        inputObscure ? Icons.visibility_off : Icons.visibility),
                    onTap: onPasswordIconClick)
                : null,
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(8.0),
          ),
          controller: widget.controller,
        ),
      ),
    ]));
  }
}
