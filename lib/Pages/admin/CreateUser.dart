import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/CommonWidgets/MyButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordUserController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _birthMonthController = TextEditingController();
  final TextEditingController _birthYearController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicLocationController =
      TextEditingController();
  final TextEditingController _clinicPhoneNumberController =
      TextEditingController();
  final TextEditingController _doctorProfessionalPhoneNumberController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _selectedUserType;

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
    _birthDayController.addListener(_updateCreateButton);
    _birthMonthController.addListener(_updateCreateButton);
    _birthYearController.addListener(_updateCreateButton);
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
    _birthDayController.dispose();
    _birthMonthController.dispose();
    _birthYearController.dispose();
    _telephoneController.dispose();
    _specialityController.dispose();
    _clinicNameController.dispose();
    _doctorProfessionalPhoneNumberController.dispose();
    _clinicLocationController.dispose();
    _clinicPhoneNumberController.dispose();
    super.dispose();
  }

  void _updateCreateButton() {
    setState(() {
      _enableCreateButton = _idController.text.isNotEmpty &&
          _passwordUserController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordUserController.text == _confirmPasswordController.text &&
          _familyNameController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _birthPlaceController.text.isNotEmpty &&
          _genderController.text.isNotEmpty &&
          _adresseController.text.isNotEmpty &&
          _birthDayController.text.isNotEmpty &&
          _birthMonthController.text.isNotEmpty &&
          _birthYearController.text.isNotEmpty &&
          _telephoneController.text.isNotEmpty &&
          _selectedUserType != null;
    });
  }

  Widget _buildFormFields() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _userTypeSelection(),
      SizedBox(height: 16.0),
      MyTextForm(
        hintText: 'ID',
        obscureText: false,
        keyboardType: TextInputType.number,
        controller: _idController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(18),
        ],
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
      // TODO add FilteringTextInputFormatter.allow(filterPattern), to password
      //RegExp filterPattern = RegExp(r'[a-zA-Z0-9]');
      MyTextForm(
        hintText: 'Password',
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordUserController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
      SizedBox(height: 16.0),
      MyTextForm(
        hintText: 'Confirm Password',
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        controller: _confirmPasswordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please confirm your password';
          } else if (value != _passwordUserController.text) {
            return 'Passwords do not match';
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
      Row(
        children: [
          Expanded(
            child: MyTextForm(
              hintText: 'Birth Day',
              obscureText: false,
              keyboardType: TextInputType.number,
              controller: _birthDayController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
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
      _genderSelection(),
      // MyTextForm(
      //   hintText: 'gender',
      //   obscureText: false,
      //   keyboardType: TextInputType.text,
      //   controller: _genderController,
      //   validator: (value) {
      //     if (value!.isEmpty) {
      //       return 'Please enter your gender';
      //     }
      //     return null;
      //   },
      // ),
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
      MyTextForm(
        hintText: 'Telephone',
        obscureText: false,
        keyboardType: TextInputType.phone,
        controller: _telephoneController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your telephone number';
          }
          return null;
        },
      ),
      SizedBox(height: 20),
      if (_selectedUserType == 'Medcin') ...[
        MyTextForm(
          hintText: 'Speciality',
          obscureText: false,
          keyboardType: TextInputType.text,
          controller: _specialityController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your speciality';
            }
            return null;
          },
        ),
        SizedBox(height: 16.0),
        MyTextForm(
          hintText: 'Professional Phone Number',
          obscureText: false,
          keyboardType: TextInputType.phone,
          controller: _doctorProfessionalPhoneNumberController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        SizedBox(height: 16.0),
        MyTextForm(
          hintText: 'Clinic Name',
          obscureText: false,
          keyboardType: TextInputType.text,
          controller: _clinicNameController,
        ),
        SizedBox(height: 16.0),
        MyTextForm(
          hintText: 'Clinic Location',
          obscureText: false,
          keyboardType: TextInputType.text,
          controller: _clinicLocationController,
        ),
        SizedBox(height: 16.0),
        MyTextForm(
          hintText: 'Clinic Phone Number',
          obscureText: false,
          keyboardType: TextInputType.phone,
          controller: _clinicPhoneNumberController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        SizedBox(height: 16.0),
      ],
      MyButton(
        onPressed: _enableCreateButton
            ? () {
                if (_formKey.currentState!.validate()) {
                  // Check if the user already exists in the database
                  FirebaseFirestore.instance
                      .collection('users')
                      .where('IDN', isEqualTo: _idController.text)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.docs.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('User with this ID already exists.'),
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
                          _birthPlaceController.text.isEmpty ||
                          _genderController.text.isEmpty ||
                          _adresseController.text.isEmpty ||
                          _birthDayController.text.isEmpty ||
                          _birthMonthController.text.isEmpty ||
                          _birthYearController.text.isEmpty ||
                          _telephoneController.text.isEmpty ||
                          (_selectedUserType == 'Medcin' &&
                              (_specialityController.text.isEmpty ||
                                  _clinicNameController.text.isEmpty))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all fields.'),
                          ),
                        );
                        return;
                      }

                      // Convert input values to appropriate types
                      //  Check if the user already exists in database before /*DONE*/

                      String idNewUser = _idController.text.trim();
                      String passwordNewUser =
                          _passwordUserController.text.trim();
                      String familyNameNewUser =
                          _familyNameController.text.trim();
                      String nameNewUser = _nameController.text.trim();
                      String birthPlaceNewUser =
                          _birthPlaceController.text.trim();
                      String genderNewUser = _genderController.text.trim();
                      String adresseNewUser = _adresseController.text.trim();
                      int birthDayNewUser = int.parse(_birthDayController.text);
                      int birthMonthNewUser =
                          int.parse(_birthMonthController.text);
                      int birthYearNewUser =
                          int.parse(_birthYearController.text);
                      String telephoneNewUser =
                          _telephoneController.text.trim();

                      String specialityNewUser =
                          _specialityController.text.trim();
                      String clinicNameNewUser =
                          _clinicNameController.text.trim();
                      String clinicLocationNewUser =
                          _clinicLocationController.text.trim();
                      String clinicPhoneNumberNewUser =
                          _clinicPhoneNumberController.text.trim();
                      String doctorProfessionalPhoneNumberNewUser =
                          _doctorProfessionalPhoneNumberController.text.trim();

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
                        'gender': genderNewUser,
                        'adresse': adresseNewUser,
                        'telephone': telephoneNewUser,
                        'isPharmacien': newIsPharmacie,
                        'isMedcin': newIsMedcin,
                        'isAdmin': newIsAdmin,
                        'bio': '',
                        'profilePicUrl': '',
                      }).then((value) {
                        print(value.id);

                        // Check if the user is a Medcin
                        if (newIsMedcin) {
                          // If yes, add specialty and clinic name to the Medcin collection
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(value.id)
                              .update({
                            'speciality': specialityNewUser,
                            'doctorProfessionalPhoneNumber':
                                doctorProfessionalPhoneNumberNewUser,
                            'clinicName': clinicNameNewUser,
                            'clinicLocation': clinicLocationNewUser,
                            'clinicPhoneNumber': clinicPhoneNumberNewUser,
                            'digitalSignature': null,
                          }).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('User created successfully.'),
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error creating Medcin: $error'),
                              ),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('User created successfully.'),
                            ),
                          );
                        }
                        // Clear input fields after successful upload
                        _idController.clear();
                        _passwordUserController.clear();
                        _confirmPasswordController.clear();
                        _familyNameController.clear();
                        _nameController.clear();
                        _birthPlaceController.clear();
                        _genderController.clear();
                        _adresseController.clear();
                        _birthDayController.clear();
                        _birthMonthController.clear();
                        _birthYearController.clear();
                        _telephoneController.clear();
                        _specialityController.clear();
                        _clinicNameController.clear();
                        _clinicLocationController.clear();
                        _clinicPhoneNumberController.clear();
                        _doctorProfessionalPhoneNumberController.clear();

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
                  });
                }
              }
            : null,
        buttonText: 'Create User',
        ButtonColor: SihhaGreen1,
        TextButtonColor: SihhaWhite,
      ),
    ]);
  }

  DropdownButtonFormField<String> _userTypeSelection() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      itemHeight: 60,
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
      items: ['Normal', 'Medcin', 'Pharmacien', 'Admin']
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
        labelText: 'User Type',
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
      borderRadius: BorderRadius.circular(20),
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
        labelText: 'Gender',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: _buildFormFields(),
          ),
        ),
      ),
    );
  }
}
