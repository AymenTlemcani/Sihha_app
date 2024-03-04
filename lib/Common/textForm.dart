import 'package:flutter/material.dart';

class MyTextForm extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const MyTextForm(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      required this.controller});

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: Container(
        width: MediaQuery.sizeOf(context).width < 1080
            ? MediaQuery.sizeOf(context).width - 36
            : 1080 - 36,
        child: TextFormField(
          validator: (value) =>
              value!.isEmpty ? 'This field cannot be empty' : null,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.obscureText,
          cursorColor: Color(0xFF6DCEA1),
          // textAlign: TextAlign.justify,

          decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              floatingLabelStyle:
                  TextStyle(color: Color.fromARGB(255, 49, 143, 99)),
              // suffixIcon: Visibility(
              //     child: IconButton(
              //       icon: obscureText
              //           ? Icon(Icons.visibility_off_outlined)
              //           : Icon(Icons.visibility),
              //       onPressed: () {
              //         setState(() {
              //           obscureText = !obscureText;
              //         });
              //       },
              //     ),
              //     visible: widget.SuffixIconVisibility),
              // enabled: false,
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(8),
              //     borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Color.fromARGB(20, 82, 79, 79), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF6DCEA1))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red))),
        ),
      ),
    );
  }
}
