import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyButton.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddOrdonnancePage extends StatefulWidget {
  final Patient patient;
  final User medcin;
  const AddOrdonnancePage(
      {Key? key, required this.patient, required this.medcin})
      : super(key: key);

  @override
  _AddOrdonnancePageState createState() => _AddOrdonnancePageState();
}

class _AddOrdonnancePageState extends State<AddOrdonnancePage> {
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  DateTime? _dateOfFilling;
  DateTime? _dateOfExpiry = DateTime.now().add(Duration(days: 15));
  final _formKey = GlobalKey<FormState>();
  List<MedicamentWidget> _medicamentsWidgets = [];
  List<MyTextForm> _instructionRows = []; // List for instruction rows
  List<MyTextForm> _noteRows = []; // List for note rows

  @override
  void initState() {
    super.initState();
    _addNewMedicamentRow(); // Add the initial medication row
    _addInstructionRow(_instructionRows.length + 1);
    _addNoteRow(_noteRows.length + 1);
    // Set the date of filling to the current date and time
    _dateOfFilling = DateTime.now();
  }

  void _addNewMedicamentRow() {
    setState(() {
      _medicamentsWidgets.add(
        MedicamentWidget(
          index: _medicamentsWidgets.length + 1,
        ),
      );
    });
  }

  // void _removeMedicamentRow(int index) {
  //   print("Before removal: ${_medicamentsWidgets.length}");
  //   setState(() {
  //     // Check if the index is within the bounds of _medicamentsWidgets
  //     if (index >= 0 && index < _medicamentsWidgets.length) {
  //       // Remove the row at the specified index from the _medicamentsWidgets list
  //       _medicamentsWidgets.removeAt(index);
  //       print("After removal: ${_medicamentsWidgets.length}");
  //     }
  //   });
  // }

  void _removelastMedicamentRow() {
    setState(() {
      if (_medicamentsWidgets.length > 1) _medicamentsWidgets.removeLast();
    });
  }

  // Add instruction row
  void _addInstructionRow(int index) {
    setState(() {
      _instructionRows.add(MyTextForm(
        hintText: 'Instruction $index', // Include the index in the hint text
        keyboardType: TextInputType.text,
        obscureText: false,
        controller: TextEditingController(), // Provide an empty controller
      ));
    });
  }

// Remove last instruction row
  void _removeLastInstructionRow() {
    setState(() {
      if (_instructionRows.length > 1) _instructionRows.removeLast();
    });
  }

// Add note row
  void _addNoteRow(int index) {
    setState(() {
      _noteRows.add(MyTextForm(
        hintText: 'Remarque $index',
        keyboardType: TextInputType.text,
        obscureText: false,
        controller: TextEditingController(), // Provide an empty controller
      ));
    });
  }

  // Remove last note row
  void _removeLastNoteRow() {
    setState(() {
      if (_noteRows.length > 1) _noteRows.removeLast();
    });
  }

  // Method to collect instructions from all instruction rows
  List<String> _collectInstructions() {
    List<String> instructions = [];
    for (MyTextForm instructionRow in _instructionRows) {
      if (instructionRow.controller.text.isNotEmpty) {
        instructions.add(instructionRow.controller.text);
      }
    }
    return instructions;
  }

  // Method to collect notes from all note rows
  List<String> _collectNotes() {
    List<String> notes = [];
    for (MyTextForm noteRow in _noteRows) {
      if (noteRow.controller.text.isNotEmpty) {
        notes.add(noteRow.controller.text);
      }
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Créer une ordonnance',
          style: SihhaPoppins3,
        ),
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.black54,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // DatePicker(context),

                Row(
                  children: [
                    Expanded(
                      child: MyTextForm(
                        hintText: 'Date de remplissage',
                        controller: TextEditingController(
                          text: _dateOfFilling != null
                              ? _dateOfFilling!.toString().split(' ')[0]
                              : '',
                        ),
                        keyboardType: TextInputType.datetime,
                        obscureText: false,
                        readOnly: true,
                        onTapFunction: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "La date de remplissage est automatiquement réglée sur la date et l'heure actuelles"),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(CupertinoIcons.arrow_right, size: 27),
                    SizedBox(width: 5),
                    Expanded(
                      child: MyTextForm(
                        hintText: "Date d'expiration",
                        obscureText: false,
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        controller: TextEditingController(
                          text: _dateOfExpiry != null
                              ? _dateOfExpiry!.toString().split(' ')[0]
                              : '',
                        ),
                        validator: (value) {
                          if (_dateOfExpiry == null) {
                            return 'Please select date of expiry';
                          }
                          return null;
                        },
                        onTapFunction: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text('Select Date Range'),
                                titleTextStyle: SihhaPoppins3,
                                contentPadding: EdgeInsets.all(16),
                                children: [
                                  SizedBox(
                                    height: 400, // Set a fixed height
                                    width: 400, // Set a fixed width
                                    child: SfDateRangePicker(
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      initialSelectedRange: PickerDateRange(
                                        DateTime.now(),
                                        DateTime.now().add(Duration(days: 7)),
                                      ),
                                      minDate: DateTime.now(),
                                      maxDate: DateTime(2050),
                                      showActionButtons: true,
                                      cancelText: 'Annuler',
                                      confirmText: 'Confirmer',

                                      initialSelectedDate: DateTime.now()
                                          .add(Duration(days: 15)),
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onSubmit: (p0) {
                                        setState(
                                          () {
                                            _dateOfExpiry =
                                                _dateRangePickerController
                                                    .selectedDate;
                                            print(
                                                '---------------------------------------------\n');
                                            print(
                                                'Selected Date : ${_dateOfExpiry}\n');
                                            print(
                                                'Selected Date type : ${_dateOfExpiry.runtimeType}\n');
                                            print(
                                                '---------------------------------------------\n');
                                          },
                                        );
                                        Navigator.pop(context);
                                      },
                                      controller: _dateRangePickerController,
                                      // monthCellStyle:
                                      //     DateRangePickerMonthCellStyle(textStyle: SihhaFont,),
                                      selectionColor: SihhaGreen2,
                                      selectionTextStyle: SihhaFont.copyWith(
                                          color: SihhaWhite,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                      selectionShape:
                                          DateRangePickerSelectionShape
                                              .rectangle,
                                      todayHighlightColor: Color(0xFF2C3E50),
                                      showNavigationArrow: true,
                                      allowViewNavigation: false,
                                      monthCellStyle:
                                          DateRangePickerMonthCellStyle(
                                        disabledDatesTextStyle:
                                            SihhaFont.copyWith(
                                                color: Color(0xFFCCCCCC),
                                                fontSize: 18),
                                        // leadingDatesTextStyle: SihhaFont.copyWith(
                                        //     color: SihhaWhite,
                                        //     fontWeight: FontWeight.w500,
                                        //     fontSize: 22),
                                        todayTextStyle: SihhaFont.copyWith(
                                            color: Color(0xFF2C3E50),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22),
                                        todayCellDecoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: SihhaGreen2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // color: SihhaGreen2,
                                            shape: BoxShape.rectangle),
                                        textStyle: SihhaFont.copyWith(
                                            color: Color(0xFF6C7A89),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      headerStyle: DateRangePickerHeaderStyle(
                                        textStyle: SihhaFont.copyWith(
                                            color: Color(0xFF2C3E50),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      yearCellStyle:
                                          DateRangePickerYearCellStyle(
                                        textStyle: SihhaFont.copyWith(
                                            color: Color(0xFF2C3E50),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                        disabledDatesTextStyle:
                                            SihhaFont.copyWith(
                                                color: Color(0xFFCCCCCC),
                                                fontSize: 18),
                                        todayTextStyle: SihhaFont.copyWith(
                                            color: Color(0xFF2C3E50),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22),
                                        todayCellDecoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: SihhaGreen2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: SihhaGreen2,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // Row of Medicament
                Row(
                  children: [
                    Titre("Medicaments *"),
                    Spacer(),
                    MinusButton(_removelastMedicamentRow),
                    SizedBox(
                      width: 10,
                    ),
                    PlusButton(_addNewMedicamentRow)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Show existing medication widgets
                ..._medicamentsWidgets,
                // Button to add new medication row
                // Row of Instrunctions
                Row(
                  children: [
                    Titre('Instructions'),
                    Spacer(),
                    MinusButton(
                        _removeLastInstructionRow), // Pass function reference
                    SizedBox(
                      width: 10,
                    ),
                    PlusButton(() => _addInstructionRow(
                        _instructionRows.length +
                            1)), // Pass function reference with index
                  ],
                ),
                ..._instructionRows,
                Row(
                  children: [
                    Titre('Remarques'),
                    Spacer(),
                    MinusButton(_removeLastNoteRow), // Pass function reference
                    SizedBox(
                      width: 10,
                    ),
                    PlusButton(() => _addNoteRow(_noteRows.length +
                        1)), // Pass function reference with index
                  ],
                ),
                ..._noteRows,

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width - 36
                          : 600 - 36,
                      child: MyButton(
                        ButtonColor: SihhaGreen2,
                        TextButtonColor: SihhaWhite,
                        buttonText: 'Sauvegarder',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Collect medicaments from all medication widgets
                            List<Medicament> medicaments = _medicamentsWidgets
                                .map((widget) => widget.getMedicament())
                                .toList();

                            List<String> instructions = _collectInstructions();
                            List<String> notes = _collectNotes();

                            // Create Ordonnance object with entered data
                            Ordonnance ordonnance = Ordonnance(
                              doctorIDN: widget.medcin.IDN,
                              patientIDN: widget.patient.IDN,
                              patientName: widget.patient.familyName! +
                                  ' ' +
                                  widget.patient.name!,
                              doctorName: widget.medcin.familyName! +
                                  ' ' +
                                  widget.medcin.name!,
                              clinicName: widget.medcin.clinicName,
                              doctorSpeciality: widget.medcin.speciality,
                              dateOfFilling:
                                  Timestamp.fromDate(_dateOfFilling!),
                              dateOfExpiry: Timestamp.fromDate(_dateOfExpiry!),
                              medicaments:
                                  medicaments, // Add collected medicaments
                              instructions: instructions,
                              notes: notes,
                              clinicLocation: widget.medcin.clinicLocation,
                              clinicPhoneNumber:
                                  widget.medcin.clinicPhoneNumber,
                              doctorDigitalSignature:
                                  widget.medcin.digitalSignature,
                              doctorProfessionalPhoneNumber:
                                  widget.medcin.doctorProfessionalPhoneNumber,
                            );

                            // Upload ordonnance data to Firestore
                            FirebaseFirestore.instance
                                .collection('ordonnances')
                                .add(ordonnance.toFirestore())
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Ordonnance added successfully.'),
                                ),
                              );

                              // Clear text fields after successful upload

                              _instructionsController.clear();
                              _notesController.clear();
                              setState(
                                () {
                                  _dateOfExpiry = null;
                                  _medicamentsWidgets
                                      .clear(); // Clear medication widgets
                                  _addNewMedicamentRow(); // Add a new medication row
                                  _instructionRows.clear();
                                  _addInstructionRow(
                                      _instructionRows.length + 1);
                                  _noteRows.clear();
                                  _addNoteRow(_noteRows.length + 1);
                                },
                              );
                              Navigator.pop(context);
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Error adding ordonnance: $error'),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector DatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text('Select Date Range'),
              titleTextStyle: SihhaPoppins3,
              contentPadding: EdgeInsets.all(16),
              children: [
                SizedBox(
                  height: 400, // Set a fixed height
                  width: 400, // Set a fixed width
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialSelectedRange: PickerDateRange(
                      DateTime.now(),
                      DateTime.now().add(Duration(days: 7)),
                    ),
                    minDate: DateTime.now(),
                    maxDate: DateTime(2050),
                    showActionButtons: true,
                    cancelText: 'Annuler',
                    confirmText: 'Confirmer',

                    initialSelectedDate: DateTime.now().add(Duration(days: 15)),
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSubmit: (p0) {
                      setState(
                        () {
                          _dateOfExpiry =
                              _dateRangePickerController.selectedDate;
                          print(
                              '---------------------------------------------\n');
                          print('Selected Date : ${_dateOfExpiry}\n');
                          print(
                              'Selected Date type : ${_dateOfExpiry.runtimeType}\n');
                          print(
                              '---------------------------------------------\n');
                        },
                      );
                      Navigator.pop(context);
                    },
                    controller: _dateRangePickerController,
                    // monthCellStyle:
                    //     DateRangePickerMonthCellStyle(textStyle: SihhaFont,),
                    selectionColor: SihhaGreen2,
                    selectionTextStyle: SihhaFont.copyWith(
                        color: SihhaWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    todayHighlightColor: Color(0xFF2C3E50),
                    showNavigationArrow: true,
                    allowViewNavigation: false,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      disabledDatesTextStyle: SihhaFont.copyWith(
                          color: Color(0xFFCCCCCC), fontSize: 18),
                      // leadingDatesTextStyle: SihhaFont.copyWith(
                      //     color: SihhaWhite,
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 22),
                      todayTextStyle: SihhaFont.copyWith(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                      todayCellDecoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: SihhaGreen2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          // color: SihhaGreen2,
                          shape: BoxShape.rectangle),
                      textStyle: SihhaFont.copyWith(
                          color: Color(0xFF6C7A89),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    headerStyle: DateRangePickerHeaderStyle(
                      textStyle: SihhaFont.copyWith(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: SihhaFont.copyWith(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      disabledDatesTextStyle: SihhaFont.copyWith(
                          color: Color(0xFFCCCCCC), fontSize: 18),
                      todayTextStyle: SihhaFont.copyWith(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                      todayCellDecoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: SihhaGreen2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        // color: SihhaGreen2,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 50,
        color: Colors.black,
        child: Center(
          child: Text(
            'Select Date',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  InkWell PlusButton(VoidCallback onTapFunction) {
    return InkWell(
      onTap: onTapFunction,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: SihhaGreen2.withOpacity(0.8),
          ),
          width: 30,
          height: 30,
          child: Center(
            child: Icon(
              CupertinoIcons.add,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }

  InkWell MinusButton(VoidCallback onTapFunction) {
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      onTap: onTapFunction,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red.withOpacity(0.8),
          ),
          width: 30,
          height: 30,
          child: Center(
            child: Icon(
              CupertinoIcons.minus,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class MedicamentWidget extends StatelessWidget {
  final int index;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _pictureUrlController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final void Function(int)? onRemove;
  MedicamentWidget({required this.index, this.onRemove});

  Medicament getMedicament() {
    return Medicament(
      name: _nameController.text,
      type: _typeController.text,
      pictureUrl: _pictureUrlController.text,
      dosage: _dosageController.text,
      frequencyPerDay: int.tryParse(_frequencyController.text) ?? 0,
      duration: int.tryParse(_durationController.text) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // InkWell(
            //   onTap: () {
            //     onRemove(index);
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         color: Colors.red.withOpacity(0.8)),
            //     width: 40,
            //     height: 40,
            //     child: Center(
            //         child: Icon(
            //       CupertinoIcons.minus,
            //       color: Colors.white,
            //     )),
            //   ),
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: SihhaGreen2.withOpacity(0.8)),
              width: 40,
              height: 40,
              child: Center(
                child: Text(
                  '$index',
                  style:
                      SihhaPoppins3.copyWith(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: MyTextForm(
                hintText: 'Nom du médicament *',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le nom du médicament';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: MyTextForm(
                hintText: 'Type',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _typeController,
              ),
            ),
            // MyTextForm(
            //   hintText: 'Picture URL',
            //   obscureText: false,
            //   keyboardType: TextInputType.text,
            //   controller: _pictureUrlController,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter medicament picture URL';
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: MyTextForm(
                hintText: 'Dosage',
                obscureText: false,
                keyboardType: TextInputType.text,
                controller: _dosageController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: MyTextForm(
                hintText: 'fréquence par jour',
                obscureText: false,
                keyboardType: TextInputType.number,
                controller: _frequencyController,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: MyTextForm(
                hintText: 'Durée',
                obscureText: false,
                keyboardType: TextInputType.number,
                controller: _durationController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

Padding Titre(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    child: Text(text, style: SihhaPoppins3),
  );
}
