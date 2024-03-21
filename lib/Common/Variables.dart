import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

bool modeAdmin = false;
bool modeMedcin = false;
bool modePharmacie = false;
bool isAdmin = false;
bool isMedcin = false;
bool isPharmacie = false;
bool isLoggedIN = false;

///
String? IDN;
String? familyName;
String? name;
String? birthPlace;
String? sexe;
// String? dateDeNaissance;
// String? lieuDeNaissance;
String? adresse;
int? ageUser;
int? birthDay;
int? birthMonth;
int? birthYear;
int? telephone;

///COLOR PALLETE
HexColor SihhaGreen1 = HexColor("6dcea1");
HexColor SihhaGreen2 = HexColor("509776");
HexColor SihhaGreen3 = HexColor("318f63");
// HexColor SihhaGreyBackgroundColor = HexColor("f2f2f2");
HexColor SihhaGreyBackgroundColor = HexColor("f8f8f8");

TextStyle SihhaTextStyleH1 = GoogleFonts.sarabun(
    color: const Color.fromARGB(255, 12, 12, 12),
    fontWeight: FontWeight.bold,
    fontSize: 20);
TextStyle SihhaTextStyleH2 = GoogleFonts.sarabun(
    color: Color.fromARGB(255, 12, 12, 12),
    fontWeight: FontWeight.w600,
    fontSize: 20);
TextStyle SihhaTextStyleH3 = GoogleFonts.sarabun(
    color: const Color.fromARGB(255, 12, 12, 12), fontWeight: FontWeight.w300);

///
TextStyle SihhaPoppins2 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25);

TextStyle SihhaPoppins3 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20);
