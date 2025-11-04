import 'patient.dart';
import 'doctor.dart';
enum AppointmentStatus {scheduled, rescheduled, canceled, completed, noShow}

class Appointment{
  final String _id;
  final DateTime _dateTime;
  final Patient _patient;
  final Doctor _doctor;
  AppointmentStatus _appointmentStatus;

  Appointment(this._id, this._dateTime, this._patient, this._doctor, this._appointmentStatus);

  String get id => _id;
  DateTime get dateTime => _dateTime;
  Patient get patient => _patient;
  Doctor get doctor => _doctor;
  AppointmentStatus get appointmentStatus => _appointmentStatus;

  set appointmentStatus(AppointmentStatus status) => _appointmentStatus = status;

}

