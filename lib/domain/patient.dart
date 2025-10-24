import 'Appointment.dart';

class Patient {
  final String _id;
  final String _name;
  final List<Appointment> _appointments = [];

  Patient(this._id, this._name);

  String get id => _id;
  String get name => _name;
  List<Appointment> get appointments => List.unmodifiable(_appointments);
  
  void addAppointment(Appointment appt) => _appointments.add(appt);
  
}
