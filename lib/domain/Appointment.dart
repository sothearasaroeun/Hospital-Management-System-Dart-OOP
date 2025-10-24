import 'Patient.dart';
import 'Doctor.dart';

class Appointment{
  final String _id;
  final DateTime _dateTime;
  final Patient _patient;
  final Doctor _doctor;

  Appointment(this._id, this._dateTime, this._patient, this._doctor);

  String get id => _id;
  DateTime get dateTime => _dateTime;
  Patient get patient => _patient;
  Doctor get doctor => _doctor;

}