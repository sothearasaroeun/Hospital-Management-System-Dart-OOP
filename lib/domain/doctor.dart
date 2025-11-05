import 'appointment.dart';
import 'medicalRecord.dart';

enum Gender {male, female, preferNotToSay}

class WorkingHours{
  final DateTime start;
  final DateTime end;

  WorkingHours({required this.start, required this.end});
}

class Doctor {
  final String _id;
  final String name;
  final String _role;
  final String _phoneNumber;
  final String _email;
  final String _dob;
  final Gender gender;
  final Map<DateTime, WorkingHours> workingHours;
  final List<Appointment> _appointments = [];
  final List<MedicalRecord> _medicalRecord = [];
  
  Doctor(this._id, this.name, this._role, this._phoneNumber, this._dob, this._email, this.gender, this.workingHours);
  
  String get id => _id;
  String get role => _role;
  String get phoneNumber => _phoneNumber;
  String get dob => _dob;
  String get email => _email;
  Map<DateTime, WorkingHours> get getWorkingHours => workingHours;
  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(Appointment appt) => _appointments.add(appt);
  void addMedicalRecors(MedicalRecord medicalRecord) => _medicalRecord.add(medicalRecord);

  bool isAvailable(DateTime time){
    return !_appointments.any((a) => a.dateTime == time);
  }
  
}