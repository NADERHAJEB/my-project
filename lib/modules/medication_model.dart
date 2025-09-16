
class Medication {
  final int? id;
  final String name;
  final String dose;
  final DateTime time;
  final String? imagePath;

  Medication({
    this.id,
    required this.name,
    required this.dose,
    required this.time,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dose': dose,
      'time': time.toIso8601String(),
      'imagePath': imagePath,
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'],
      name: map['name'],
      dose: map['dose'],
      time: DateTime.parse(map['time']),
      imagePath: map['imagePath'],
    );
  }
}