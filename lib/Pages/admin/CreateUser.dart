import 'package:flutter/material.dart';
import 'package:sahha_app/Common/MyBackButton.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/HomeBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordUserController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _birthMonthController = TextEditingController();
  final TextEditingController _birthYearController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  String? _selectedUserType;

  bool newIsAdmin = false;
  bool newIsMedcin = false;
  bool newIsPharmacie = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Create User',
          style: TextStyle(
            fontFamily: 'SihhaPoppins3',
            color: Colors.black,
          ),
        ),
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeBody(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
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
                },
                items: ['Normal', 'Admin', 'Medcin', 'Pharmacien']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'User Type',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordUserController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _familyNameController,
                decoration: InputDecoration(
                  labelText: 'Family Name',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _birthPlaceController,
                decoration: InputDecoration(
                  labelText: 'Birth Place',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _sexeController,
                decoration: InputDecoration(
                  labelText: 'Sexe',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _adresseController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _birthDayController,
                decoration: InputDecoration(
                  labelText: 'Birth Day',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _birthMonthController,
                decoration: InputDecoration(
                  labelText: 'Birth Month',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _birthYearController,
                decoration: InputDecoration(
                  labelText: 'Birth Year',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (_selectedUserType == null ||
                      _idController.text.isEmpty ||
                      _passwordUserController.text.isEmpty ||
                      _familyNameController.text.isEmpty ||
                      _nameController.text.isEmpty ||
                      _birthPlaceController.text.isEmpty ||
                      _sexeController.text.isEmpty ||
                      _adresseController.text.isEmpty ||
                      _birthDayController.text.isEmpty ||
                      _birthMonthController.text.isEmpty ||
                      _birthYearController.text.isEmpty ||
                      _telephoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all fields.'),
                      ),
                    );
                    return;
                  }

                  // Convert input values to appropriate types
                  String idNewUser = _idController.text;
                  String passwordNewUser = _passwordUserController.text;
                  String familyNameNewUser = _familyNameController.text;
                  String nameNewUser = _nameController.text;
                  String birthPlaceNewUser = _birthPlaceController.text;
                  String sexeNewUser = _sexeController.text;
                  String adresseNewUser = _adresseController.text;
                  int birthDayNewUser = int.parse(_birthDayController.text);
                  int birthMonthNewUser = int.parse(_birthMonthController.text);
                  int birthYearNewUser = int.parse(_birthYearController.text);
                  int telephoneNewUser = int.parse(_telephoneController.text);

                  // Upload data to Firestore
                  FirebaseFirestore.instance.collection('users').add({
                    'IDN': idNewUser,
                    'password': passwordNewUser,
                    'familyName': familyNameNewUser,
                    'name': nameNewUser,
                    'birthDay': birthDayNewUser,
                    'birthMonth': birthMonthNewUser,
                    'birthYear': birthYearNewUser,
                    'birthPlace': birthPlaceNewUser,
                    'sexe': sexeNewUser,
                    'adresse': adresseNewUser,
                    'telephone': telephoneNewUser,
                    'isPharmacien': newIsPharmacie,
                    'isMedcin': newIsMedcin,
                    'isAdmin': newIsAdmin,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User created successfully.'),
                      ),
                    );
                    // Clear input fields after successful upload
                    _idController.clear();
                    _passwordUserController.clear();
                    _familyNameController.clear();
                    _nameController.clear();
                    _birthPlaceController.clear();
                    _sexeController.clear();
                    _adresseController.clear();
                    _birthDayController.clear();
                    _birthMonthController.clear();
                    _birthYearController.clear();
                    _telephoneController.clear();
                    setState(() {
                      _selectedUserType = null;
                      newIsAdmin = false;
                      newIsMedcin = false;
                      newIsPharmacie = false;
                    });
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error creating user: $error'),
                      ),
                    );
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
                child: Text(
                  'Create User',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
