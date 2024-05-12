class Medicament {
  String? id;
  String? name;
  String? type;
  String? pictureUrl;
  String? dosage;
  int? frequencyPerDay;
  int? duration;
  // ID of the medication
  // Name of the medication
  // Type of the medication (e.g., tablette, capsule, sirop, injection, etc.)
  // URL or base64 encoded string for the medication picture
  // Dosage of the medication (e.g., 500mg, 1 comprimé, 2 cuillères à café)
  // Frequency per day of taking the medication (e.g., 1, 2, 3 (fois par jour))
  // Duration of the medication (e.g., number of days or weeks)

  /// Constructor for the Medicament class.
  Medicament({
    this.id, // ID of the medication
    this.name, // Name of the medication
    this.type, // Type of the medication
    this.pictureUrl, // Picture URL of the medication
    this.dosage, // Dosage of the medication
    this.frequencyPerDay, // Frequency per day of taking the medication
    this.duration, // Duration of the medication
    // Add additional parameters as needed
  });

  // Method to update the name of the medication
  void updateName(String newName) {
    this.name = newName;
  }

  // Method to update the type of the medication
  void updateType(String newType) {
    this.type = newType;
  }

  // Method to update the picture URL of the medication
  void updatePictureUrl(String newUrl) {
    this.pictureUrl = newUrl;
  }

  // Method to update the dosage of the medication
  void updateDosage(String newDosage) {
    this.dosage = newDosage;
  }

  // Method to update the frequency per day of the medication
  void updateFrequency(int newFrequency) {
    this.frequencyPerDay = newFrequency;
  }

  // Method to update the duration of the medication
  void updateDuration(int newDuration) {
    this.duration = newDuration;
  }

  factory Medicament.fromMap(Map<String, dynamic> map) {
    return Medicament(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      pictureUrl: map['pictureUrl'],
      dosage: map['dosage'],
      frequencyPerDay: map['frequencyPerDay'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'pictureUrl': pictureUrl,
      'dosage': dosage,
      'frequencyPerDay': frequencyPerDay,
      'duration': duration,
    };
  }
}
