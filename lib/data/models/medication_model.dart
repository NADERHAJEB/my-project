class MedicationModel {
  final String id;
  final String name;
  final String dosage;
  final String imagePath;
  final List<String> reminderTimes;

  MedicationModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.imagePath,
    required this.reminderTimes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'imagePath': imagePath,
      'reminderTimes': reminderTimes.join(','),
    };
  }

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      id: map['id'],
      name: map['name'],
      dosage: map['dosage'],
      imagePath: map['imagePath'],
      reminderTimes: (map['reminderTimes'] as String).split(','),
    );
  }
}