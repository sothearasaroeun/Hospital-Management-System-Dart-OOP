import 'package:hospital_management/domain/appointment.dart';
import 'package:hospital_management/domain/doctor.dart';
import 'package:hospital_management/domain/hospital.dart';
import 'package:hospital_management/domain/patient.dart';
import 'package:hospital_management/domain/staff.dart';
import 'package:test/test.dart';

void main() {
  group('Hospital Domain Tests', () {
    late Hospital hospital;
    late Patient patient;
    late Doctor doctor;

    setUp(() {
      hospital = Hospital();
      
      patient = Patient('P001', 'Bunleap', '123456789', 'leap@gmail.com', DateTime(2005, 05, 15), Gender.male);
      doctor = Doctor('D001', 'Dr. Sotheara', '123456789', 'ra@gmail.com', 
        DateTime(2005, 12, 15), 
        Gender.female, 
        {
          DateTime(2025, 11, 10): WorkingHours(
          start: DateTime(2025, 11, 10, 9, 0), 
          end: DateTime(2025, 11, 10, 17, 0),
          ),
          DateTime(2025, 11, 11): WorkingHours(
          start: DateTime(2025, 11, 11, 9, 0),
          end: DateTime(2025, 11, 11, 17, 0),
          ),
        },
      );

      hospital.addPatient(patient);
      hospital.addDoctor(doctor);
    });

    test('Schedule appointment', () {
      final appt = Appointment('A001', DateTime(2025, 11, 10, 10, 0), patient, doctor, AppointmentStatus.scheduled);
      hospital.scheduleAppointment(appt);

      final patientAppts = hospital.getAppointmentForPatient('P001');
      final doctorAppts = hospital.getAppointmentForDoctor('D001');

      expect(patientAppts, hasLength(1));
      expect(doctorAppts, hasLength(1));
      expect(patientAppts.first.id, 'A001');
      expect(appt.status, AppointmentStatus.scheduled);
    });

    test('Allow different times', () {
      hospital.scheduleAppointment(Appointment('A001', DateTime(2025, 11, 10, 10, 0), patient, doctor, AppointmentStatus.scheduled));
      hospital.scheduleAppointment(Appointment('A002', DateTime(2025, 11, 10, 11, 0), patient, doctor, AppointmentStatus.scheduled));

      expect(hospital.getAppointmentForDoctor('D001'), hasLength(2));
    });
    
    test('Prevent conflict (same time)', () {
      final time = DateTime(2025, 11, 10, 10, 0);
      hospital.scheduleAppointment(Appointment('A001', time, patient, doctor, AppointmentStatus.scheduled));

      expect(
        () => hospital.scheduleAppointment(Appointment('A002', time, patient, doctor, AppointmentStatus.scheduled)),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('not available'))),
        );
    });

    test('Multiple appointments per patient/doctor', () {
      hospital.scheduleAppointment(Appointment('A001', DateTime(2025, 11, 10, 10, 0), patient, doctor, AppointmentStatus.scheduled));
      hospital.scheduleAppointment(Appointment('A002', DateTime(2025, 11, 11, 14, 0), patient, doctor, AppointmentStatus.scheduled));

      expect(hospital.getAppointmentForPatient('P001'), hasLength(2));
      expect(hospital.getAppointmentForDoctor('D001'), hasLength(2));
    });

    test('Doctor with no working hours can accept appointment', () {
      final freeDoctor = Doctor(
      'D100', 'Dr. Sam', '12345678', 'sam@hospital.com',
      DateTime(1990, 1, 1), Gender.male, {}); 
      hospital.addDoctor(freeDoctor);
      final appt = Appointment('A999', DateTime(2025, 12, 25, 15, 0), patient, freeDoctor, AppointmentStatus.scheduled);

      expect(() => hospital.scheduleAppointment(appt), returnsNormally);
    });

    test('Polymorphism (Staff base class)', () {
      final Staff staff = doctor;
      expect(staff.role, 'Doctor');
      expect(staff.name, 'Dr. Sotheara');
      expect(staff.getWorkingHours, isNotEmpty);
    });

    test('Cancel appoinment', () {
      final appt = Appointment('A001', DateTime(2025, 11, 10, 10, 0), patient, doctor, AppointmentStatus.scheduled);
      hospital.scheduleAppointment(appt);
      hospital.cancelAppointment('A001');

      expect(hospital.getAppointmentForPatient('P001'), isEmpty);
      expect(hospital.getAppointmentForDoctor('D001'), isEmpty);
      expect(appt.status, AppointmentStatus.canceled);
    });

    test('Cancel non-existent appointment', () {
      expect(() => hospital.cancelAppointment('NONEXISTENT'), throwsStateError);
    });

    test('Get appointments for non-existent patient/doctor', () {
      expect(() => hospital.getAppointmentForPatient('P999'), throwsStateError);
      expect(() => hospital.getAppointmentForDoctor('D999'), throwsStateError);
    });

    test('Working hours respected (outside hours)', (){
      final outside = DateTime(2025, 11, 10, 18, 0);
      final appt = Appointment('A001', outside, patient, doctor, AppointmentStatus.scheduled);

      expect(doctor.isAvailable(outside), isFalse);
      expect(
        () => hospital.scheduleAppointment(appt),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('not available'))),      
      );
    });
  });
}
