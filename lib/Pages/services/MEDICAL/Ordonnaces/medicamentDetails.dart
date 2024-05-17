import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';
import 'package:sahha_app/Models/Variables.dart';

class MedicamentDetails extends StatelessWidget {
  final Medicament medicament;
  final int index;

  const MedicamentDetails(
      {Key? key, required this.medicament, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                  text: '${index + 1}. ', // Add the index number here
                  style: SihhaFont.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '${medicament.name} ${medicament.dosage != null ? medicament.dosage : ''}',
                      style: SihhaFont.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
          ),

          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              children: [
                if (medicament.type != null && medicament.type != '')
                  Text(
                    '${medicament.type} ',
                    style:
                        SihhaFont.copyWith(color: Colors.black54, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                if (medicament.frequencyPerDay != null &&
                    medicament.frequencyPerDay != 0)
                  Text(
                    '${medicament.frequencyPerDay} fois par jour ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        SihhaFont.copyWith(color: Colors.black54, fontSize: 12),
                  ),
                if (medicament.duration != null && medicament.duration != 0)
                  Text(
                    'pendant ${medicament.duration} jours',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        SihhaFont.copyWith(color: Colors.black54, fontSize: 12),
                  ),
              ],
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('Type: ${medicament.type ?? 'N/A'}'),
          //       Text(
          //           'Frequency: ${medicament.frequencyPerDay ?? 'N/A'} times per day'),
          //       Text('Duration: ${medicament.duration ?? 'N/A'} days'),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
