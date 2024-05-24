import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disability.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disease.dart';

class Vision {
  double? degree;
  List<String>? correctiveMeasures; // e.g., glasses, contacts, surgery
  List<Disability>? disabilities;
  List<Disease>? diseases;

  /// Constructor for the Vision class.
  Vision({
    this.degree,
    this.correctiveMeasures,
    this.disabilities,
    this.diseases,
  });

  factory Vision.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map is null. Cannot create Vision object.');
    }
    return Vision(
      degree: map['degree'],
      correctiveMeasures: List<String>.from(map['correctiveMeasures'] ?? []),
      disabilities: map['disabilities'] != null
          ? List<Disability>.from(map['disabilities'].map((x) {
              if (x is Map<String, dynamic>) {
                return Disability.fromMap(x);
              } else {
                throw ArgumentError(
                    'Invalid disability data. Expected Map<String, dynamic>.');
              }
            }))
          : null,
      diseases: map['diseases'] != null
          ? List<Disease>.from(map['diseases'].map((x) {
              if (x is Map<String, dynamic>) {
                return Disease.fromMap(x);
              } else {
                throw ArgumentError(
                    'Invalid disease data. Expected Map<String, dynamic>.');
              }
            }))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'degree': degree,
      'correctiveMeasures': correctiveMeasures,
      'disabilities': disabilities?.map((x) => x.toMap()).toList(),
      'diseases': diseases?.map((x) => x.toMap()).toList(),
    };
  }
}
