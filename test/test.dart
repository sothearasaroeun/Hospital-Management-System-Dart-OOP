import 'dart:math';

import 'package:hospital_management/domain/appointment.dart';
import 'package:hospital_management/domain/doctor.dart';
import 'package:hospital_management/domain/hospital.dart';
import 'package:hospital_management/domain/patient.dart';
import 'package:hospital_management/domain/staff.dart';
import 'package:hospital_management/main.dart';
import 'package:test/test.dart';

void main() {
  group('Hospital Domain Tests', () {
    late Hospital hospital;

    setUp(() {
      hospital = Hospital();
      
      var patient = Patient('P001', 'Bunleap', '123456789', 'leap@gmail.com', DateTime(2005, 05, 15), Gender.male);
      var doctor = Doctor('D001', 'Dr. Sotheara', '123456789', 'ra@gmail.com', DateTime(2005, 12, 15), Gender.female, <DateTime, WorkingHours>{});

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

    test('Prevent conflict (same time)', () {
      final time = DateTime(2025, 11, 10, 10, 0);

      final appt1 = Appointment('A001', time, patient, doctor, AppointmentStatus.scheduled);
      hospital.scheduleAppointment(appt1);

      final appt2 = Appointment('A002', time, patient, doctor, AppointmentStatus.scheduled);

      expect(() => hospital.scheduleAppointment(appt2),
        throwsA(isA<StateError>().having((e) => e.message, 'message', contains('not available'))));
    });

    test('Polymorphism (Staff base class)', () {
      final staff = doctor;
      expect(staff.role, 'Doctor');
      expect(staff.name, 'Dr. Sotheara');
      expect(staff.getWorkingHours, isEmpty);
    });

    test('Cancel appoinment', () {
      final appt = Appointment('A001', DateTime(2025, 11, 10, 10, 0), patient, doctor, AppointmentStatus.scheduled);
      hospital.scheduleAppointment(appt);
      hospital.cancelAppointment('A001');

      expect(hospital.getAppointmentForPatient('P001'), isEmpty);
      expect(hospital.getAppointmentForDoctor('D001'), isEmpty);
      expect(appt.status, AppointmentStatus.canceled);
    });
  });
}
