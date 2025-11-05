import 'dart:io';
import '../domain/hospital.dart';
import '../domain/patient.dart';
import '../domain/doctor.dart';
import '../domain/appointment.dart';
import '../domain/staff.dart';

class HospitalUI{
  final Hospital hospital;

  HospitalUI(this.hospital);

  Future<void> run() async {
    while (true) {
      _showMenu();
      final choice = stdin.readLineSync()?.trim();

      try {
        switch (choice) {
          case '1': 
          await _addPatient(); 
          break;
          case '2':
          await _addDoctor();
          break;
          case '3':
          await _scheduleAppointment();
          break;
          case '4':
          await _viewPatientAppointments();
          break;
          case '5':
          await _viewDoctorSchedule();
          break;
          case '6':
          await _cancelAppointment();
          case '7':
          return;
          default:
          print('Invalid choice. PLease try again');
        }
      } catch (e) {
        print('Error" $e');
      }
      print('Press Enter to continue...');
      stdin.readLineSync();
    }
  }

  void _showMenu(){
    print('HOSPITAL APPOINTMRNT MANAGEMENT SYSTEM');
    print('1. Add Patient');
    print('2. Add Doctor');
    print('3. Schedule Appointment');
    print('4. View Patient Appointments');
    print('5. View Doctor Schedule');
    print('6. Cancel Appointment');
    print('7. Save & Exit');
    stdout.write('Enter choice (1-7): ');
  }

  Future<void> _addPatient() async {
    print('-----Add New Patient-----');
    stdout.write('ID: '); 
    final id = stdin.readLineSync()!.trim();
    stdout.write('Name: '); 
    final name = stdin.readLineSync()!.trim();
    stdout.write('Phone: '); 
    final phone = stdin.readLineSync()!.trim();
    stdout.write('Email: '); 
    final email = stdin.readLineSync()!.trim();
    stdout.write('DOB (YYYY-MM-DD): '); 
    final dob = DateTime.parse(stdin.readLineSync()!.trim());
    stdout.write('Gender (male/female/preferNotToSay): '); 
    final g = stdin.readLineSync()!.trim();
    final gender = Gender.values.firstWhere(
      (e) => e.toString().split('.').last == g, 
      orElse: () => Gender.preferNotToSay,
      );
    hospital.addPatient(Patient(id, name, phone, email, dob, gender));
    print('Patient added successfully');
  }

  Future<void> _addDoctor() async {
    print('-----Add New Doctor-----');
    stdout.write('ID: '); 
    final id = stdin.readLineSync()!.trim();
    stdout.write('Name: '); 
    final name = stdin.readLineSync()!.trim();
    stdout.write('Phone: '); 
    final phone = stdin.readLineSync()!.trim();
    stdout.write('Email: '); 
    final email = stdin.readLineSync()!.trim();
    stdout.write('DOB (YYYY-MM-DD): '); 
    final dob = DateTime.parse(stdin.readLineSync()!.trim());
    stdout.write('Gender (male/female/preferNotToSay): '); 
    final g = stdin.readLineSync()!.trim();
    final gender = Gender.values.firstWhere(
      (e) => e.toString().split('.').last == g, 
     orElse: () => Gender.preferNotToSay,
    );
    //AI Generate
    final Map<DateTime, WorkingHours> hours = {};
    stdout.write('Enter working hours(date start end) or press Enter to skip: ');
    while (true) {
      final line = stdin.readLineSync();
      if (line == null || line.isEmpty) break;
      
      final parts = line.split(' ');
      if (parts.length != 3) {
        stdout.write('Invalid format. Please use (YYYY-MM-DD HH:MM HH:MM) or press Enter to skip:');
        continue;
      }
      try {
        final date = DateTime.parse(parts[0]);
        final start = DateTime.parse('${parts[0]} ${parts[1]}');
        final end = DateTime.parse('${parts[0]} ${parts[2]}');
        hours[date] = WorkingHours(start: start, end: end);
      } catch (e) {
        stdout.write('Invalid date/time format. Try again: ');
      }
    }
    hospital.addDoctor(Doctor(id, name, phone, email, dob, gender, hours));
    print('Dcotor added successfully');
  }

  Future<void> _scheduleAppointment() async {
    stdout.write('ID: '); 
    final id = stdin.readLineSync()!.trim();
    stdout.write('Date & Time (YYYY-MM-DD HH:MM): '); 
    final dt = DateTime.parse(stdin.readLineSync()!.trim().replaceAll(' ', 'T'));
    stdout.write('Patient ID: '); 
    final pId = stdin.readLineSync()!.trim();
    stdout.write('Doctor ID: '); 
    final dId = stdin.readLineSync()!.trim();

    final patient = hospital.patients.firstWhere((p) => p.id == pId, 
    orElse: () => throw Exception('Patient not found'));
    final doctor = hospital.doctors.firstWhere((d) => d.id == dId, 
    orElse: () => throw Exception('Doctor not found'));

    final appt = Appointment(id, dt, patient, doctor, AppointmentStatus.scheduled);
    hospital.scheduleAppointment(appt);
    print('Appointment scheduled.');
  }

  Future<void> _viewPatientAppointments() async {
    stdout.write('Patient ID: '); 
    final id = stdin.readLineSync()!.trim();
    final appt = hospital.getAppointmentForPatient(id);
    _printAppointment(appt);
  }

  Future<void> _viewDoctorSchedule() async {
    stdout.write('Doctor ID: '); 
    final id = stdin.readLineSync()!.trim();
    final appt = hospital.getAppointmentForDoctor(id);
    _printAppointment(appt);
  }

  Future<void> _cancelAppointment() async {
    stdout.write('Appointment ID: '); 
    final id = stdin.readLineSync()!.trim();
    hospital.cancelAppointment(id);
    print('Appoinment canceled');
  }

  Future<void> _printAppointment(List<Appointment> appt) async {
    if (appt.isEmpty){
      print('No appointments');
      return;
    }
    for (var a in appt){
      print('→ ${a.id}: ${a.dateTime} | ${a.status}');
    }
  }

}

