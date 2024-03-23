import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextForm extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyTextForm({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.controller,
    this.validator,
  });

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: Container(
        width: MediaQuery.of(context).size.width < 600
            ? MediaQuery.of(context).size.width - 36
            : 600 - 36,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.obscureText,
            cursorColor: Color(0xFF6DCEA1),
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle:
                  GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
              floatingLabelStyle:
                  GoogleFonts.poppins(color: Color.fromARGB(255, 49, 143, 99)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Color.fromARGB(20, 82, 79, 79), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF6DCEA1), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
