import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';

class DossierMedical extends StatefulWidget {
  const DossierMedical({super.key});

  @override
  State<DossierMedical> createState() => _DossierMedicalState();
}

class _DossierMedicalState extends State<DossierMedical> {
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: Text(
          'Dossier Medical',
          style: SihhaPoppins3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    CupertinoIcons.share,
                    color: SihhaGreen2,
                    size: 27,
                  ),
                )),
          )
        ],
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [SliverToBoxAdapter()],
            ),
    );
  }
}
