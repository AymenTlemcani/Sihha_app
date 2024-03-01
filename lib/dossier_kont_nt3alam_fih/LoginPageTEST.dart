import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Common/my_button.dart';
import 'package:sahha_app/Common/slideControl.dart';
import 'package:sahha_app/Common/textForm.dart';

class LoginPageTEST extends StatefulWidget {
  const LoginPageTEST({super.key});

  @override
  State<LoginPageTEST> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageTEST> {
  bool _IsObsecure = true;

  List<bool> isSelected = [true, false];
  //Auth controllers
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  //sign user in
  bool isSignIN = false;
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   EmailController.dispose();
  //   PasswordController.dispose();
  //   super.dispose();
  // }

  void signUserIn() async {
    /// SHOW A LOADING CIRCLE

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );
    // ignore: unused_local_variable
    // Map credentials = {
    //   'email': EmailController.text.trim(),
    //   'password': PasswordController.text.trim(),
    //   'device_name': 'Mobile'
    // };
    // if (_formkey.currentState!.validate()) {
    //   print("oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    // }
    setState(() {
      isSignIN = true;
    });

    /// TRY  TO LOGIN USER WITH EMAIL AND PASSWORD
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailController.text.trim(),
          password: PasswordController.text.trim());
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);

      if (e.code == 'network-request-failed') {}
      if (e.code == 'channel-error') {}
      if (e.code == 'invalid-email') {}
      if (e.code == 'invalid-credential') {}
      if (e.code == 'too-many-requests') {}
      // Navigator.pop(context);
      // print('Error : ${e.code}');

      // if (e.code == 'user-not-found') {
      //   wrongEmailPopUP();
      // } else if (e.code == "wrong-password") {
      //   wrongPasswordPopUP();
      // }
    }
    setState(() {
      isSignIN = false;
    });

    // Navigator.pop(context);
  }

  void showErrorMessage(String message) {
    // Tampilkan dialog dengan pesan error
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void wrongEmailPopUP() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('incorrect Email'));
        });
  }

  void wrongPasswordPopUP() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('incorrect password'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        reverse: true,
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage("assets/background1.png"),
                      fit: BoxFit.cover)),
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
                        "Welcome Back Again",
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
                      child: Text("Please fill your information",
                          style: GoogleFonts.poppins(
                              fontSize: 17, color: Colors.black26)),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 20),
            /////////// National ID TEXT FORM
            /*ToggleButtons(
              children: [Text("Adult"), Text("Mineur")],
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
            ),*/

            // LiteRollingSwitch(
            //   value: false,
            //   textOn: "On",
            //   textOff: "Off",
            //   colorOn: Colors.green,
            //   colorOff: Colors.red,
            //   iconOn: Icons.done,
            //   iconOff: Icons.clear,
            //   textSize: 18,
            //   animationDuration: Duration(milliseconds: 20),
            //   width: 100,
            //   onTap: () {},
            //   onChanged: (p0) {},
            //   onDoubleTap: () {},
            //   onSwipe: () {},
            // ),
            // CupertinoButton(child: Text("hhhh"), onPressed: () {}),

            CupSlideControl(),
            SizedBox(height: 20),

            ///        AUTH FORM
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    MyTextForm(
                      controller: EmailController,
                      hintText: "Email",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    ///////////PASSWORD
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                      child: TextFormField(
                        validator: (value) => value!.isEmpty
                            ? 'This field cannot be empty'
                            : null,

                        controller: PasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _IsObsecure,
                        cursorColor: Color(0xFF6DCEA1),
                        // textAlign: TextAlign.justify,

                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 14),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 49, 143, 99)),
                            suffixIcon: IconButton(
                              icon: _IsObsecure
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
                                  _IsObsecure = !_IsObsecure;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(20, 82, 79, 79),
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Color(0xFF6DCEA1))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ],
                )),
            // SizedBox(height: 15),
            ///////////     FORGOT PASSWORD?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "NSIT L MODPASS YA KHO?",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.lightBlue[300],
                          letterSpacing: 0,
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.5,
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 40),

            MyButton(
              onPressed: signUserIn,
              buttonText: "Login",
              ButtonColor: HexColor("509776"),
              TextButtonColor: HexColor("f8f8f8"),
            ),
          ],
        ),
      ),
    );
  }
}
