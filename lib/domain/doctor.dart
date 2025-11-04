import 'package:hospital_management/domain/staff.dart';
import 'appointment.dart';

class Doctor extends Staff{
  final List<Appointment> _appointments = [];
  
  Doctor(String id, String name, String phoneNumber, String email, DateTime dob, Gender gender, Map<DateTime, WorkingHours>  workingHours): super(id, name, 'Doctor', phoneNumber, email, dob, gender, workingHours);
  
  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(Appointment appt) => _appointments.add(appt);

  bool isAvailable(DateTime time){
    return !_appointments.any((a) => a.dateTime.isAtSameMomentAs(time));
  }
  
}