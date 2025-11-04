import 'patient.dart';
import 'doctor.dart';
enum AppointmentStatus {scheduled, rescheduled, canceled, completed, noShow}

class Appointment{
  final String _id;
  final DateTime _dateTime;
  final Patient _patient;
  final Doctor _doctor;
  AppointmentStatus _status;

  Appointment(this._id, this._dateTime, this._patient, this._doctor, this._status);

  String get id => _id;
  DateTime get dateTime => _dateTime;
  Patient get patient => _patient;
  Doctor get doctor => _doctor;
  AppointmentStatus get appointmentStatus => _status;

  set appointmentStatus(AppointmentStatus status) => status = _status;

}

