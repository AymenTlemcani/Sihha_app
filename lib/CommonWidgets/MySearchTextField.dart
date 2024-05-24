import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MySuggestionDrawer.dart';

class MySearchTextField extends StatefulWidget {
  final String hintText;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTapFunction;
  final double? width;
  final List<dynamic> suggestions;
  final Function(dynamic)? onSuggestionSelected;

  const MySearchTextField({
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
    required this.suggestions,
    this.onSuggestionSelected,
  });

  @override
  State<MySearchTextField> createState() => _MySearchTextFieldState();
}

class _MySearchTextFieldState extends State<MySearchTextField> {
  List<dynamic> _suggestions = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSuggestions);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSuggestions);

    super.dispose();
  }

  void _updateSuggestions() {
    String input = widget.controller.text.toLowerCase();
    if (input.isNotEmpty) {
      _suggestions = widget.suggestions
          .where((suggestion) =>
              suggestion.toString().toLowerCase().contains(input))
          .toList();
    } else {
      _suggestions = [];
    }
    setState(() {});
  }

  void _selectSuggestion(dynamic suggestion) {
    if (suggestion is String) {
      widget.controller.text = suggestion;
    } else if (suggestion is Map<String, dynamic>) {
      widget.controller.text = suggestion['name'];
    }

    // Clear the suggestions list
    _suggestions.clear();
    setState(() {});
    FocusScope.of(context).unfocus();
    // Call the onSuggestionSelected callback if provided
    if (widget.onSuggestionSelected != null) {
      widget.onSuggestionSelected!(suggestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Container(
            width: widget.width != null
                ? widget.width!
                : MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width - 36
                    : 600 - 36,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                onTap: widget.onTapFunction,
                readOnly: widget.readOnly ?? false,
                validator: widget.validator,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                obscureText: widget.obscureText ?? false,
                cursorColor: const Color(0xFF6DCEA1),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  labelText: widget.hintText,
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.grey[400], fontSize: 14),
                  floatingLabelStyle: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 49, 143, 99)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(20, 82, 79, 79), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFF6DCEA1), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        SuggestionDrawer(
          suggestions: _suggestions,
          onSuggestionTapped: _selectSuggestion,
        ),
      ],
    );
  }
}
