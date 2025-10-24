import 'Staff.dart';
import 'Appointment.dart';

class Doctor extends Staff{
  final List<Appointment> _appointments = [];
  
  Doctor(String id, String name) : super(id, name, 'Doctor');

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(Appointment appt) => _appointments.add(appt);

  bool isAvailable(DateTime time){
    return !_appointments.any((a) => a.dateTime == time);
  }
  
}