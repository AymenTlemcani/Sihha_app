import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Services/StatistiqueService.dart';

class Statistique extends StatefulWidget {
  const Statistique({super.key});

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  final _statisticsService = StatisticsService();
  Color ButtonColor = Colors.white;
  Color TextColor = SihhaGreen2;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _fetchAndProcessUserData();
  }

  Future<void> _fetchAndProcessUserData() async {
    try {
      await _statisticsService.fetchAndProcessUserData();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  Widget TotalPieChart(Map<String, int>? userData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: SihhaGreen2,
            ))
          : UsersCountChart(userData),
    );
  }

  Widget UsersCountChart(Map<String, int>? userData) {
    if (userData == null) {
      return Text('No data available');
    }

    List<Color> pieColors = [
      Color.fromARGB(255, 129, 90, 238),
      Color.fromARGB(255, 51, 159, 246),
      Color.fromARGB(255, 254, 164, 44),
      Color.fromARGB(255, 128, 224, 215),
    ];

    List<String> sections = [
      'isAdmin',
      'isMedcin',
      'isPharmacien',
      'normalCount'
    ];

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: List.generate(
            sections.length,
            (index) {
              String section = sections[index];
              int count = userData[section] ?? 0;
              double totalUsersCount =
                  (userData['totalUsersCount'] ?? 1).toDouble();

              double percentage = count / totalUsersCount * 100;

              return PieChartSectionData(
                color: pieColors[index],
                value: percentage,
                title: '${percentage.toStringAsFixed(1)}%',
                radius: 50,
                titleStyle: SihhaFont.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget GenderPieChart(Map<String, int>? userData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: SihhaGreen2,
            ))
          : GenderCountChart(userData),
    );
  }

  Widget GenderCountChart(Map<String, int>? userData) {
    if (userData == null) {
      return Text('No data available');
    }

    List<Color> pieColors = [
      Color.fromARGB(255, 17, 0, 255),
      Color.fromARGB(255, 234, 0, 255),
    ];

    List<String> sections = [
      'maleCount',
      'femaleCount',
    ];

    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sections: List.generate(
            sections.length,
            (index) {
              String section = sections[index];
              int count = userData[section] ?? 0;
              double totalUsersCount =
                  (userData['totalUsersCount'] ?? 1).toDouble();

              double percentage = count / totalUsersCount * 100;

              return PieChartSectionData(
                color: pieColors[index],
                value: percentage,
                title: '${percentage.toStringAsFixed(1)}%',
                radius: 50,
                titleStyle: SihhaFont.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget PieChartPartExplanation(String text, int count, Color color) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                // color: color,

                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: AutoSizeText.rich(
              TextSpan(
                text: '$text : ',
                style: SihhaFont,
                children: [
                  TextSpan(
                      text: '$count',
                      style: SihhaFont.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
              maxLines: 1,
              minFontSize: 8, // Set a minimum font size
              maxFontSize: 15, // Set a maximum font size
              overflowReplacement: Text(
                '$text: $count', // Fallback text if overflow occurs
                style: SihhaFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = _statisticsService.userData;

    if (userData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Ink(
                    //we used ink to see hover effect
                    // color: Colors.amber,
                    height: 30,
                    child: Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TextButton(
                            onHover: (value) {
                              setState(() {
                                ButtonColor =
                                    value ? SihhaGreen1 : Colors.white;
                                TextColor = value ? Colors.white : SihhaGreen2;
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(ButtonColor),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            onPressed: () {
                              _fetchAndProcessUserData();
                            },
                            child: IntrinsicWidth(
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.refresh_bold,
                                      color: TextColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Refresh',
                                      style: SihhaFont.copyWith(
                                          color: TextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        VerticalDivider(
                          endIndent: 5,
                          indent: 5,
                        ),
                        AutoSizeText.rich(
                          TextSpan(
                            text: 'Total users : ',
                            style: SihhaFont,
                            children: [
                              TextSpan(
                                  text: '${userData['totalUsersCount']!}',
                                  style: SihhaFont.copyWith(
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                          maxLines: 1,
                          minFontSize: 8, // Set a minimum font size
                          maxFontSize: 15, // Set a maximum font size
                          overflowReplacement: Text(
                            'Total users : ${userData['totalUsersCount']!}', // Fallback text if overflow occurs
                            style: SihhaFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 0.4,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Users Count',
                                                style: SihhaPoppins3.copyWith(
                                                    fontSize: 15),
                                              ),
                                              // AutoSizeText(
                                              //   'Users Count',
                                              //   maxLines: 1,
                                              //   minFontSize:
                                              //       12, // Set a minimum font size
                                              //   maxFontSize:
                                              //       15, // Set a maximum font size
                                              //   overflowReplacement: Text(
                                              //     'Users Count', // Fallback text if overflow occurs
                                              //     style:
                                              //         SihhaPoppins3.copyWith(
                                              //       color: Colors.black,
                                              //       fontWeight:
                                              //           FontWeight.w500,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          PieChartPartExplanation(
                                            'Normal',
                                            userData['normalCount']!,
                                            Color.fromARGB(255, 128, 224, 215),
                                          ),
                                          PieChartPartExplanation(
                                            'Medcins',
                                            userData['isMedcin']!,
                                            Color.fromARGB(255, 51, 159, 246),
                                          ),
                                          PieChartPartExplanation(
                                            'Pharmaciens',
                                            userData['isPharmacien']!,
                                            Color.fromARGB(255, 254, 164, 44),
                                          ),
                                          PieChartPartExplanation(
                                            'Admins',
                                            userData['isAdmin']!,
                                            Color.fromARGB(255, 129, 90, 238),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TotalPieChart(userData),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 0.4,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Genders Count',
                                                style: SihhaPoppins3.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          PieChartPartExplanation(
                                            'Male',
                                            userData['maleCount']!,
                                            Color.fromARGB(255, 17, 0, 255),
                                          ),
                                          Spacer(),
                                          PieChartPartExplanation(
                                            'Female',
                                            userData['femaleCount']!,
                                            Color.fromARGB(255, 234, 0, 255),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GenderPieChart(userData),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.blueAccent,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.black,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  // color: Colors.teal,s
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
