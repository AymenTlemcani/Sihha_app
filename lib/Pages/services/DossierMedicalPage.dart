import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyDetailCard.dart';
import 'package:sahha_app/CommonWidgets/MyDetailListView.dart';
import 'package:sahha_app/CommonWidgets/MySearchTextField.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Allergie.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disability.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disease.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Habit.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Models/examples.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DossierMedicalPage extends StatefulWidget {
  const DossierMedicalPage({super.key});

  @override
  State<DossierMedicalPage> createState() => _DossierMedicalPageState();
}

class _DossierMedicalPageState extends State<DossierMedicalPage> {
  bool _isLoading = false;
  bool _isEditMode = false;

  // Define TextEditingController and DateTime variables
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  String? _selectedRh;
  Map<String, dynamic>? _selectedSuggestion;
  DateTime? _dateOfStart;
  late DateRangePickerController _dateRangePickerController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _dateRangePickerController = DateRangePickerController();

    _isLoading = true;
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void onSave2(Map<String, dynamic> selectedData, String collection) async {
    selectedData['patientId'] = globalUser!.documentId;
    selectedData['date'] = Timestamp.fromDate(DateTime.now());
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(globalUser!.documentId)
          .set(selectedData, SetOptions(merge: true));
      print('$collection uploaded successfully');
    } catch (e) {
      print('Error uploading $collection: $e');
    }
  }

  void onSave(Disease selectedDisease) async {
    // Do something with the selected disease, such as saving it to a database
    // For demonstration, you can print the selected disease
    print('Selected Disease: $selectedDisease');

    // Add dateOfStart and patientId to the selectedDisease
    selectedDisease.dateOfStart = Timestamp.fromDate(_dateOfStart!);
    selectedDisease.patientId = globalUser!.documentId;

    // Convert the Disease object to a map
    Map<String, dynamic> diseaseData = selectedDisease.toMap();

    try {
      // Upload the disease data to the "maladies" collection
      await FirebaseFirestore.instance.collection('maladies').add(diseaseData);
      print('Disease uploaded successfully');
    } catch (e) {
      print('Error uploading disease: $e');
    }
  }

  void onSaveAllergie(Allergie selectedAllegrie) async {
    // Do something with the selected disease, such as saving it to a database
    // For demonstration, you can print the selected disease
    print('Selected Allergie: $selectedAllegrie');

    // Add dateOfStart and patientId to the selectedDisease
    selectedAllegrie.dateOfStart = Timestamp.fromDate(_dateOfStart!);
    selectedAllegrie.patientId = globalUser!.documentId;

    // Convert the allergies object to a map
    Map<String, dynamic> allergieData = selectedAllegrie.toMap();

    try {
      // Upload the disease data to the "maladies" collection
      await FirebaseFirestore.instance
          .collection('allergies')
          .add(allergieData);
      print('allergie uploaded successfully');
    } catch (e) {
      print('Error uploading allergie: $e');
    }
  }

  void onSaveDisability(Disability selectedDisability) async {
    // Do something with the selected disease, such as saving it to a database
    // For demonstration, you can print the selected disease
    print('Selected Allergie: $selectedDisability');

    // Add dateOfStart and patientId to the selectedDisease
    selectedDisability.dateOfStart = Timestamp.fromDate(_dateOfStart!);
    selectedDisability.patientId = globalUser!.documentId;

    // Convert the allergies object to a map
    Map<String, dynamic> allergieData = selectedDisability.toMap();

    try {
      // Upload the disease data to the "maladies" collection
      await FirebaseFirestore.instance
          .collection('disabilities')
          .add(allergieData);
      print('disabilitie uploaded successfully');
    } catch (e) {
      print('Error uploading disabilitie: $e');
    }
  }

  void onSaveHabit(Habit selectedHabit) async {
    print('Selected Habit: $selectedHabit');

    // Add dateOfStart and patientId to the selectedDisease
    // selectedHabit.dateOfStart = Timestamp.fromDate(_dateOfStart!);
    selectedHabit.patientId = globalUser!.documentId;

    // Convert the allergies object to a map
    Map<String, dynamic> habitData = selectedHabit.toMap();

    try {
      // Upload the disease data to the "maladies" collection
      await FirebaseFirestore.instance.collection('habits').add(habitData);
      print('habitData uploaded successfully');
    } catch (e) {
      print('Error uploading habitData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print(globalUser!.diseases);
          // Disease newDisease = Disease(
          //   dateOfStart: Timestamp.fromDate(DateTime.now()),
          //   name: 'Maladie 1',
          //   description: 'Test bach nchof UI ta3 Les maladie Chronique',
          //   level: 'Niveau 2',
          //   type: 'chronique',
          //   patientId: globalUser!.documentId,
          // );
          // Habit habit = Habit(
          //     name: 'Smoking',
          //     duration: 'Longue',
          //     intensity: 'moyen',
          //     frequency: 'Toujours',
          //     patientId: globalUser!.documentId);
          // Height height = Height(
          //     height: 198,
          //     date: Timestamp.fromDate(DateTime.now()),
          //     patientId: globalUser!.documentId);
          // Weight weight = Weight(
          //     weight: 68,
          //     date: Timestamp.fromDate(DateTime.now()),
          //     patientId: globalUser!.documentId);
          // Map<String, dynamic> disMap = weight.toMap();
          // await FirebaseFirestore.instance
          //     .collection('weights')
          //     .doc(globalUser!.documentId)
          //     .set(disMap, SetOptions(merge: true));
          // print(globalUser!.weights!.last.weight);

          // print(_selectedSuggestion);
          print('done');
        },
      ),
      appBar: AppBar(
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dossier Medical',
          style: SihhaPoppins3,
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(30),
          //     onTap: () {},
          //     child: Padding(
          //       padding: const EdgeInsets.all(6.0),
          //       child: Icon(
          //         CupertinoIcons.share,
          //         color: SihhaGreen2,
          //         size: 27,
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                await globalUser!.fetchAllergies();
                await globalUser!.fetchDisabilities();
                await globalUser!.fetchDiseases();
                await globalUser!.fetchHabits();
                await globalUser!.fetchHeights();
                await globalUser!.fetchWeights();
                await globalUser!.fetchBloodTypes();

                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  CupertinoIcons.refresh_bold,
                  color: SihhaGreen2,
                  size: 27,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Activate edit mode
              setState(() {
                _isEditMode = true;
              });
            },
          ),
        ],
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: SihhaGreen1,
              strokeWidth: 4,
            ))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 130,
                        child: Row(
                          children: [
                            //Height
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _heightController.text =
                                      globalUser!.heights!.isEmpty
                                          ? ''
                                          : globalUser!.heights!.last.height!
                                              .toString();
                                  showSmallEditPopup(
                                    MyTextForm(
                                      hintText: 'Taille (cm)',
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    // TextField(
                                    //   controller: _heightController,
                                    //   decoration: InputDecoration(
                                    //       labelText: 'Taille (cm)'),
                                    //   keyboardType: TextInputType.number,
                                    // ),
                                    (selectedData) =>
                                        onSave2(selectedData, 'heights'),
                                  );
                                },
                                child: MyDetailCard(
                                  title: 'Taille',
                                  leadingIcon: LineAwesomeIcons.ruler,
                                  lastUpdated: globalUser!.heights!.isEmpty ||
                                          globalUser!.heights != null
                                      ? ''
                                      : formatDate(
                                          globalUser!.heights!.last.date!
                                              .toDate()
                                              .day,
                                          globalUser!.heights!.last.date!
                                              .toDate()
                                              .month,
                                          globalUser!.heights!.last.date!
                                              .toDate()
                                              .year),
                                  data: globalUser!.heights!.isEmpty
                                      ? ''
                                      : globalUser!.heights!.last.height!
                                          .round()
                                          .toString(),
                                  unity: 'cm',
                                ),
                              ),
                            ),
                            //Blood
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _selectedRh = globalUser!.bloodGroup ?? 'O+';
                                  showSmallEditPopup(
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return DropdownButton<String>(
                                          elevation: 0,
                                          autofocus: true,
                                          dropdownColor: Colors.white,
                                          focusColor: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          style: SihhaFont.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          value: _selectedRh,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedRh = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'O+',
                                            'O-',
                                            'A+',
                                            'A-',
                                            'B+',
                                            'B-',
                                            'AB+',
                                            'AB-'
                                          ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: SihhaFont.copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        );
                                      },
                                    ),
                                    (selectedData) =>
                                        onSave2(selectedData, 'bloodTypes'),
                                  );
                                },
                                child: MyDetailCard(
                                  title: 'Rh',
                                  leadingIcon: LineAwesomeIcons.tint,
                                  lastUpdated: '',
                                  data: globalUser!.bloodGroup ?? '',
                                  unity: '',
                                ),
                              ),
                            ),
                            //weight
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _weightController.text =
                                      globalUser!.weights!.isEmpty
                                          ? ''
                                          : globalUser!.weights!.last.weight!
                                              .toString();
                                  showSmallEditPopup(
                                    MyTextForm(
                                      hintText: 'Poids (kg)',
                                      controller: _weightController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    // TextField(
                                    //   controller: _weightController,
                                    //   decoration: InputDecoration(
                                    //       labelText: 'Poids (kg)'),
                                    //   keyboardType: TextInputType.number,
                                    // ),
                                    (selectedData) =>
                                        onSave2(selectedData, 'weights'),
                                  );
                                },
                                child: MyDetailCard(
                                  title: 'Poids',
                                  leadingIcon: LineAwesomeIcons.hanging_weight,
                                  lastUpdated: globalUser!.weights!.isEmpty ||
                                          globalUser!.weights != null
                                      ? ''
                                      : formatDate(
                                          globalUser!.weights!.last.date!
                                              .toDate()
                                              .day,
                                          globalUser!.weights!.last.date!
                                              .toDate()
                                              .month,
                                          globalUser!.weights!.last.date!
                                              .toDate()
                                              .year),
                                  data: globalUser!.weights!.isEmpty
                                      ? ''
                                      : globalUser!.weights!.last.weight!
                                          .round()
                                          .toString(),
                                  unity: 'kg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        // height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Les maladies',
                                style: SihhaFont.copyWith(
                                  fontSize: 28,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Spacer(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    print(
                                        'user tapped Voir tout on Les Maladies');
                                  },
                                  child: Text(
                                    'Voir tout',
                                    style: SihhaFont.copyWith(
                                      fontSize: 15,
                                      color: SihhaGreen2,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.2,
                                      decorationColor: SihhaGreen2,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Les maladies precedent et chronic
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 250),
                        child: IntrinsicHeight(
                          // height: 300,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _isEditMode
                                      ? () {
                                          // Clear any previous text in the controllers

                                          _nameController.clear();
                                          _dateController.clear();
                                          showEditPopup(
                                            StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    MySearchTextField(
                                                      hintText:
                                                          'Nom de maladie',
                                                      controller:
                                                          _nameController,
                                                      suggestions:
                                                          exemplesMaladiesGenerales,
                                                      onSuggestionSelected:
                                                          (sug) {
                                                        if (sug is Map<String,
                                                            dynamic>) {
                                                          _selectedSuggestion =
                                                              sug;
                                                          _nameController.text =
                                                              sug['name']!;
                                                        }
                                                      },
                                                    ),
                                                    MyTextForm(
                                                      hintText: "Date",
                                                      obscureText: false,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      readOnly: true,
                                                      controller:
                                                          _dateController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please select a date';
                                                        }
                                                        return null;
                                                      },
                                                      onTapFunction: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SimpleDialog(
                                                              title: Text(
                                                                  'Sélectionner la date'),
                                                              titleTextStyle:
                                                                  SihhaPoppins3,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      400, // Set a fixed height
                                                                  width:
                                                                      400, // Set a fixed width
                                                                  child:
                                                                      SfDateRangePicker(
                                                                    selectionMode:
                                                                        DateRangePickerSelectionMode
                                                                            .single,
                                                                    maxDate:
                                                                        DateTime
                                                                            .now(),
                                                                    showActionButtons:
                                                                        true,
                                                                    cancelText:
                                                                        'Annuler',
                                                                    confirmText:
                                                                        'Confirmer',
                                                                    onCancel:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    onSubmit:
                                                                        (p0) {
                                                                      setState(
                                                                          () {
                                                                        _dateOfStart =
                                                                            _dateRangePickerController.selectedDate;
                                                                        if (_dateOfStart !=
                                                                            null) {
                                                                          _dateController.text = _dateOfStart!
                                                                              .toString()
                                                                              .split(' ')[0];
                                                                        }
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    controller:
                                                                        _dateRangePickerController,
                                                                    selectionColor:
                                                                        SihhaGreen2,
                                                                    selectionTextStyle: SihhaFont.copyWith(
                                                                        color:
                                                                            SihhaWhite,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            22),
                                                                    selectionShape:
                                                                        DateRangePickerSelectionShape
                                                                            .rectangle,
                                                                    todayHighlightColor:
                                                                        Color(
                                                                            0xFF2C3E50),
                                                                    showNavigationArrow:
                                                                        true,
                                                                    allowViewNavigation:
                                                                        true,
                                                                    monthCellStyle:
                                                                        DateRangePickerMonthCellStyle(
                                                                      disabledDatesTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFFCCCCCC),
                                                                          fontSize:
                                                                              18),
                                                                      todayTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              22),
                                                                      todayCellDecoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                SihhaGreen2,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          shape: BoxShape.rectangle),
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF6C7A89),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    headerStyle:
                                                                        DateRangePickerHeaderStyle(
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    yearCellStyle:
                                                                        DateRangePickerYearCellStyle(
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                      disabledDatesTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFFCCCCCC),
                                                                          fontSize:
                                                                              18),
                                                                      todayTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              22),
                                                                      todayCellDecoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              SihhaGreen2,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        shape: BoxShape
                                                                            .rectangle,
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
                                                  ],
                                                );
                                              },
                                            ),
                                            onSave:
                                                onSave, // Pass the callback function
                                          );
                                        }
                                      : null,
                                  child: MyDetailListView(
                                    title: 'Précédente',
                                    lastUpdated:
                                        globalUser!.diseases!.isEmpty ||
                                                globalUser!.diseases != null
                                            ? ''
                                            : formatDate(
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .day,
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .month,
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .year,
                                              ),
                                    leadingIcon: LineAwesomeIcons.history,
                                    child: MaladiesListView(''),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _isEditMode
                                      ? () {
                                          // Clear any previous text in the controllers

                                          _nameController.clear();
                                          _dateController.clear();
                                          showEditPopup(
                                            StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    MySearchTextField(
                                                      hintText:
                                                          'Nom de maladie',
                                                      controller:
                                                          _nameController,
                                                      suggestions:
                                                          exemplesMaladiesChroniques,
                                                      onSuggestionSelected:
                                                          (sug) {
                                                        if (sug is Map<String,
                                                            dynamic>) {
                                                          _selectedSuggestion =
                                                              sug;
                                                          _nameController.text =
                                                              sug['name']!;
                                                        }
                                                      },
                                                    ),
                                                    MyTextForm(
                                                      hintText: "Date",
                                                      obscureText: false,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      readOnly: true,
                                                      controller:
                                                          _dateController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please select a date';
                                                        }
                                                        return null;
                                                      },
                                                      onTapFunction: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SimpleDialog(
                                                              title: Text(
                                                                  'Sélectionner la date'),
                                                              titleTextStyle:
                                                                  SihhaPoppins3,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      400, // Set a fixed height
                                                                  width:
                                                                      400, // Set a fixed width
                                                                  child:
                                                                      SfDateRangePicker(
                                                                    selectionMode:
                                                                        DateRangePickerSelectionMode
                                                                            .single,
                                                                    maxDate:
                                                                        DateTime
                                                                            .now(),
                                                                    showActionButtons:
                                                                        true,
                                                                    cancelText:
                                                                        'Annuler',
                                                                    confirmText:
                                                                        'Confirmer',
                                                                    onCancel:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    onSubmit:
                                                                        (p0) {
                                                                      setState(
                                                                          () {
                                                                        _dateOfStart =
                                                                            _dateRangePickerController.selectedDate;
                                                                        if (_dateOfStart !=
                                                                            null) {
                                                                          _dateController.text = _dateOfStart!
                                                                              .toString()
                                                                              .split(' ')[0];
                                                                        }
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    controller:
                                                                        _dateRangePickerController,
                                                                    selectionColor:
                                                                        SihhaGreen2,
                                                                    selectionTextStyle: SihhaFont.copyWith(
                                                                        color:
                                                                            SihhaWhite,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            22),
                                                                    selectionShape:
                                                                        DateRangePickerSelectionShape
                                                                            .rectangle,
                                                                    todayHighlightColor:
                                                                        Color(
                                                                            0xFF2C3E50),
                                                                    showNavigationArrow:
                                                                        true,
                                                                    allowViewNavigation:
                                                                        true,
                                                                    monthCellStyle:
                                                                        DateRangePickerMonthCellStyle(
                                                                      disabledDatesTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFFCCCCCC),
                                                                          fontSize:
                                                                              18),
                                                                      todayTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              22),
                                                                      todayCellDecoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                SihhaGreen2,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          shape: BoxShape.rectangle),
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF6C7A89),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    headerStyle:
                                                                        DateRangePickerHeaderStyle(
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    yearCellStyle:
                                                                        DateRangePickerYearCellStyle(
                                                                      textStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              18),
                                                                      disabledDatesTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFFCCCCCC),
                                                                          fontSize:
                                                                              18),
                                                                      todayTextStyle: SihhaFont.copyWith(
                                                                          color: Color(
                                                                              0xFF2C3E50),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              22),
                                                                      todayCellDecoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              SihhaGreen2,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        shape: BoxShape
                                                                            .rectangle,
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
                                                  ],
                                                );
                                              },
                                            ),
                                            onSave:
                                                onSave, // Pass the callback function
                                          );
                                        }
                                      : null,
                                  child: MyDetailListView(
                                    title: 'Chroniques',
                                    lastUpdated:
                                        globalUser!.diseases!.isEmpty ||
                                                globalUser!.diseases != null
                                            ? ''
                                            : formatDate(
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .day,
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .month,
                                                globalUser!
                                                    .diseases!.last.dateOfStart!
                                                    .toDate()
                                                    .year,
                                              ),
                                    leadingIcon: LineAwesomeIcons.hourglass,
                                    child: MaladiesListView('Chronique'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: IntrinsicHeight(
                              // height: 500,
                              child: LeftCol(),
                            ),
                          ),
                          Expanded(
                            child: IntrinsicHeight(
                              // height: 500,
                              child: RightCol(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> showSmallEditPopup(
      Widget customWidget, Function(Map<String, dynamic>) onSave) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Modifier',
            style: SihhaPoppins3.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          content: customWidget,
          elevation: 0,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonPadding: EdgeInsets.all(20),
          surfaceTintColor: Colors.white,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.systemRed,
                  ),
                  child: Center(
                    child: Text(
                      'Annuler',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Map<String, dynamic> selectedData = {};
                if (customWidget is MyTextForm) {
                  if (customWidget.controller == _heightController) {
                    selectedData['height'] =
                        double.tryParse(_heightController.text);
                  } else if (customWidget.controller == _weightController) {
                    selectedData['weight'] =
                        double.tryParse(_weightController.text);
                  } else if (customWidget.controller == _nameController) {
                    selectedData['name'] = _nameController.text;
                  }
                  // } else if (customWidget is DropdownButton<String>) {
                } else if (customWidget is StatefulBuilder) {
                  selectedData['bloodType'] = _selectedRh;
                }
                onSave(selectedData); // Fix: Corrected the method call
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SihhaGreen2,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmer',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditPopup(Widget customWidget, {required Function(Disease) onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajouter une maladie',
            style: SihhaPoppins3.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust the height as needed
            child: SingleChildScrollView(
              child: customWidget,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonPadding: EdgeInsets.all(20),
          surfaceTintColor: Colors.white,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.systemRed,
                  ),
                  child: Center(
                    child: Text(
                      'Annuler',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // Save action
                // Disease selectedDisease = Disease(
                //   name: _nameController.text,
                //   dateOfStart: Timestamp.fromDate(_dateOfStart!),
                //   patientId: globalUser!.documentId,
                // );
                Disease selectedDisease = Disease.fromMap(_selectedSuggestion);
                onSave(selectedDisease); // Callback to handle selected disease
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SihhaGreen2,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmer',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditPopupAllergie(Widget customWidget,
      {required Function(Allergie) onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajouter une Allergie',
            style: SihhaPoppins3.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust the height as needed
            child: SingleChildScrollView(
              child: customWidget,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonPadding: EdgeInsets.all(20),
          surfaceTintColor: Colors.white,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.systemRed,
                  ),
                  child: Center(
                    child: Text(
                      'Annuler',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // Save action
                // Disease selectedDisease = Disease(
                //   name: _nameController.text,
                //   dateOfStart: Timestamp.fromDate(_dateOfStart!),
                //   patientId: globalUser!.documentId,
                // );
                Allergie selectedAllegrie =
                    Allergie.fromMap(_selectedSuggestion);
                onSaveAllergie(
                    selectedAllegrie); // Callback to handle selected disease
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SihhaGreen2,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmer',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditPopupDisability(Widget customWidget,
      {required Function(Disability) onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajouter un handicap',
            style: SihhaPoppins3.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust the height as needed
            child: SingleChildScrollView(
              child: customWidget,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonPadding: EdgeInsets.all(20),
          surfaceTintColor: Colors.white,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.systemRed,
                  ),
                  child: Center(
                    child: Text(
                      'Annuler',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // Save action
                // Disease selectedDisease = Disease(
                //   name: _nameController.text,
                //   dateOfStart: Timestamp.fromDate(_dateOfStart!),
                //   patientId: globalUser!.documentId,
                // );
                Disability selectedDisability =
                    Disability.fromMap(_selectedSuggestion);
                onSaveDisability(
                    selectedDisability); // Callback to handle selected disease
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SihhaGreen2,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmer',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showEditPopupHabit(Widget customWidget,
      {required Function(Habit) onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajouter un habitude',
            style: SihhaPoppins3.copyWith(color: Colors.black.withOpacity(0.7)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust the height as needed
            child: SingleChildScrollView(
              child: customWidget,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonPadding: EdgeInsets.all(20),
          surfaceTintColor: Colors.white,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.systemRed,
                  ),
                  child: Center(
                    child: Text(
                      'Annuler',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // Save action
                // Disease selectedDisease = Disease(
                //   name: _nameController.text,
                //   dateOfStart: Timestamp.fromDate(_dateOfStart!),
                //   patientId: globalUser!.documentId,
                // );
                Habit selectedHabit = Habit.fromMap(_selectedSuggestion);
                onSaveHabit(
                    selectedHabit); // Callback to handle selected disease
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SihhaGreen2,
                  ),
                  child: Center(
                    child: Text(
                      'Confirmer',
                      style: SihhaFont.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Column RightCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          // height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Les handicapées',
                  style: SihhaFont.copyWith(
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      print('user tapped Voir tout on Les handicapées');
                    },
                    child: Text(
                      'Voir tout',
                      style: SihhaFont.copyWith(
                        fontSize: 13,
                        color: SihhaGreen2,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.2,
                        decorationColor: SihhaGreen2,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IntrinsicHeight(
          // height: 300,
          child: GestureDetector(
            onTap: _isEditMode
                ? () {
                    // Clear any previous text in the controllers

                    _nameController.clear();
                    _dateController.clear();
                    showEditPopupDisability(
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MySearchTextField(
                                hintText: 'Nom de handicap',
                                controller: _nameController,
                                suggestions: exemplesHandicaps,
                                onSuggestionSelected: (sug) {
                                  if (sug is Map<String, dynamic>) {
                                    _selectedSuggestion = sug;
                                    _nameController.text = sug['name']!;
                                  }
                                },
                              ),
                              MyTextForm(
                                hintText: "Date",
                                obscureText: false,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                controller: _dateController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                                onTapFunction: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: Text('Sélectionner la date'),
                                        titleTextStyle: SihhaPoppins3,
                                        contentPadding: EdgeInsets.all(16),
                                        children: [
                                          SizedBox(
                                            height: 400, // Set a fixed height
                                            width: 400, // Set a fixed width
                                            child: SfDateRangePicker(
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              maxDate: DateTime.now(),
                                              showActionButtons: true,
                                              cancelText: 'Annuler',
                                              confirmText: 'Confirmer',
                                              onCancel: () {
                                                Navigator.pop(context);
                                              },
                                              onSubmit: (p0) {
                                                setState(() {
                                                  _dateOfStart =
                                                      _dateRangePickerController
                                                          .selectedDate;
                                                  if (_dateOfStart != null) {
                                                    _dateController.text =
                                                        _dateOfStart!
                                                            .toString()
                                                            .split(' ')[0];
                                                  }
                                                });
                                                Navigator.pop(context);
                                              },
                                              controller:
                                                  _dateRangePickerController,
                                              selectionColor: SihhaGreen2,
                                              selectionTextStyle:
                                                  SihhaFont.copyWith(
                                                      color: SihhaWhite,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 22),
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              todayHighlightColor:
                                                  Color(0xFF2C3E50),
                                              showNavigationArrow: true,
                                              allowViewNavigation: true,
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                disabledDatesTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color: SihhaGreen2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle),
                                                textStyle: SihhaFont.copyWith(
                                                    color: Color(0xFF6C7A89),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
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
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: SihhaGreen2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                            ],
                          );
                        },
                      ),
                      onSave: onSaveDisability, // Pass the callback function
                    );
                  }
                : null,
            child: MyDetailListView(
              title: 'Générales',
              lastUpdated: globalUser!.disabilities!.isEmpty ||
                      globalUser!.disabilities != null
                  ? ''
                  : formatDate(
                      globalUser!.disabilities!.last.dateOfStart!.toDate().day,
                      globalUser!.disabilities!.last.dateOfStart!
                          .toDate()
                          .month,
                      globalUser!.disabilities!.last.dateOfStart!.toDate().year,
                    ),
              leadingIcon: LineAwesomeIcons.wheelchair,
              child: DisabilitiesListView(),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Column LeftCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          // height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Les allergies',
                  style: SihhaFont.copyWith(
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      print('user tapped Voir tout on Les Allergies');
                    },
                    child: Text(
                      'Voir tout',
                      style: SihhaFont.copyWith(
                        fontSize: 13,
                        color: SihhaGreen2,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.2,
                        decorationColor: SihhaGreen2,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IntrinsicHeight(
          // height: 300,
          child: GestureDetector(
            onTap: _isEditMode
                ? () {
                    // Clear any previous text in the controllers

                    _nameController.clear();
                    _dateController.clear();
                    showEditPopupAllergie(
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MySearchTextField(
                                hintText: 'Nom de Allergie',
                                controller: _nameController,
                                suggestions: exemplesAllergies,
                                onSuggestionSelected: (sug) {
                                  if (sug is Map<String, dynamic>) {
                                    _selectedSuggestion = sug;
                                    _nameController.text = sug['name']!;
                                  }
                                },
                              ),
                              MyTextForm(
                                hintText: "Date",
                                obscureText: false,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                controller: _dateController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                                onTapFunction: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: Text('Sélectionner la date'),
                                        titleTextStyle: SihhaPoppins3,
                                        contentPadding: EdgeInsets.all(16),
                                        children: [
                                          SizedBox(
                                            height: 400, // Set a fixed height
                                            width: 400, // Set a fixed width
                                            child: SfDateRangePicker(
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              maxDate: DateTime.now(),
                                              showActionButtons: true,
                                              cancelText: 'Annuler',
                                              confirmText: 'Confirmer',
                                              onCancel: () {
                                                Navigator.pop(context);
                                              },
                                              onSubmit: (p0) {
                                                setState(() {
                                                  _dateOfStart =
                                                      _dateRangePickerController
                                                          .selectedDate;
                                                  if (_dateOfStart != null) {
                                                    _dateController.text =
                                                        _dateOfStart!
                                                            .toString()
                                                            .split(' ')[0];
                                                  }
                                                });
                                                Navigator.pop(context);
                                              },
                                              controller:
                                                  _dateRangePickerController,
                                              selectionColor: SihhaGreen2,
                                              selectionTextStyle:
                                                  SihhaFont.copyWith(
                                                      color: SihhaWhite,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 22),
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              todayHighlightColor:
                                                  Color(0xFF2C3E50),
                                              showNavigationArrow: true,
                                              allowViewNavigation: true,
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                disabledDatesTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color: SihhaGreen2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle),
                                                textStyle: SihhaFont.copyWith(
                                                    color: Color(0xFF6C7A89),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
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
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: SihhaGreen2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                            ],
                          );
                        },
                      ),
                      onSave: onSaveAllergie, // Pass the callback function
                    );
                  }
                : null,
            child: MyDetailListView(
              title: 'Générales',
              lastUpdated: globalUser!.allergies!.isEmpty ||
                      globalUser!.allergies != null
                  ? ''
                  : formatDate(
                      globalUser!.allergies!.last.dateOfStart!.toDate().day,
                      globalUser!.allergies!.last.dateOfStart!.toDate().month,
                      globalUser!.allergies!.last.dateOfStart!.toDate().year,
                    ),
              leadingIcon: LineAwesomeIcons.allergies,
              child: AllergiesListView(),
            ),
          ),
        ),
        IntrinsicHeight(
          // height: 300,
          child: GestureDetector(
            onTap: _isEditMode
                ? () {
                    // Clear any previous text in the controllers

                    _nameController.clear();
                    _dateController.clear();
                    showEditPopupHabit(
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MySearchTextField(
                                hintText: "Nom d 'habitudes",
                                controller: _nameController,
                                suggestions: exemplesHabitudes,
                                onSuggestionSelected: (sug) {
                                  if (sug is Map<String, dynamic>) {
                                    _selectedSuggestion = sug;
                                    _nameController.text = sug['name']!;
                                  }
                                },
                              ),
                              MyTextForm(
                                hintText: "Date",
                                obscureText: false,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                controller: _dateController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                                onTapFunction: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: Text('Sélectionner la date'),
                                        titleTextStyle: SihhaPoppins3,
                                        contentPadding: EdgeInsets.all(16),
                                        children: [
                                          SizedBox(
                                            height: 400, // Set a fixed height
                                            width: 400, // Set a fixed width
                                            child: SfDateRangePicker(
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              maxDate: DateTime.now(),
                                              showActionButtons: true,
                                              cancelText: 'Annuler',
                                              confirmText: 'Confirmer',
                                              onCancel: () {
                                                Navigator.pop(context);
                                              },
                                              onSubmit: (p0) {
                                                setState(() {
                                                  _dateOfStart =
                                                      _dateRangePickerController
                                                          .selectedDate;
                                                  if (_dateOfStart != null) {
                                                    _dateController.text =
                                                        _dateOfStart!
                                                            .toString()
                                                            .split(' ')[0];
                                                  }
                                                });
                                                Navigator.pop(context);
                                              },
                                              controller:
                                                  _dateRangePickerController,
                                              selectionColor: SihhaGreen2,
                                              selectionTextStyle:
                                                  SihhaFont.copyWith(
                                                      color: SihhaWhite,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 22),
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              todayHighlightColor:
                                                  Color(0xFF2C3E50),
                                              showNavigationArrow: true,
                                              allowViewNavigation: true,
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                disabledDatesTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color: SihhaGreen2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle),
                                                textStyle: SihhaFont.copyWith(
                                                    color: Color(0xFF6C7A89),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
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
                                                        color:
                                                            Color(0xFFCCCCCC),
                                                        fontSize: 18),
                                                todayTextStyle:
                                                    SihhaFont.copyWith(
                                                        color:
                                                            Color(0xFF2C3E50),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 22),
                                                todayCellDecoration:
                                                    BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: SihhaGreen2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                            ],
                          );
                        },
                      ),
                      onSave: onSaveHabit, // Pass the callback function
                    );
                  }
                : null,
            child: MyDetailListView(
              title: 'Des habitudes',
              lastUpdated: '',
              leadingIcon: LineAwesomeIcons.infinity,
              child: HabitsListView(),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget NoDataContainer() {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: SihhaGreen1.withOpacity(0.05),
                color: Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Center(
                child: Text(
                  'Aucune DATA trouvée.',
                  style:
                      SihhaPoppins3.copyWith(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget DisabilitiesListView() {
    if (globalUser == null ||
        globalUser!.disabilities == null ||
        globalUser!.disabilities!.isEmpty) {
      return NoDataContainer();
    }

    globalUser!.disabilities!
        .sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

    // Take the last 5 diseases
    List<Disability?> displayedDisabilities =
        globalUser!.disabilities!.take(20).toList();

    int totalDisabilities = displayedDisabilities.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(), // Disable scrolling
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: displayedDisabilities.asMap().entries.map((entry) {
            int index = entry.key;
            Disability disability = entry.value!;
            return Column(
              children: [
                disabilityTile(disability: disability),
                if (index <
                    totalDisabilities - 1) // Check if it's not the last item
                  Divider(
                      indent: 30,
                      thickness: 0.5,
                      color: Colors.black.withOpacity(0.1),
                      height: 0.5,
                      endIndent: 10)
                else
                  SizedBox(
                      height:
                          10), // Use SizedBox instead of Divider for the last item
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget disabilityTile({required Disability disability}) {
    int Sday = disability.dateOfStart!.toDate().day;
    int Smonth = disability.dateOfStart!.toDate().month;
    int Syear = disability.dateOfStart!.toDate().year;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12,
      ),
      child: Container(
        height: 65,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${disability.name}',
                    style: SihhaFont.copyWith(
                      fontSize: 15,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${disability.type}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              '${formatDate(Sday, Smonth, Syear)}',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 1.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget AllergiesListView() {
    if (globalUser == null ||
        globalUser!.allergies == null ||
        globalUser!.allergies!.isEmpty) {
      return NoDataContainer();
    }

    globalUser!.allergies!
        .sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

    // Take the last 5 diseases
    List<Allergie?> displayedAllergies =
        globalUser!.allergies!.take(20).toList();

    int totalAllergies = displayedAllergies.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(), // Disable scrolling
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: displayedAllergies.asMap().entries.map((entry) {
            int index = entry.key;
            Allergie allergie = entry.value!;
            return Column(
              children: [
                allergieTile(allergie: allergie),
                if (index <
                    totalAllergies - 1) // Check if it's not the last item
                  Divider(
                      indent: 30,
                      thickness: 0.5,
                      color: Colors.black.withOpacity(0.1),
                      height: 0.5,
                      endIndent: 10)
                else
                  SizedBox(
                      height:
                          10), // Use SizedBox instead of Divider for the last item
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget allergieTile({required Allergie allergie}) {
    int Sday = allergie.dateOfStart!.toDate().day;
    int Smonth = allergie.dateOfStart!.toDate().month;
    int Syear = allergie.dateOfStart!.toDate().year;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12,
      ),
      child: Container(
        height: 65,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${allergie.name}',
                    style: SihhaFont.copyWith(
                      fontSize: 15,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${allergie.type}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              '${formatDate(Sday, Smonth, Syear)}',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 1.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget MaladiesListView(String? type) {
    if (globalUser == null ||
        globalUser!.diseases == null ||
        globalUser!.diseases!.isEmpty) {
      return NoDataContainer();
    }

    // Filter diseases based on the type if the type is provided, otherwise take all diseases
    List<Disease?> filteredDiseases = type != null && type.isNotEmpty
        ? globalUser!.diseases!.where((e) => e.type == type).toList()
        : globalUser!.diseases!.toList();
    if (filteredDiseases.isEmpty) return NoDataContainer();
    // Sort diseases by date of creation in descending order
    filteredDiseases.sort((a, b) => b!.dateOfStart!.compareTo(a!.dateOfStart!));

    // Take the last 5 diseases
    List<Disease?> displayedDiseases = filteredDiseases.take(20).toList();

    int totalDiseases = displayedDiseases.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(), // Disable scrolling
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: displayedDiseases.asMap().entries.map((entry) {
            int index = entry.key;
            Disease disease = entry.value!;
            return Column(
              children: [
                diseaseTile(disease: disease),
                if (index <
                    totalDiseases - 1) // Check if it's not the last item
                  Divider(
                      indent: 30,
                      thickness: 0.5,
                      color: Colors.black.withOpacity(0.1),
                      height: 0.5,
                      endIndent: 10)
                else
                  SizedBox(
                      height:
                          10), // Use SizedBox instead of Divider for the last item
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget diseaseTile({required Disease disease}) {
    int Sday = disease.dateOfStart!.toDate().day;
    int Smonth = disease.dateOfStart!.toDate().month;
    int Syear = disease.dateOfStart!.toDate().year;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12,
      ),
      child: Container(
        height: 65,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${disease.name}',
                    style: SihhaFont.copyWith(
                      fontSize: 15,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${disease.type} / ${disease.level ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              '${formatDate(Sday, Smonth, Syear)}',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 1.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget HabitsListView() {
    if (globalUser == null ||
        globalUser!.habits == null ||
        globalUser!.habits!.isEmpty) {
      return NoDataContainer();
    }

    // Take the last 5 diseases
    List<Habit?> displayedHabits = globalUser!.habits!.take(5).toList();

    int totalHabits = displayedHabits.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(), // Disable scrolling
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: displayedHabits.asMap().entries.map((entry) {
            int index = entry.key;
            Habit habit = entry.value!;
            return Column(
              children: [
                habitTile(habit: habit),
                if (index < totalHabits - 1) // Check if it's not the last item
                  Divider(
                      indent: 30,
                      thickness: 0.5,
                      color: Colors.black.withOpacity(0.1),
                      height: 0.5,
                      endIndent: 10)
                else
                  SizedBox(
                      height:
                          10), // Use SizedBox instead of Divider for the last item
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget habitTile({required Habit habit}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12,
      ),
      child: Container(
        height: 65,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${habit.name}',
                    style: SihhaFont.copyWith(
                      fontSize: 15,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${habit.frequency} / ${habit.intensity}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            Spacer(),
            // Text(
            //   '${habit.duration}',
            //   style: GoogleFonts.poppins(
            //     color: Colors.grey,
            //     fontWeight: FontWeight.w400,
            //     fontSize: 14,
            //     letterSpacing: 1.3,
            //   ),
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }

  String formatDate(int day, int month, int year) {
    // Current date
    DateTime now = DateTime.now();

    // Input date
    DateTime inputDate = DateTime(year, month, day);

    // Calculate the difference in days
    Duration difference = now.difference(inputDate);

    if (difference.inDays < 1) {
      return '1 jr'; // Less than 1 day old
    } else if (difference.inDays < 7) {
      return '${difference.inDays} jrs'; // Less than 1 week old
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks sem'; // Less than 1 month old
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months mois'; // Less than 1 year old
    } else {
      // For dates older than a year, return formatted date
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(inputDate);
    }
  }
}
