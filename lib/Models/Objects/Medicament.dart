class Medicament {
  String? id;
  String? name;
  String? type;
  String? pictureUrl;
  String? dosage;
  int? frequencyPerDay;
  int? duration;
  String? purpose;
  bool? needsOrdonnance;
  String? status;

  Medicament({
    this.id,
    this.name,
    this.type,
    this.pictureUrl,
    this.dosage,
    this.frequencyPerDay,
    this.duration,
    this.purpose,
    this.needsOrdonnance,
    this.status,
  });

  void updateName(String newName) {
    this.name = newName;
  }

  void updateType(String newType) {
    this.type = newType;
  }

  void updatePictureUrl(String newUrl) {
    this.pictureUrl = newUrl;
  }

  void updateDosage(String newDosage) {
    this.dosage = newDosage;
  }

  void updateFrequency(int newFrequency) {
    this.frequencyPerDay = newFrequency;
  }

  void updateDuration(int newDuration) {
    this.duration = newDuration;
  }

  void updatePurpose(String newPurpose) {
    this.purpose = newPurpose;
  }

  void updateNeedsOrdonnance(bool newNeedsOrdonnance) {
    this.needsOrdonnance = newNeedsOrdonnance;
  }

  void updateStatus(String newStatus) {
    this.status = newStatus;
  }

  factory Medicament.fromMap(Map<String, dynamic> map) {
    try {
      return Medicament(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        pictureUrl: map['pictureUrl'],
        dosage: map['dosage'],
        frequencyPerDay: map['frequencyPerDay'],
        duration: map['duration'],
        purpose: map['purpose'],
        needsOrdonnance: map['needsOrdonnance'],
        status: map['status'],
      );
    } catch (e) {
      print('Error creating Medicament from map: $e');
      throw Exception('Error creating Medicament from map');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'name': name,
        'type': type,
        'pictureUrl': pictureUrl,
        'dosage': dosage,
        'frequencyPerDay': frequencyPerDay,
        'duration': duration,
        'purpose': purpose,
        'needsOrdonnance': needsOrdonnance,
        'status': status,
      };
    } catch (e) {
      print('Error converting Medicament to map: $e');
      throw Exception('Error converting Medicament to map');
    }
  }
}
