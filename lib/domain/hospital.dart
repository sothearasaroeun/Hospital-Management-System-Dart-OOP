import 'patient.dart';
import 'appointment.dart';
import 'doctor.dart';

class Hospital {
  final List<Patient> _patients = [];
  final List<Doctor> _doctors = [];
  final List<Appointment> _appointments = [];

  List<Patient> get patients => List.unmodifiable(_patients);
  List<Doctor> get doctors => List.unmodifiable(_doctors);
  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addPatient(Patient p) {
    if (_patients.any((pt) => pt.id == p.id)) {
      throw Exception('Patient ID ${p.id} already exists');
    }
    _patients.add(p);
  }
  
  void addDoctor(Doctor d) {
    if (_doctors.any((doc) => doc.id == d.id)) {
      throw Exception('Doctor ID ${d.id} already exists');
    }
    _doctors.add(d);
  }

  List<Appointment> getAppointmentForPatient(String id){
    final patient = _patients.firstWhere((p) => p.id == id,
    orElse: () => throw StateError('Patient not found'));
    return patient.appointments;
  }

  List<Appointment> getAppointmentForDoctor(String id){
    final doctor = _doctors.firstWhere((d) => d.id == id,
    orElse: () => throw StateError('Doctor not found'));
    return doctor.appointments;
  }

  //AI Generated
  void scheduleAppointment(Appointment appt){
    if (_appointments.any((a) => a.id == appt.id)) {
      throw Exception('Appointment ID ${appt.id} already exists');
    }
    if (!appt.doctor.isAvailable(appt.dateTime)){
      throw Exception('Doctor not available at this time');
    }
    _appointments.add(appt);
    appt.patient.addAppointment(appt);
    appt.doctor.addAppointment(appt);
  }

  void cancelAppointment(String id){
    final appt = _appointments.firstWhere((a) => a.id == id,
      orElse: () => throw StateError('Appointment not found'));
    _appointments.remove(appt);
    appt.patient.removeAppointment(appt);
    appt.doctor.removeAppointment(appt);
    appt.status = AppointmentStatus.canceled;
  }

}