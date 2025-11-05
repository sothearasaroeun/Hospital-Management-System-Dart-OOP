import 'patient.dart';
import 'appointment.dart';
import 'doctor.dart';

class Hospital {
  final List<Patient> _patient = [];
  final List<Doctor> _doctor = [];
  final List<Appointment> _appointments = [];

  void addPatient(Patient p) => _patient.add(p);

  void addDoctor(Doctor d) => _doctor.add(d);

  List<Appointment> getAppointmentForPatient(Patient p) => p.appointments;
  List<Appointment> getAppointmentForDoctor(Doctor d) => d.appointments;

  //AI Generated
  void scheduleAppointment(Appointment appt){
    if (!appt.doctor.isAvailable(appt.dateTime)){
      throw Exception('Doctor not available at this time');
    }
    _appointments.add(appt);
    appt.patient.addAppointment(appt);
    appt.doctor.addAppointment(appt);
  }

  void cancelAppointment(String id){
    final appt = _appointments.firstWhere((a) => a.id == id,
      orElse: () => throw Exception('Appointment not found'));
    _appointments.remove(appt);
  }

}