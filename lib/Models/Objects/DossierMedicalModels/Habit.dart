class Habit {
  String? name; // Current, former, never.
  String? frequency; // Daily, weekly, monthly, yearly, never.
  String? duration; // Short, medium, long.
  String? intensity; // Low, medium, high.
  String? patientId;

  Habit({
    this.name,
    this.patientId,
    this.frequency,
    this.duration,
    this.intensity,
  });

  factory Habit.fromMap(Map<String, dynamic>? map) {
    try {
      return Habit(
        name: map!['name'],
        patientId: map['patientId'],
        frequency: map['frequency'],
        duration: map['duration'],
        intensity: map['intensity'],
      );
    } catch (e) {
      print('Error parsing Habit from map: $e');
      throw Exception('Error parsing Habit from map');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'patientId': patientId,
      'frequency': frequency,
      'duration': duration,
      'intensity': intensity,
    };
  }
}
