class Habit {
  String name; // Current, former, never.
  String frequency; // Daily, weekly, monthly, yearly, never.
  String duration; // Short, medium, long.
  String intensity; // Low, medium, high.

  Habit({
    required this.name,
    required this.frequency,
    required this.duration,
    required this.intensity,
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    try {
      return Habit(
        name: map['name'],
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
      'frequency': frequency,
      'duration': duration,
      'intensity': intensity,
    };
  }
}
