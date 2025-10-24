import 'Patient.dart';
import 'Appointment.dart';
import 'Doctor.dart';

class Hospital {
  final List<Patient> _patient = [];
  final List<Doctor> _doctor = [];
  final List<Appointment> _appointments = [];

  void addPatient(Patient p) => _patient.add(p);
  void addDoctor(Doctor d) => _doctor.add(d);

  List<Appointment> getAppointmentForPatient(Patient p) => p.appointments;
  List<Appointment> getAppointmentForDoctor(Doctor d) => d.appointments;

}