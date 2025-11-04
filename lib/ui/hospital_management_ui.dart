import 'dart:io';
import '../domain/hospital.dart';

class HospitalUI{
  final Hospital hospital;

  HospitalUI(this.hospital);

  void run() async {
    while (true) {
      _showMenu();
      final choice = stdin.readLineSync()?.trim();

      try {
        switch (choice) {
          case '1': 
          _addPatient(); 
          break;
          case '2':
          _addDoctor();
          break;
          case '3':
          _scheduleAppointment();
          break;
          case '4':
          _viewPatientAppointments();
          break;
          case '5':
          _viewDoctorSchedule();
          break;
          case '6':
          _cancelAppointment();
          case '7':
          return;
          default:
          print('Invalid choice. PLease try again');
        }
      } catch (e) {
        print('Error" $e');
      }
      print('Press Enter to continue...');
      stdin.readByteSync();
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

  void _addPatient(){

  }

  void _addDoctor(){

  }

  void _scheduleAppointment(){

  }

  void _viewPatientAppointments(){

  }

  void _viewDoctorSchedule(){

  }

  void _cancelAppointment(){

  }

}

