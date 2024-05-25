import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';

User? globalUser;
Medcin? globalMedcin;

List<Patient>? patients;
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
String? gender;
String? adresse;
String? bloodType;
double? weight;
double? height;
int? ageUser;
int? birthDay;
int? birthMonth;
int? birthYear;
int? telephone;

String? profilePicUrl = '';
String? bio = '';
String? documentId;

///COLOR PALLETE
HexColor SihhaGreen1 = HexColor("6dcea1");
HexColor SihhaGreen2 = HexColor("509776");
HexColor SihhaGreen3 = HexColor("318f63");
HexColor SihhaWhite = HexColor('#FFFFFF');
// HexColor SihhaGreyBackgroundColor = HexColor("f2f2f2");
HexColor SihhaGreyBackgroundColor1 = HexColor("f2f2f6");
HexColor SihhaGreyBackgroundColor2 = HexColor("f8f8f8");

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
TextStyle SihhaFont = GoogleFonts.poppins(
  color: Color.fromARGB(255, 29, 29, 29),
  // color: Color(0xFFFFFFFF),
);
TextStyle SihhaPoppins1 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 28);
TextStyle SihhaPoppins2 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25);

TextStyle SihhaPoppins3 = GoogleFonts.poppins(
    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20);
TextStyle SihhaPoppins4 = GoogleFonts.poppins(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 17,
    letterSpacing: 2);
bool isSuccessfullyScanned = false;
int selectedIndex = 1;

// List<Map<String, dynamic>> healthPlaces = [
//   {'name': 'ABC Hospital', 'location': 'New York', 'type': 'Hospital'},
//   {'name': 'XYZ Clinic', 'location': 'Los Angeles', 'type': 'Clinic'},
//   {
//     'name': 'QRS Medical Center',
//     'location': 'Chicago',
//     'type': 'Medical Center'
//   },
// ];
List<Map<String, String>> healthPlaces = [
  {
    "name": "Hôpital Mustapha Pacha",
    "address": "1 Place du 1er Mai, Algiers, Algeria",
    "phone": "+213 21 23 63 88",
    "website": "http://www.chu-mustapha.dz",
    "email": "info@chu-mustapha.dz",
    "description":
        "One of the largest and oldest hospitals in Algeria, offering a wide range of medical services.",
    "profilePicUrl": "https://example.com/images/mustapha_pacha.jpg",
    "type": "hospital"
  },
  {
    "name": "Clinique El Djazair",
    "address": "Rue Frères Bouadou, Hydra, Algiers, Algeria",
    "phone": "+213 21 60 56 77",
    "website": "http://www.cliniqueeldjazair.dz",
    "email": "contact@cliniqueeldjazair.dz",
    "description":
        "A private clinic known for its high-quality healthcare services and modern facilities.",
    "profilePicUrl": "https://example.com/images/clinique_eldjazair.jpg",
    "type": "clinic"
  },
  {
    "name": "Polyclinique El Qods",
    "address": "Avenue des Frères Bouadou, Kouba, Algiers, Algeria",
    "phone": "+213 21 68 25 96",
    "website": "http://www.polycliniqueelqods.dz",
    "email": "info@polycliniqueelqods.dz",
    "description":
        "Offers a variety of outpatient services including general medicine, pediatrics, and gynecology.",
    "profilePicUrl": "https://example.com/images/polyclinique_elqods.jpg",
    "type": "polyclinic"
  },
  {
    "name": "Clinique Chahrazed",
    "address": "Rue Chahrazed, Oran, Algeria",
    "phone": "+213 41 34 78 45",
    "website": "http://www.cliniquechahrazed.dz",
    "email": "contact@cliniquechahrazed.dz",
    "description":
        "A well-regarded clinic in Oran offering comprehensive medical and surgical care.",
    "profilePicUrl": "https://example.com/images/clinique_chahrazed.jpg",
    "type": "clinic"
  },
  {
    "name": "Hôpital Militaire de Constantine",
    "address": "Constantine, Algeria",
    "phone": "+213 31 92 32 24",
    "website": "http://www.hopitalmilitaireconst.dz",
    "email": "info@hopitalmilitaireconst.dz",
    "description":
        "A military hospital providing specialized and general medical services to military personnel and civilians.",
    "profilePicUrl": "https://example.com/images/hopital_militaire_const.jpg",
    "type": "hospital"
  }
];

List<String> medicalSpecialties = [
  'Anesthésiologie',
  'Cardiologie',
  'Chirurgie cardiaque',
  'Chirurgie générale',
  'Chirurgie orthopédique',
  'Chirurgie plastique',
  'Chirurgie thoracique',
  'Chirurgie vasculaire',
  'Dermatologie',
  'Endocrinologie',
  'Gastro-entérologie',
  'Généraliste',
  'Gériatrie',
  'Gynécologie',
  'Hématologie',
  'Infectiologie',
  'Médecine d\'urgence',
  'Médecine du sport',
  'Médecine interne',
  'Néphrologie',
  'Neurologie',
  'Oncologie',
  'Ophtalmologie',
  'Oto-rhino-laryngologie (ORL)',
  'Pédiatrie',
  'Pneumologie',
  'Psychiatrie',
  'Radiologie',
  'Rhumatologie',
  'Urologie',
  'Médecine nucléaire',
  'Médecine préventive',
  'Médecine physique et de réadaptation',
  'Neurochirurgie',
  'Pathologie',
  'Pédiatrie générale',
  'Pédiatrie spécialisée',
  'Psychiatrie de l\'enfant et de l\'adolescent',
  'Santé publique',
  'Toxicologie',
  'Transfusion sanguine',
  'Hépatologie',
  'Immunologie',
  'Allergologie',
  'Chirurgie buccale et maxillo-faciale',
  'Chirurgie pédiatrique',
  'Chirurgie plastique reconstructive et esthétique',
  'Dermatopathologie',
  'Gynécologie-obstétrique',
  'Orthopédie pédiatrique',
  'Orthopédie traumatologique',
  'Oncologie pédiatrique',
  'Oncologie médicale',
  'Oncologie radiothérapie',
  'Oncologie chirurgicale',
  'Pathologie clinique',
  'Pathologie anatomique',
  'Pharmacologie clinique',
  'Pharmacologie',
  'Radiothérapie',
  'Reumatologie',
  'Sexologie',
  'Spécialiste en addiction',
  'Traumatologie',
  'Urgences pédiatriques',
  'Vénérologie'
];
List<Map<String, String>> medicaments = [
  {'name': 'Paracétamol', 'type': 'Analgésique', 'dosage': '500 mg'},
  {'name': 'Ibuprofène', 'type': 'Anti-inflammatoire', 'dosage': '400 mg'},
  {'name': 'Amoxicilline', 'type': 'Antibiotique', 'dosage': '500 mg'},
  {
    'name': 'Oméprazole',
    'type': 'Inhibiteur de la pompe à protons',
    'dosage': '20 mg'
  },
  {'name': 'Loratadine', 'type': 'Antihistaminique', 'dosage': '10 mg'},
  {'name': 'Atorvastatine', 'type': 'Hypolipidémiant', 'dosage': '10 mg'},
  {'name': 'Aspirine', 'type': 'Antipyrétique', 'dosage': '300 mg'},
  {'name': 'Metformine', 'type': 'Antidiabétique', 'dosage': '500 mg'},
  {'name': 'Amlodipine', 'type': 'Antihypertenseur', 'dosage': '5 mg'},
  {'name': 'Furosémide', 'type': 'Diurétique', 'dosage': '40 mg'},
  {'name': 'Lévothyroxine', 'type': 'Hormone thyroïdienne', 'dosage': '50 µg'},
  {'name': 'Prednisolone', 'type': 'Corticostéroïde', 'dosage': '20 mg'},
  {'name': 'Clopidogrel', 'type': 'Antiplaquettaire', 'dosage': '75 mg'},
  {'name': 'Diazépam', 'type': 'Anxiolytique', 'dosage': '5 mg'},
  {'name': 'Simvastatine', 'type': 'Hypolipidémiant', 'dosage': '20 mg'},
  {'name': 'Diclofénac', 'type': 'Anti-inflammatoire', 'dosage': '50 mg'},
  {'name': 'Ciprofloxacine', 'type': 'Antibiotique', 'dosage': '500 mg'},
  {'name': 'Tramadol', 'type': 'Analgesique opioïde', 'dosage': '50 mg'},
  {'name': 'Warfarine', 'type': 'Anticoagulant', 'dosage': '5 mg'},
  {
    'name': 'Lisinopril',
    'type': 'Inhibiteur de l\'enzyme de conversion',
    'dosage': '10 mg'
  },
];
List<String?> doctorProfilePicUrls = [];
