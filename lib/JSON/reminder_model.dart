class ReminderModel {
  final String medicineName;
  final String dose;
  final String repeat;
  final String selectedDateTime;
  final String isActive;

  ReminderModel({
    required this.medicineName,
    required this.dose,
    required this.repeat,
    required this.selectedDateTime,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicineName': medicineName,
      'dose': dose,
      'repeat': repeat,
      'selectedDateTime': selectedDateTime,
      'isActive': isActive,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      medicineName: map['medicineName'] as String,
      dose: map['dose'] as String,
      repeat: map['repeat'] as String,
      selectedDateTime: map['selectedDateTime'] as String,
      isActive: map['isActive'] as String,
    );
  }
}
