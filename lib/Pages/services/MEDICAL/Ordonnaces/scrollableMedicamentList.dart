import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/medicamentDetails.dart';

class ScrollableMedicamentList extends StatefulWidget {
  final Ordonnance ordonnance;

  const ScrollableMedicamentList({Key? key, required this.ordonnance})
      : super(key: key);

  @override
  _ScrollableMedicamentListState createState() =>
      _ScrollableMedicamentListState();
}

class _ScrollableMedicamentListState extends State<ScrollableMedicamentList> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<List<Medicament>> medicamentPages = [];
    List<Medicament> currentPage = [];

    for (var medicament in widget.ordonnance.medicaments!) {
      if (currentPage.length == 3) {
        medicamentPages.add(currentPage);
        currentPage = [medicament];
      } else {
        currentPage.add(medicament);
      }
    }

    if (currentPage.isNotEmpty) {
      medicamentPages.add(currentPage);
    }

    return Column(
      children: [
        SizedBox(
          height: 294, // Provide a fixed height constraint
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _currentPage == 0
                    ? null
                    : () {
                        _pageController.animateToPage(
                          _currentPage - 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: medicamentPages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: medicamentPages[index].length,
                      itemBuilder: (context, medicamentIndex) {
                        final medicament =
                            medicamentPages[index][medicamentIndex];
                        return MedicamentDetails(
                          medicament: medicament,
                          index: medicamentIndex,
                        );
                      },
                    );
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _currentPage == medicamentPages.length - 1
                    ? null
                    : () {
                        _pageController.animateToPage(
                          _currentPage + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        if (widget.ordonnance.instructions != null &&
            widget.ordonnance.instructions!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...widget.ordonnance.instructions!
                  .map((instruction) => Text(instruction ?? ''))
                  .toList(),
            ],
          ),
        SizedBox(height: 16),
        if (widget.ordonnance.notes != null &&
            widget.ordonnance.notes!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...widget.ordonnance.notes!
                  .map((note) => Text(note ?? ''))
                  .toList(),
            ],
          ),
      ],
    );
  }
}
