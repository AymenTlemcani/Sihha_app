import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Common/MyButton.dart';
import 'package:sahha_app/Common/MyTextForm.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO:
  //  National Id Validator W Password Validator w Password Hashing with Bcrypt
  //  n7i les commentaires zyada
  //  Add Biometrics login
  //  Add Create user page in admin dashboard

  // late final StreamController<bool> loginStreamController;
  late bool _isObsecure;
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  // @override
  // void initState() {
  //   super.initState();
  //   _isObsecure = true;
  //   _idController = TextEditingController();
  //   _passwordController = TextEditingController();
  //   _formKey = GlobalKey<FormState>();
  //   _loginStreamController =
  //       Provider.of<LoginControllerProvider>(context, listen: false)
  //           .loginStreamController;
  // }
  @override
  void initState() {
    super.initState();
    _isObsecure = true;
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String inputPassword = _passwordController.text.trim();
    Map<String, dynamic>? documentData;

    try {
      var allDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: _idController.text.trim())
          .where('password', isEqualTo: _passwordController.text.trim())
          .get();
      documentData = allDocs.docs.first.data();
      if (inputPassword == documentData['password']) {
        IDN = documentData['IDN'];
        familyName = documentData['familyName'];
        name = documentData['name'];
        sexe = documentData['sexe'];
        birthDay = documentData['birthDay'];
        birthMonth = documentData['birthMonth'];
        birthYear = documentData['birthYear'];
        birthPlace = documentData['birthPlace'];
        isLoggedIN = true;
        isAdmin = documentData['admin'];
        isMedcin = documentData['medcin'];
        isPharmacie = documentData['pharmacien'];
        Provider.of<LoginControllerProvider>(context, listen: false)
            .loginStreamController
            .add(isLoggedIN);
      } else {
        // Incorrect password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect password. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on Error catch (e) {
      print('Error during login: $e');
    }
    print('Is logged in : $isLoggedIN');
    print('Document data: $documentData');
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
                      key: _formKey,
                      child: Column(
                        children: [
                          MyTextForm(
                            controller: _idController,
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

                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObsecure,
                                cursorColor: SihhaGreen1,
                                // textAlign: TextAlign.justify,

                                decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14),
                                    floatingLabelStyle:
                                        TextStyle(color: SihhaGreen3),
                                    suffixIcon: IconButton(
                                      icon: _isObsecure
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
                                          _isObsecure = !_isObsecure;
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
                      Provider.of<LoginControllerProvider>(context,
                              listen: false)
                          .login(_idController.text, _passwordController.text,
                              context);
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
