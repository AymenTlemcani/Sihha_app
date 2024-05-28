import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture3.dart';
import 'package:sahha_app/CommonWidgets/MySearchTextField.dart';
import 'package:sahha_app/Models/Actors/Child.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Objects/HealthPlace.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/CommonWidgets/MyButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

//TODO new create logic
class _CreateUserState extends State<CreateUser> {
  HealthPlace? selectedHealthPlace;
  final TextEditingController _idController = TextEditingController();
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  final TextEditingController _responsableIDNController =
      TextEditingController();
  final TextEditingController _passwordUserController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _workPlaceController = TextEditingController();

  final TextEditingController _doctorProfessionalPhoneNumberController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _selectedUserType;
  File? _imageFile;
  DateTime? _birthDate;
  bool newIsAdmin = false;
  bool newIsMedcin = false;
  bool newIsPharmacie = false;

  bool _enableCreateButton = false;
  @override
  void initState() {
    super.initState();
    _idController.addListener(_updateCreateButton);
    _passwordUserController.addListener(_updateCreateButton);
    _confirmPasswordController.addListener(_updateCreateButton);
    _familyNameController.addListener(_updateCreateButton);
    _nameController.addListener(_updateCreateButton);
    _birthPlaceController.addListener(_updateCreateButton);
    _genderController.addListener(_updateCreateButton);
    _adresseController.addListener(_updateCreateButton);
    _telephoneController.addListener(_updateCreateButton);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordUserController.dispose();
    _confirmPasswordController.dispose();
    _familyNameController.dispose();
    _nameController.dispose();
    _birthPlaceController.dispose();
    _genderController.dispose();
    _adresseController.dispose();
    _telephoneController.dispose();

    super.dispose();
  }

  void _updateCreateButton() {
    setState(() {
      _enableCreateButton = _idController.text.isNotEmpty &&
          _passwordUserController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          (_passwordUserController.text == _confirmPasswordController.text) &&
          _familyNameController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _birthPlaceController.text.isNotEmpty &&
          _genderController.text.isNotEmpty &&
          _adresseController.text.isNotEmpty &&
          _birthDate != null &&
          _telephoneController.text.isNotEmpty &&
          _specialityController.text.isNotEmpty &&
          _selectedUserType != null;
    });
  }

  void _createAdult() {
    if (_formKey.currentState!.validate()) {
      // Check if the user already exists in the database
      FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: _idController.text)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Un utilisateur avec cet IDN existe déjà.'),
            ),
          );
        } else {
          // Validate inputs
          if (_selectedUserType == null ||
              _idController.text.isEmpty ||
              _passwordUserController.text.isEmpty ||
              _confirmPasswordController.text.isEmpty ||
              _familyNameController.text.isEmpty ||
              _nameController.text.isEmpty ||
              _birthDate == null ||
              _birthPlaceController.text.isEmpty ||
              _genderController.text.isEmpty ||
              _adresseController.text.isEmpty ||
              _telephoneController.text.isEmpty ||
              (_selectedUserType == 'Medcin' &&
                  (_specialityController.text.isEmpty ||
                      _workPlaceController.text.isEmpty ||
                      _doctorProfessionalPhoneNumberController.text.isEmpty))) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("S'il vous plaît remplir tous les champs."),
              ),
            );
            return;
          }

          User newUser = User(
            isAdmin: newIsAdmin,
            isMedcin: newIsMedcin,
            isPharmacien: newIsPharmacie,
            IDN: _idController.text,
            familyName: _familyNameController.text,
            name: _nameController.text,
            password: _passwordUserController.text,
            birthDate: Timestamp.fromDate(_birthDate!),
            birthPlace: _birthPlaceController.text,
            adresse: _adresseController.text,
            bio: '',
            email: '',
            documentId: '',
            gender: _genderController.text,
            profilePicUrl: '',
            telephone: _telephoneController.text,
            userName: '',
          );

          Map<String, dynamic> userMap = newUser.toMap();

          // Upload data to Firestore
          DocumentReference userDocRef =
              await FirebaseFirestore.instance.collection('users').add(userMap);

          await userDocRef.update({'documentId': userDocRef.id});

          if (newIsMedcin) {
            Medcin newMedcin = Medcin(
              IDN: _idController.text,
              documentId: userDocRef.id,
              workPlace: selectedHealthPlace,
              isAdmin: false,
              isMedcin: true,
              isPharmacien: false,
              name: _nameController.text,
              familyName: _familyNameController.text,
              professionalPhoneNumber:
                  _doctorProfessionalPhoneNumberController.text,
              speciality: _specialityController.text,
            );
            Map<String, dynamic> medcinMap = newMedcin.toMap();
            await FirebaseFirestore.instance
                .collection('medcins')
                .doc(userDocRef.id)
                .set(medcinMap);
          }

          // Upload the profile picture if available
          if (_imageFile != null) {
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirProfilePics =
                referenceRoot.child("ProfilePics");
            Reference referenceImageToUpload = referenceDirProfilePics
                .child("${newUser.familyName}_${newUser.name}.jpeg");

            await referenceImageToUpload.putFile(_imageFile!);
            String url = await referenceImageToUpload.getDownloadURL();

            await userDocRef.update({'profilePicUrl': url});
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User created successfully.'),
            ),
          );

          clearInputFields();
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating user: $error'),
          ),
        );
      });
    }
  }

  void _createChild() {
    if (_formKey.currentState!.validate()) {
      // Check if the responsable exists in the database
      FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: _responsableIDNController.text)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        // if Empty tell em
        if (querySnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Le Responsable ne existe pas.'),
            ),
          );
        } else {
          // Validate inputs
          if (_selectedUserType == null ||
              _responsableIDNController.text.isEmpty ||
              _familyNameController.text.isEmpty ||
              _nameController.text.isEmpty ||
              _birthDate == null ||
              _birthPlaceController.text.isEmpty ||
              _genderController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("S'il vous plaît remplir tous les champs."),
              ),
            );
            return;
          }

          // Create a Child instance
          Child newChild = Child(
            documentId: '',
            responsableId: querySnapshot.docs.first.id,
            responsableIDN: _responsableIDNController.text,
            name: _nameController.text,
            familyName: _familyNameController.text,
            birthDate: Timestamp.fromDate(_birthDate!),
            gender: _genderController.text,
            birthPlace: _birthPlaceController.text,
            profilePicUrl: '',
          );

          // Convert the Child instance to a map
          Map<String, dynamic> childMap = newChild.toMap();

          // Upload the data to Firestore
          DocumentReference childDocRef = await FirebaseFirestore.instance
              .collection('mineurs')
              .add(childMap);

          await childDocRef.update({'documentId': childDocRef.id});

          // Upload the profile picture if available
          if (_imageFile != null) {
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirProfilePics =
                referenceRoot.child("ProfilePics");
            Reference referenceImageToUpload = referenceDirProfilePics
                .child("${newChild.familyName}_${newChild.name}.jpeg");

            await referenceImageToUpload.putFile(_imageFile!);
            String url = await referenceImageToUpload.getDownloadURL();

            await childDocRef.update({'profilePicUrl': url});
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mineur créé avec succès.'),
            ),
          );
        }
      }).catchError((error) {
        // Error occurred while uploading data
        print("Failed to add child: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Échec de la création de Mineur."),
          ),
        );
      });
    }
  }
/*********************** MY VERSION BEFORE ADDING IMAGE UPLOADING ********************************** */
//   void _createAdult() {
//     if (_formKey.currentState!.validate()) {
//       // Check if the user already exists in the database
//       FirebaseFirestore.instance
//           .collection('users')
//           .where('IDN', isEqualTo: _idController.text)
//           .get()
//           .then((QuerySnapshot querySnapshot) {
//         if (querySnapshot.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Un utilisateur avec cet IDN existe déjà.'),
//             ),
//           );
//         } else {
//           // Validate inputs
//           if (_selectedUserType == null ||
//               _idController.text.isEmpty ||
//               _passwordUserController.text.isEmpty ||
//               _confirmPasswordController.text.isEmpty ||
//               _familyNameController.text.isEmpty ||
//               _nameController.text.isEmpty ||
//               _birthDate == null ||
//               _birthPlaceController.text.isEmpty ||
//               _genderController.text.isEmpty ||
//               _adresseController.text.isEmpty ||
//               _telephoneController.text.isEmpty ||
//               (_selectedUserType == 'Medcin' &&
//                   (_specialityController.text.isEmpty ||
//                       _workPlaceController.text.isEmpty ||
//                       _doctorProfessionalPhoneNumberController.text.isEmpty))) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("S'il vous plaît remplir tous les champs."),
//               ),
//             );
//             return;
//           }
//           User newUser = User(
//             isAdmin: newIsAdmin,
//             isMedcin: newIsMedcin,
//             isPharmacien: newIsPharmacie,
//             IDN: _idController.text,
//             familyName: _familyNameController.text,
//             name: _nameController.text,
//             password: _passwordUserController.text,
//             // birthDate: Timestamp.fromDate(_birthDate!),
//             birthDate: Timestamp.fromDate(_birthDate!),
//             birthPlace: _birthPlaceController.text,
//             adresse: _adresseController.text,
//             bio: '',
//             email: '',
//             documentId: '',
//             gender: _genderController.text,
//             profilePicUrl: '',
//             telephone: _telephoneController.text,
//             userName: '',
//           );

//           Map<String, dynamic> userMap = newUser.toMap();

//           // Upload data to Firestore
//           FirebaseFirestore.instance
//               .collection('users')
//               .add(userMap)
//               .then((value) {
//             print(value.id);

//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(value.id)
//                 .update({'documentId': value.id});
//             if (newIsMedcin) {
//               Medcin newMedcin = Medcin(
//                 IDN: _idController.text,
//                 documentId: value.id,
//                 workPlace: selectedHealthPlace,
//                 isAdmin: false,
//                 isMedcin: true,
//                 isPharmacien: false,
//                 name: _nameController.text,
//                 familyName: _familyNameController.text,
//                 professionalPhoneNumber:
//                     _doctorProfessionalPhoneNumberController.text,
//                 speciality: _specialityController.text,
//               );
//               Map<String, dynamic> medcinMap = newMedcin.toMap();
//               FirebaseFirestore.instance
//                   .collection('medcins')
//                   .doc(value.id)
//                   .set(medcinMap);
//             }
//  // Upload the profile picture if available
//         if (_imageFile != null) {
//           Reference referenceRoot = FirebaseStorage.instance.ref();
//           Reference referenceDirProfilePics = referenceRoot.child("ProfilePics");
//           Reference referenceImageToUpload = referenceDirProfilePics
//               .child("${newUser.familyName}_${newUser.name}.jpeg");

//           await referenceImageToUpload.putFile(_imageFile!);
//           String url = await referenceImageToUpload.getDownloadURL();

//           await userDocRef.update({'profilePicUrl': url});
//         }
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('User created successfully.'),
//               ),
//             );

//             clearInputFields();
//           }).catchError((error) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Error creating user: $error'),
//               ),
//             );
//           });
//         }
//       });
//     }
//   }

//   void _createChild() {
//     if (_formKey.currentState!.validate()) {
//       // Check if the responsable exists in the database
//       FirebaseFirestore.instance
//           .collection('users')
//           .where('IDN', isEqualTo: _responsableIDNController.text)
//           .get()
//           .then((QuerySnapshot querySnapshot) {
//         // if Empty tell em
//         if (querySnapshot.docs.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Le Responsable ne existe pas.'),
//             ),
//           );
//         } else {
//           // Create the child
//           // Validate inputs
//           if (_selectedUserType == null ||
//               _responsableIDNController.text.isEmpty ||
//               _familyNameController.text.isEmpty ||
//               _nameController.text.isEmpty ||
//               _birthDate == null ||
//               _birthPlaceController.text.isEmpty ||
//               _genderController.text.isEmpty) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("S'il vous plaît remplir tous les champs."),
//               ),
//             );
//             return;
//           }

//           // Create a Child instance
//           Child newChild = Child(
//             documentId: '',
//             responsableId: querySnapshot.docs.first.id,
//             responsableIDN: _responsableIDNController.text,
//             name: _nameController.text,
//             familyName: _familyNameController.text,
//             birthDate: Timestamp.fromDate(_birthDate!),
//             gender: _genderController.text,
//             birthPlace: _birthPlaceController.text,
//             // address: querySnapshot.docs.first['address'],
//             profilePicUrl:
//                 '', // You need to provide the URL for the profile picture here
//           );

//           // Convert the Child instance to a map
//           Map<String, dynamic> childMap = newChild.toMap();

//           // Upload the data to Firestore

//           FirebaseFirestore.instance
//               .collection('mineurs')
//               .add(childMap)
//               .then((value) {
//             //update id
//             FirebaseFirestore.instance
//                 .collection('mineurs')
//                 .doc(value.id)
//                 .update({'documentId': value.id}).then(
//               (_) {
//                 // Show a snackbar
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Mineur créé avec succès.')));
//               },
//             );
//             //TODO upload profile picture
//           }
//                   //

//                   ).catchError((error) {
//             // Error occurred while uploading data
//             print("Failed to add child: $error");
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("Échec de la création de Mineur."),
//               ),
//             );
//           });
//         }
//       });
//     }
//   }
/******************************************************************************** */
  // Widget _buildFormFields() {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
  //     MyButton(
  //       onPressed: _selectedUserType == 'Mineur' ? _createChild : _createAdult,

  //       // _enableCreateButton
  //       //     ? () {

  //       //       }
  //       //     : null,
  //       buttonText: 'Create User',
  //       ButtonColor: SihhaGreen1,
  //       TextButtonColor: SihhaWhite,
  //     ),
  //   ]);
  // }

  DropdownButtonFormField<String> _userTypeSelection() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      itemHeight: 60,
      focusColor: Colors.white,
      // style: TextStyle(),

      value: _selectedUserType,
      onChanged: (value) {
        setState(() {
          _selectedUserType = value;
          if (value == 'Admin') {
            newIsAdmin = true;
            newIsMedcin = false;
            newIsPharmacie = false;
          } else if (value == 'Medcin') {
            newIsAdmin = false;
            newIsMedcin = true;
            newIsPharmacie = false;
          } else if (value == 'Pharmacien') {
            newIsAdmin = false;
            newIsMedcin = false;
            newIsPharmacie = true;
          } else {
            newIsAdmin = false;
            newIsMedcin = false;
            newIsPharmacie = false;
          }
        });
        _updateCreateButton();
      },
      items: ['Adulte', 'Mineur', 'Medcin', 'Pharmacien', 'Admin']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        focusColor: Colors.transparent,
        labelText: 'Type de compte',
        labelStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      ),
      // padding: const EdgeInsets.fromLTRB(19, 10, 19, 2),
    );
  }

  DropdownButtonFormField<String> _genderSelection() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      elevation: 3,
      itemHeight: 60,
      value: _genderController.text.isEmpty ? null : _genderController.text,
      onChanged: (value) {
        setState(() {
          _genderController.text = value!;
        });
      },
      items: ['male', 'female'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Sexe',
        labelStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
        floatingLabelStyle:
            GoogleFonts.poppins(color: Color.fromARGB(255, 49, 143, 99)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF6DCEA1), width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          // !Platform.isWindows
          // ?
          AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          'Create User',
          style: SihhaPoppins3,
        ),
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => HomeBody(),
              ),
            );
          },
        ),
      ),
      // : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Platform.isWindows
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 600,
                        child: _buildForms(context),
                      ),
                    ],
                  )
                : _buildForms(context),
          ),
        ),
      ),
    );
  }

  Column _buildForms(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Profile pic and user type
        Row(
          mainAxisAlignment: Platform.isWindows
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProfilePicWithEditButton(),
            // _selectedUserType == 'Mineur'
            //     ? ProfilePicWithEditButton()
            //     : ProfilePicWithEditButtonChild(),
            // MyProfilePicture2(
            //   URL: null,
            //   frameRadius: 75,
            //   pictureRadius: 72,
            //   iconSize: 80,
            //   borderColor: SihhaGreen2,
            // ),
            // SizedBox(width: 50),
            if (Platform.isWindows) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Container(
                  // height: 60,
                  width: 200,
                  child: _userTypeSelection(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Container(
                  // height: 60,
                  width: 200,
                  child: _genderSelection(),
                ),
              ),
            ],
            if (!Platform.isWindows) ...[
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      // height: 60,
                      width: 200,
                      child: _userTypeSelection(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      // height: 60,
                      width: 200,
                      child: _genderSelection(),
                    ),
                  ),
                ],
              )
            ],
            // SizedBox(width: 16),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (_selectedUserType != 'Mineur') ...[
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Numéro de la carte national',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  controller: _idController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(18),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer le Numéro de la carte national';
                    } else if (value.length != 18) {
                      return 'Le Numéro doit être composé de 18 chiffres';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
        if (_selectedUserType == 'Mineur') ...[
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Numéro de la carte national de responsable',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  controller: _responsableIDNController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(18),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer le Numéro de la carte national de responsable';
                    } else if (value.length != 18) {
                      return "Le Numéro doit être composé de 18 chiffres";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
        SizedBox(
          height: 10,
        ),
        if (_selectedUserType != 'Mineur') ...[
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Mot de passe',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordUserController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "s'il vous plait entrez le mot de passe";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez confirmer le mot de passe';
                    } else if (value != _passwordUserController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
        ],
        Row(
          children: [
            Expanded(
              child: MyTextForm(
                hintText: 'Nom de Famille',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _familyNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le nom de famille';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: MyTextForm(
                hintText: 'Nom',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le nom';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: MyTextForm(
                hintText: "Date de Naissance",
                obscureText: false,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                controller: TextEditingController(
                  text: _birthDate != null
                      ? _birthDate!.toString().split(' ')[0]
                      : '',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez entrer votre la date de naissance';
                  }
                  return null;
                },
                onTapFunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text('Sélectionner la date de naissance'),
                        titleTextStyle: SihhaPoppins3,
                        contentPadding: EdgeInsets.all(16),
                        children: [
                          SizedBox(
                            height: 400, // Set a fixed height
                            width: 400, // Set a fixed width
                            child: SfDateRangePicker(
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              // initialSelectedRange:
                              //     PickerDateRange(
                              //   DateTime.now(),
                              //   DateTime.now()
                              //       .add(Duration(days: 7)),
                              // ),
                              minDate: _selectedUserType == 'Mineur'
                                  ? DateTime(DateTime.now().year - 18,
                                      DateTime.now().month, DateTime.now().day)
                                  : null,
                              maxDate: DateTime.now(),
                              showActionButtons: true,
                              cancelText: 'Annuler',
                              confirmText: 'Confirmer',

                              // initialSelectedDate:
                              //     DateTime.now().add(
                              //         Duration(days: 15)),
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onSubmit: (p0) {
                                setState(
                                  () {
                                    _birthDate =
                                        _dateRangePickerController.selectedDate;
                                    print(
                                        '---------------------------------------------\n');
                                    print('Selected Date : ${_birthDate}\n');
                                    print(
                                        'Selected Date type : ${_birthDate.runtimeType}\n');
                                    print(
                                        '---------------------------------------------\n');
                                  },
                                );
                                Navigator.pop(context);
                              },
                              controller: _dateRangePickerController,
                              // monthCellStyle:
                              //     DateRangePickerMonthCellStyle(textStyle: SihhaFont,),
                              selectionColor: SihhaGreen2,
                              selectionTextStyle: SihhaFont.copyWith(
                                  color: SihhaWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22),
                              selectionShape:
                                  DateRangePickerSelectionShape.rectangle,
                              todayHighlightColor: Color(0xFF2C3E50),
                              showNavigationArrow: true,
                              allowViewNavigation: true,
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                disabledDatesTextStyle: SihhaFont.copyWith(
                                    color: Color(0xFFCCCCCC), fontSize: 18),
                                // leadingDatesTextStyle: SihhaFont.copyWith(
                                //     color: SihhaWhite,
                                //     fontWeight: FontWeight.w500,
                                //     fontSize: 22),
                                todayTextStyle: SihhaFont.copyWith(
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                                todayCellDecoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: SihhaGreen2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    // color: SihhaGreen2,
                                    shape: BoxShape.rectangle),
                                textStyle: SihhaFont.copyWith(
                                    color: Color(0xFF6C7A89),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              headerStyle: DateRangePickerHeaderStyle(
                                textStyle: SihhaFont.copyWith(
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              yearCellStyle: DateRangePickerYearCellStyle(
                                textStyle: SihhaFont.copyWith(
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                                disabledDatesTextStyle: SihhaFont.copyWith(
                                    color: Color(0xFFCCCCCC), fontSize: 18),
                                todayTextStyle: SihhaFont.copyWith(
                                    color: Color(0xFF2C3E50),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                                todayCellDecoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: SihhaGreen2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  // color: SihhaGreen2,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: MyTextForm(
                hintText: 'Lieu de Naissance',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _birthPlaceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le lieu de Naissance';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        if (_selectedUserType != 'Mineur') ...[
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Address',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: _adresseController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Veuillez entrer l'adresse";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
        if (_selectedUserType != 'Mineur') ...[
          Row(
            children: [
              Expanded(
                child: MyTextForm(
                  hintText: 'Téléphone',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  controller: _telephoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer le numéro de téléphone';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],

        SizedBox(height: 20),
        Column(
          children: [
            if (_selectedUserType == 'Medcin') ...[
              MySearchTextField(
                  width: double.infinity,
                  hintText: 'Spécialité médicale',
                  controller: _specialityController,
                  suggestions: medicalSpecialties),
              SizedBox(height: 10),
              MySearchTextField(
                width: double.infinity,
                hintText: 'Adresse de travail',
                controller: _workPlaceController,
                suggestions: healthPlaces,
                onSuggestionSelected: (suggestion) {
                  if (suggestion is Map<String, String>) {
                    setState(() {
                      selectedHealthPlace = HealthPlace.fromMap(suggestion);
                      print(_workPlaceController.text);
                      print(selectedHealthPlace!.name);
                      print(selectedHealthPlace!.address);
                      print(selectedHealthPlace!.description);
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              MyTextForm(
                width: double.infinity,
                hintText: 'Numéro de téléphone professionnel',
                obscureText: false,
                keyboardType: TextInputType.phone,
                controller: _doctorProfessionalPhoneNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          MyButton(
            onPressed:
                _selectedUserType == 'Mineur' ? _createChild : _createAdult,

            // _enableCreateButton
            //     ? () {

            //       }
            //     : null,
            buttonText: 'Create User',
            ButtonColor: SihhaGreen1,
            TextButtonColor: SihhaWhite,
          ),
        ])
      ],
    );
  }

  Stack ProfilePicWithEditButton() {
    return Stack(
      children: [
        MyProfilePicture3(
          // URL: _imageFile.path,
          imageFile: _imageFile,
          frameRadius: 75,
          pictureRadius: 72,
          iconSize: 80,
          borderColor: SihhaGreen2,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: SihhaGreen2.withOpacity(1),
            ),
            child: IconButton(
              alignment: Alignment.center,
              onPressed: _pickImage,
              icon: Icon(
                CupertinoIcons.photo_camera_solid,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Stack ProfilePicWithEditButtonChild(Child child) {
  //   return Stack(
  //     children: [
  //       MyProfilePicture2(
  //         URL: child.profilePicUrl,
  //         frameRadius: 75,
  //         pictureRadius: 72,
  //         iconSize: 80,
  //         borderColor: SihhaGreen2,
  //       ),
  //       Positioned(
  //         bottom: 0,
  //         right: 0,
  //         child: Container(
  //           width: 35,
  //           height: 35,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(50),
  //             color: SihhaGreen2.withOpacity(1),
  //           ),
  //           child: IconButton(
  //             alignment: Alignment.center,
  //             onPressed: _pickImage,
  //             icon: Icon(
  //               CupertinoIcons.photo_camera_solid,
  //               color: Colors.white,
  //               size: 20,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void clearInputFields() {
    _idController.clear();
    _responsableIDNController.clear();
    _passwordUserController.clear();
    _confirmPasswordController.clear();
    _familyNameController.clear();
    _nameController.clear();
    _birthPlaceController.clear();
    _genderController.clear();
    _adresseController.clear();
    _telephoneController.clear();
    _specialityController.clear();
    _workPlaceController.clear();
    _doctorProfessionalPhoneNumberController.clear();
    setState(() {
      _selectedUserType = null;
      newIsAdmin = false;
      newIsMedcin = false;
      newIsPharmacie = false;
      _birthDate = null;
      // _imageFile = null; // Reset the image file
    });
  }

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //   // When you click on the submit button, you can upload the image to Firebase Storage, get the URL, and add it to the user's profile picture URL field.
  //   if (_enableCreateButton && _imageFile != null) {
  //     // Upload the image to Firebase Storage and get the URL
  //     String imageUrl = await uploadImageToFirebaseStorage(_imageFile!);

  //     // Add the URL to the user's profile picture URL field
  //     _reference.doc(userId).update({'profilePicUrl': imageUrl});
  //   }
  // }

  // Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  //   // Implement your Firebase Storage upload logic here
  //   // and return the download URL of the uploaded image
  // }
  /**************************************************************************************************** */
  // PickAndUpload(Patient patient) async {
  //   //Pick the image
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedFile =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //   print('PICKED FILE PATH : ${pickedFile?.path}');
  //   if (pickedFile == null) {
  //     return;
  //   }

  //   //Get the ref
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirProfilePics = referenceRoot.child("ProfilePics");
  //   Reference referenceImageToUploaod = referenceDirProfilePics
  //       .child("${patient.familyName}_${patient.name}.jpeg");

  //   // print(globalUser!.documentId.toString());

  //   try {
  //     //Upload to Firebase Storage
  //     await referenceImageToUploaod.putFile(File(pickedFile.path));
  //     // Get the download URL and update it in Firestore Database
  //     String url = await referenceImageToUploaod.getDownloadURL();
  //     patient.profilePicUrl = url;
  //     // user!.updateProfilePicUrl(url);
  //     print(patient.profilePicUrl);
  //     Map<String, dynamic> dataToUpload = {
  //       'profilePicUrl': patient.profilePicUrl.toString(),
  //     };
  //     //Update User Data in Firestore
  //     await _referenceAdultes.doc(patient.documentId).update(dataToUpload);
  //   } catch (e) {
  //     print('error while uploading : $e');
  //   }
  // }

  // PickAndUploadChild(Child child) async {
  //   // final loginProvider = Provider.of<LoginControllerProvider>(context);
  //   // User? user = loginProvider.user;

  //   //Pick the image
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedFile =
  //       await imagePicker.pickImage(source: ImageSource.gallery);
  //   print('PICKED FILE PATH : ${pickedFile?.path}');
  //   if (pickedFile == null) {
  //     return;
  //   }

  //   //Get the ref
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirProfilePics = referenceRoot.child("ProfilePics");
  //   Reference referenceImageToUploaod =
  //       referenceDirProfilePics.child("${child.familyName}_${child.name}.jpeg");

  //   print(child.documentId.toString());

  //   try {
  //     //Upload to Firebase Storage
  //     await referenceImageToUploaod.putFile(File(pickedFile.path));
  //     // Get the download URL and update it in Firestore Database
  //     String url = await referenceImageToUploaod.getDownloadURL();
  //     child.profilePicUrl = url;
  //     // user!.updateProfilePicUrl(url);
  //     print(child.profilePicUrl);
  //     Map<String, dynamic> dataToUpload = {
  //       'profilePicUrl': child.profilePicUrl.toString(),
  //     };
  //     //Update User Data in Firestore
  //     await _referenceMineurs.doc(child.documentId).update(dataToUpload);
  //   } catch (e) {
  //     print('error while uploading : $e');
  //   }
  // }
}
