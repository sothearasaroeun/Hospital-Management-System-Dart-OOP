import 'patient.dart';
import 'doctor.dart';
enum AppointmentStatus {schecduled, rescheduled, canceled, completed, noShow}

class Appointment{
  final String _id;
  final DateTime _dateTime;
  final Patient _patient;
  final Doctor _doctor;
  final AppointmentStatus _appointmentStatus;

  Appointment(this._id, this._dateTime, this._patient, this._doctor, this._appointmentStatus);

  String get id => _id;
  DateTime get dateTime => _dateTime;
  Patient get patient => _patient;
  Doctor get doctor => _doctor;
  AppointmentStatus get appointmentStatus => _appointmentStatus;

}

