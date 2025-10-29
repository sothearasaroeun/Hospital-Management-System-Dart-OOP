import 'appointment.dart';

enum Gender {male, female, preferNotToSay}

class Patient {
  final String _id;
  final String _name;
  final String _phoneNumber;
  final String _email;
  final String _dob;
  final Gender _gender;
  final List<Appointment> _appointments = [];

  Patient(this._id, this._name, this._phoneNumber, this._dob, this._email, this._gender);

  String get id => _id;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get dob => _dob;
  String get email => _email;
  Gender get gender => _gender;
  List<Appointment> get appointments => List.unmodifiable(_appointments);
  
  void addAppointment(Appointment appt) => _appointments.add(appt);
  
}
