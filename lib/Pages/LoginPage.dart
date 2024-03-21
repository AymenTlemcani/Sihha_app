import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Common/MyButton.dart';
import 'package:sahha_app/Common/MyTextForm.dart';

class LoginPage extends StatefulWidget {
  final StreamController<bool> loginStreamController;
  const LoginPage({super.key, required this.loginStreamController});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO:
  //  National Id Validator W Password Validator w Password Hashing with Bcrypt
  //  n7i les commentaires zyada
  //  Add Biometrics login
  //  Add Create user page in admin dashboard

  bool _IsObsecure = true;

  //Auth controllers
  // final EmailController = TextEditingController();
  final IdController = TextEditingController();
  final PasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  // LOGIN WITH NATIONAL ID SECTION
  /// NJIBO LES DOCUMENTS W NDIROHOM F DATA
  List<QueryDocumentSnapshot>? data = [];
  var collection = FirebaseFirestore.instance.collection('users');

  void login(StreamController<bool> loginStreamController) async {
    String inputPassword = PasswordController.text.trim();
    try {
      var allDocs = await collection
          .where('IDN', isEqualTo: IdController.text.trim())
          .where('password', isEqualTo: PasswordController.text.trim())
          .get();
      // var DocumentID = allDocs.docs.first.id;
      var DocumentDATA = allDocs.docs.first.data();

      if (inputPassword == DocumentDATA['password']) {
        setState(() {
          IDN = DocumentDATA['IDN'];
          familyName = DocumentDATA['familyName'];
          name = DocumentDATA['name'];
          sexe = DocumentDATA['sexe'];
          birthDay = DocumentDATA['birthDay'];
          birthMonth = DocumentDATA['birthMonth'];
          birthYear = DocumentDATA['birthYear'];
          birthPlace = DocumentDATA['birthPlace'];

          ///
          isLoggedIN = true;
          isAdmin = DocumentDATA['admin'];

          isMedcin = DocumentDATA['medcin'];
          isPharmacie = DocumentDATA['pharmacien'];
        });
        loginStreamController.add(isLoggedIN);
      } else {
        DocumentDATA = {};

        ///wrong password
      }

      print('Is logged in : ' + isLoggedIN.toString());
      print(DocumentDATA);
      // print(inputPassword);
      // print(DocumentDATA['name']);
      // print(dateDeNaissance);
    } on Error catch (e) {
      print(e);
    }

    ///version 9dima
    // QuerySnapshot querySnapshot = await collection
    //     .where('IDN', isEqualTo: IdController.text.trim())
    //     .get();
    // data?.addAll(querySnapshot.docs);
    // setState(() {});
    // print(data?.length);
    // var infos = data?[0].data() as Map<String, dynamic>;
    // print(infos['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // backgroundColor: CupertinoColors.darkBackgroundGray,
      // backgroundColor: CupertinoColors.extraLightBackgroundGray,
      // backgroundColor: Color.fromARGB(255, 245, 245, 245),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        reverse: true,
        // physics: NeverScrollableScrollPhysics(),
        //Ta3 APP COMPLET
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      // image: AssetImage("assets/background1.png"),
                      image: AssetImage("assets/back3.png"),
                      fit: BoxFit.fill)),
              child: Column(children: [
                //Row of the picture
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: IconButton(
                          onPressed: () {},
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: 18,
                          )),
                    ),
                  ],
                ),

                // 2nd row fih logo and language selector
                Row(
                  children: [
                    Transform.translate(
                        offset: Offset(15, 10),
                        child: SvgPicture.asset(
                          "assets/svg-cropped.svg",
                          height: 70,
                        )),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text(
                        "Bienvenu !",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text("Veuillez remplir vos informations",
                          style: GoogleFonts.poppins(
                              fontSize: 17, color: Colors.black26)),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 20),
            // CupSlideControl(),
            SizedBox(height: 20),

            /// IntrinsicWidth  is used to make the column take up only as much width as it needs.
            /// Bach App twli responsive f Web ki tkabar w tsaghar L window
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          MyTextForm(
                            controller: IdController,
                            hintText: "Numéro de Carte National",
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                          ),

                          ///////////PASSWORD
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width < 600
                                  ? MediaQuery.sizeOf(context).width - 36
                                  : 600 - 36,
                              child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'This field cannot be empty'
                                    : null,

                                controller: PasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _IsObsecure,
                                cursorColor: SihhaGreen1,
                                // textAlign: TextAlign.justify,

                                decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14),
                                    floatingLabelStyle:
                                        TextStyle(color: SihhaGreen3),
                                    suffixIcon: IconButton(
                                      icon: _IsObsecure
                                          ? Icon(
                                              Icons.visibility_off_outlined,
                                              color:
                                                  Color.fromARGB(45, 0, 0, 0),
                                              size: 15,
                                            )
                                          : Icon(
                                              Icons.visibility_outlined,
                                              color:
                                                  Color.fromARGB(45, 0, 0, 0),
                                              size: 15,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          _IsObsecure = !_IsObsecure;
                                        });
                                      },
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(20, 82, 79, 79),
                                            width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: SihhaGreen1)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                              ),
                            ),
                          ),
                        ],
                      )),
                  // SizedBox(height: 15),
                  ///////////     FORGOT PASSWORD?
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Mot de passe oublié ?",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.lightBlue[300],
                              letterSpacing: 0,
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.5,
                            ),
                          )),
                    ),

                    ///
                  ]),
                  SizedBox(height: 40),
                  MyButton(
                    onPressed: () {
                      login(widget.loginStreamController);
                    },
                    //signUserIn,
                    buttonText: "Se connecter",
                    ButtonColor: SihhaGreen2,
                    TextButtonColor: HexColor("f8f8f8"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
