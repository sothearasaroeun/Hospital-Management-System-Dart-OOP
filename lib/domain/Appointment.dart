import 'patient.dart';
import 'doctor.dart';
enum AppointmentStatus {schecduled, rescheduled, canceled, completed, noShow}

class Appointment{
  final String _id;
  final DateTime dateTime;
  final Patient patient;
  final Doctor doctor;
  final AppointmentStatus _appointmentStatus;

  Appointment(this._id, this.dateTime, this.patient, this.doctor, this._appointmentStatus);

  String get id => _id;
  AppointmentStatus get appointmentStatus => _appointmentStatus;

}

