import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/utils/Variables.dart';
import 'package:sahha_app/utils/Patient.dart';

class PatientPage extends StatefulWidget {
  final Patient? patient;

  const PatientPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        setState(() {
          isScanned = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          leading: MyBackButton(
            onTapFunction: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeScannerPage(),
                ),
              );
            },
          ),
          title: Text(
            widget.patient?.name ?? 'Patient Information',
            style: SihhaPoppins3,
          ),
        ),
        body: widget.patient == null
            ? Center(child: Text('No patient data'))
            : LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    // For larger screens (e.g., tablets, desktops)
                    return _buildLargeScreen();
                  } else {
                    // For smaller screens (e.g., phones)
                    return _buildSmallScreen();
                  }
                },
              ),
      ),
    );
  }

  Widget _buildLargeScreen() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: widget.patient!.profilePicUrl != null
                    ? NetworkImage(widget.patient!.profilePicUrl!)
                    : null,
                child: widget.patient!.profilePicUrl == null
                    ? Icon(Icons.person, size: 100)
                    : null,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPatientInfo(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RefreshIndicator(
        onRefresh: _refreshPatientData,
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildCircleAvatar(),
              ),
            ),
            SizedBox(height: 16),
            _buildPatientInfo(),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshPatientData() async {
    // Simulate a delay to mimic data fetching
    await Future.delayed(Duration(seconds: 2));

    // Perform any necessary operations to refresh the patient data
    // For example, you can re-fetch the data from Firestore or update the UI

    // After refreshing the data, you can update the UI if needed
    setState(() {});
  }

  Widget _buildCircleAvatar() {
    return CircleAvatar(
      radius: 80,
      backgroundImage: widget.patient!.profilePicUrl != null
          ? NetworkImage(widget.patient!.profilePicUrl!)
          : null,
      child: widget.patient!.profilePicUrl == null
          ? Icon(Icons.person, size: 80)
          : null,
    );
  }

  Widget _buildPatientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '${widget.patient!.name} ${widget.patient!.familyName}',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Gender',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.gender ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Birth Date',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '${widget.patient!.birthDay}/${widget.patient!.birthMonth}/${widget.patient!.birthYear}',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Birth Place',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.birthPlace ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Phone Number',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.telephone ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Bio',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.bio ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }
}
