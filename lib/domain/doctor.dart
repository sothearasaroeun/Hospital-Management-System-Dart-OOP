import 'package:hospital_management/domain/staff.dart';
import 'appointment.dart';

class Doctor extends Staff{
  final List<Appointment> _appointments = [];
  
  Doctor(String id, String name, String phoneNumber, String email, DateTime dob, Gender gender, Map<DateTime, WorkingHours>  workingHours)
  : super(id, name, 'Doctor', phoneNumber, email, dob, gender, workingHours);
  
  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(Appointment appt) => _appointments.add(appt);

  bool isAvailable(DateTime time) {
    if (_appointments.any((a) => a.dateTime.isAtSameMomentAs(time))) {
      return false;
    }
    final day = DateTime(time.year, time.month, time.day);
    final hours = workingHours[day];
    if(hours == null) return true;

    return time.isAfter(hours.start) && time.isBefore(hours.end);
  }
  
  void removeAppointment(Appointment appt) => _appointments.remove(appt);

}