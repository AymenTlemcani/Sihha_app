import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/Models/Variables.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminDashboard> createState() => _HomeBodyDesktopState();
}

class _HomeBodyDesktopState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  final List<Widget> _Adminscreens = [];
  late TabController _tabController;
  //******************************************************************************************** */
  //********************** CREATE USER *************************************************************/
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

  /************************************************************************************************** */
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
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
    _tabController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            print(user!.documentId);
            print(user!.adresse);
            print(user!.isPharmacie);

            // print(user!.ordonnances![0].medicaments![0].name);
            // print(user!.speciality);
            // print(patients?.length);
            // print(patients?[0].familyName ?? '');
            // patients?.clear();
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        title: TabBar(
          controller: _tabController,
          labelStyle: SihhaFont.copyWith(
              fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1.1),
          tabs: const [
            Tab(text: 'Statistiques'),
            Tab(text: 'Créer un compte'),
            Tab(text: 'Modifier un compte'),
            Tab(text: 'Demandes Carte Sihha'),
          ],
          labelColor: Colors.black,
          unselectedLabelStyle:
              SihhaFont.copyWith(fontSize: 15.5, fontWeight: FontWeight.w100),
          unselectedLabelColor: Color(0xFFb0b3b8),
          indicatorColor: SihhaGreen1,
          indicatorSize: TabBarIndicatorSize.label,
          splashFactory: NoSplash.splashFactory,
          enableFeedback: true,
          overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
        ),

        // bottom:
        // TabBar(
        //   controller: _tabController,
        //   labelStyle: SihhaFont.copyWith(
        //       fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1.1),
        //   tabs: const [
        //     Tab(text: 'Statistiques'),
        //     Tab(text: 'Créer un compte'),
        //     Tab(text: 'Modifier un compte'),
        //     Tab(text: 'Demandes Carte Sihha'),
        //   ],
        //   labelColor: Colors.black,
        //   unselectedLabelStyle:
        //       SihhaFont.copyWith(fontSize: 15.5, fontWeight: FontWeight.w100),
        //   unselectedLabelColor: Color(0xFFb0b3b8),
        //   indicatorColor: SihhaGreen1,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   splashFactory: NoSplash.splashFactory,
        //   enableFeedback: true,
        //   overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
        // ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'StatistiquePage.dart /*NOT DONE*/',
                style: SihhaPoppins3,
              ),
            ),
          ),
          CreateUser(),
          Container(),
          Container(),
        ],
      ),
    );
  }

  Widget CreateUser() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.greenAccent,
                  child: Column(children: [
                    SizedBox(width: 225, child: _userTypeSelection()),
                    MyTextForm(
                      hintText: 'ID',
                      width: 225,
                      obscureText: false,
                      controller: _idController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18),
                      ],
                      validator: (value) {
                        if (_enableCreateButton) {
                          if (value!.isEmpty) {
                            return 'Please enter your ID';
                          } else if (value.length != 18) {
                            return 'ID should be 18 digits';
                          }
                        }
                        return null;
                      },
                    ),
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
                  ]),
                ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [

// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Statistiques',
//       selectedIcon: CupertinoIcons.chart_bar_square_fill,
//       unselectedIcon: CupertinoIcons.chart_bar_square,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Créer un compte',
//       selectedIcon: CupertinoIcons.person_add_solid,
//       unselectedIcon: CupertinoIcons.person_add,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Modifier un compte',
//       selectedIcon: CupertinoIcons.pencil_circle_fill,
//       unselectedIcon: CupertinoIcons.pencil_circle,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Demandes Carte Sihha',
//       selectedIcon: CupertinoIcons.creditcard_fill,
//       unselectedIcon: CupertinoIcons.creditcard_fill,
//       onTap: () {},
//     ),
//   ),
// ),
//   ],
// ),
