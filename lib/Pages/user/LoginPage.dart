import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/utils/Variables.dart';
import 'package:sahha_app/CommonWidgets/MyButton.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
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
  bool _isLoading = false; // New variable to track loading state

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

//no need for this method we already have it in LoginControllerProvider.dart this is just the old version  of it before using Provider
  // void login() async {
  //   String inputPassword = _passwordController.text.trim();
  //   Map<String, dynamic>? documentData;

  //   try {
  //     var allDocs = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('IDN', isEqualTo: _idController.text.trim())
  //         .where('password', isEqualTo: _passwordController.text.trim())
  //         .get();
  //     documentData = allDocs.docs.first.data();
  //     if (inputPassword == documentData['password']) {
  //       IDN = documentData['IDN'];
  //       familyName = documentData['familyName'];
  //       name = documentData['name'];
  //       sexe = documentData['sexe'];
  //       birthDay = documentData['birthDay'];
  //       birthMonth = documentData['birthMonth'];
  //       birthYear = documentData['birthYear'];
  //       birthPlace = documentData['birthPlace'];
  //       isLoggedIN = true;
  //       isAdmin = documentData['admin'];
  //       isMedcin = documentData['medcin'];
  //       isPharmacie = documentData['pharmacien'];
  //       Provider.of<LoginControllerProvider>(context, listen: false)
  //           .loginStreamController
  //           .add(isLoggedIN);
  //     } else {
  //       // Incorrect password
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Incorrect password. Please try again.'),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   } on Error catch (e) {
  //     print('Error during login: $e');
  //   }
  //   print('Is logged in : $isLoggedIN');
  //   print('Document data: $documentData');
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    //TODO:we need to make the back button disspears when the user enter the app for 2nd time
                    BackButtonRow(),
                    //TODO: we need to add language  selection here
                    LogoAndLanguageSelectorRow(),
                    SizedBox(height: 20),
                    WelcomeRow(),
                    SizedBox(height: 5),
                    PleaseFillYourInfosRow(),
                  ],
                ),
              ),
              SizedBox(height: 20),
// CupSlideControl(),
              // SizedBox(height: 20),

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
                          IDtextForm(),
                          passwordTextForm(context),
                        ],
                      ),
                    ),
                    // Forgot password link
                    forgotPassord(),
                    SizedBox(height: 30),

                    // Login button with loading indicator
                    SeConnecterButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row BackButtonRow() {
    return Row(
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
            ),
          ),
        ),
      ],
    );
  }

  Row LogoAndLanguageSelectorRow() {
    return Row(
      children: [
        Transform.translate(
          offset: Offset(15, 10),
          child: SvgPicture.asset(
            "assets/svg-cropped.svg",
            height: 70,
          ),
        ),
      ],
    );
  }

  Row WelcomeRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Text(
            "Bienvenu !",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Row PleaseFillYourInfosRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Text(
            "Veuillez remplir vos informations",
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }

// TODO : add id history to show the id next time the user signs in again
  MyTextForm IDtextForm() {
    return MyTextForm(
      controller: _idController,
      hintText: "Numéro de Carte National",
      obscureText: false,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(18),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer votre numéro de carte national';
        }
        return null;
      },
    );
  }

  Padding passwordTextForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: Container(
        width: MediaQuery.of(context).size.width < 600
            ? MediaQuery.of(context).size.width - 36
            : 600 - 36,
        child: TextFormField(
          onChanged: (_) {
            // Clear password error message when text changes
            setState(() {
              // Trigger validation process when text changes
              _formKey.currentState!.validate();
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez entrer votre mot de passe';
            }
            return null;
          },
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: _isObsecure,
          cursorColor: SihhaGreen1,
          decoration: InputDecoration(
            labelText: "Mot de passe",
            labelStyle: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            floatingLabelStyle: GoogleFonts.poppins(
              color: SihhaGreen3,
            ),
            suffixIcon: IconButton(
              icon: _isObsecure
                  ? Icon(
                      Icons.visibility_off_outlined,
                      color: Color.fromARGB(45, 0, 0, 0),
                      size: 15,
                    )
                  : Icon(
                      Icons.visibility_outlined,
                      color: Color.fromARGB(45, 0, 0, 0),
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
                color: Colors.grey,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromARGB(20, 82, 79, 79),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: SihhaGreen1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row forgotPassord() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
            ),
          ),
        ),
      ],
    );
  }

  MyButton SeConnecterButton(BuildContext context) {
    return MyButton(
      onPressed: _isLoading
          ? null
          : () async {
              // Start loading
              setState(() {
                _isLoading = true;
              });

              // Validate the form fields individually
              bool idIsValid = _idController.text.isNotEmpty;
              bool passwordIsValid = _passwordController.text.isNotEmpty;

              if (idIsValid && passwordIsValid) {
                // Call the login method from the provider
                String? loginResult =
                    await Provider.of<LoginControllerProvider>(
                  context,
                  listen: false,
                ).login(
                  _idController.text,
                  _passwordController.text,
                  context,
                );

                if (loginResult == null) {
                  // Login success
                  setState(() {
                    _isLoading = false;
                  });
                } else {
                  // Login failed
                  setState(() {
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loginResult),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              } else {
                // Stop loading and show error message
                setState(() {
                  _isLoading = false;
                });

                // Check which fields are empty and show respective error messages
                if (!idIsValid && !passwordIsValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez remplir tous les champs.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else if (!idIsValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Veuillez entrer votre numéro de carte national.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez entrer votre mot de passe.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
      buttonText: "Se connecter",
      ButtonColor: SihhaGreen2,
      TextButtonColor: HexColor("f8f8f8"),
      isLoading: _isLoading, // Pass the loading state
      childB: _isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : null, // Show progress indicator when loading
    );
  }
}
