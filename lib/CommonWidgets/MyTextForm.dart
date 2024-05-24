import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextForm extends StatefulWidget {
  final String hintText;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTapFunction;
  final double? width;

  const MyTextForm({
    super.key,
    required this.hintText,
    this.obscureText,
    this.keyboardType,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.onTapFunction,
    this.readOnly,
    this.width,
  });

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Container(
        width: widget.width != null
            ? widget.width!
            : MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width - 36
                : 600 - 36,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            onTap: widget.onTapFunction,
            readOnly: widget.readOnly ?? false,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            cursorColor: Color(0xFF6DCEA1),
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
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
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MyTextForm extends StatefulWidget {
//   final String hintText;
//   final bool obscureText;
//   final bool? readOnly;
//   final TextInputType? keyboardType;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final VoidCallback? onTapFunction;
//   final double? width;
//   final bool? hasSuggestions;
//   final List<String>? suggestions;

//   const MyTextForm({
//     Key? key,
//     required this.hintText,
//     required this.obscureText,
//     this.keyboardType,
//     required this.controller,
//     this.validator,
//     this.inputFormatters,
//     this.onTapFunction,
//     this.readOnly,
//     this.width,
//     this.suggestions,
//     this.hasSuggestions,
//   }) : super(key: key);

//   @override
//   State<MyTextForm> createState() => _MyTextFormState();
// }

// class _MyTextFormState extends State<MyTextForm> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//       child: Container(
//         width: widget.width != null
//             ? widget.width!
//             : MediaQuery.of(context).size.width < 600
//                 ? MediaQuery.of(context).size.width - 36
//                 : 600 - 36,
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: widget.hasSuggestions ?? false
//               ? Autocomplete<String>(
//                   optionsBuilder: (TextEditingValue textEditingValue) {
//                     if (textEditingValue.text.isEmpty) {
//                       return const Iterable<String>.empty();
//                     }
//                     return widget.suggestions!.where((String option) {
//                       return option
//                           .toLowerCase()
//                           .contains(textEditingValue.text.toLowerCase());
//                     });
//                   },
//                   onSelected: (String selection) {
//                     widget.controller.text = selection;
//                   },
//                   fieldViewBuilder: (BuildContext context,
//                       TextEditingController fieldTextEditingController,
//                       FocusNode fieldFocusNode,
//                       VoidCallback onFieldSubmitted) {
//                     return _buildTextFormField(
//                         context, fieldTextEditingController, fieldFocusNode);
//                   },
//                 )
//               : _buildTextFormField(context, widget.controller, FocusNode()),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextFormField(BuildContext context,
//       TextEditingController controller, FocusNode focusNode) {
//     return TextFormField(
//       onTap: widget.onTapFunction,
//       readOnly: widget.readOnly ?? false,
//       validator: widget.validator,
//       inputFormatters: widget.inputFormatters,
//       keyboardType: widget.keyboardType,
//       controller: controller,
//       obscureText: widget.obscureText,
//       cursorColor: const Color(0xFF6DCEA1),
//       style: GoogleFonts.poppins(
//         fontSize: 18,
//       ),
//       decoration: InputDecoration(
//         labelText: widget.hintText,
//         labelStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
//         floatingLabelStyle:
//             GoogleFonts.poppins(color: const Color.fromARGB(255, 49, 143, 99)),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.grey, width: 1),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide:
//               const BorderSide(color: Color.fromARGB(20, 82, 79, 79), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF6DCEA1), width: 1),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.red, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.red, width: 1),
//         ),
//       ),
//     );
//   }
// }
