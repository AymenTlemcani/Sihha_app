import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Common/MyBackButton.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Common/MyTextForm.dart';
import 'package:sahha_app/Common/MyButton.dart';
import 'package:sahha_app/Pages/HomeBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();

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
          style: SihhaPoppins3,
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
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                MyTextForm(
                  hintText: 'ID',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  controller: _idController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your ID';
                    } else if (value.length != 18) {
                      return 'ID should be 18 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                MyTextForm(
                  hintText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordUserController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password should be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Family Name',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: _familyNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your family name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                MyTextForm(
                  hintText: 'Birth Place',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: _birthPlaceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your birth place';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                MyTextForm(
                  hintText: 'Sexe',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: _sexeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your sexe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                MyTextForm(
                  hintText: 'Address',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: _adresseController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Birth Day',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        controller: _birthDayController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your birth day';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) < 1 ||
                              int.parse(value) > 31) {
                            return 'Invalid birth day';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Birth Month',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        controller: _birthMonthController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your birth month';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) < 1 ||
                              int.parse(value) > 12) {
                            return 'Invalid birth month';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Birth Year',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        controller: _birthYearController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your birth year';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) < 1900 ||
                              int.parse(value) > DateTime.now().year) {
                            return 'Invalid birth year';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                MyTextForm(
                  hintText: 'Telephone',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  controller: _telephoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your telephone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                MyButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If all validators pass, proceed with form submission

                      // Convert input values to appropriate types
                      String idNewUser = _idController.text;
                      String passwordNewUser = _passwordUserController.text;
                      String familyNameNewUser = _familyNameController.text;
                      String nameNewUser = _nameController.text;
                      String birthPlaceNewUser = _birthPlaceController.text;
                      String sexeNewUser = _sexeController.text;
                      String adresseNewUser = _adresseController.text;
                      int birthDayNewUser = int.parse(_birthDayController.text);
                      int birthMonthNewUser =
                          int.parse(_birthMonthController.text);
                      int birthYearNewUser =
                          int.parse(_birthYearController.text);
                      int telephoneNewUser =
                          int.parse(_telephoneController.text);

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
                    }
                  },
                  buttonText: 'Create User',
                  ButtonColor: HexColor('#6DCEA1'),
                  TextButtonColor: HexColor('#FFFFFF'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
