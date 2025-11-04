import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart'as path;

import '../domain/hospital.dart';
import '../domain/patient.dart';
import '../domain/doctor.dart';
import '../domain/appointment.dart';
import '../domain/staff.dart';

class HospitalRepository {
  final Hospital _hospital;
  final String _filePath;

  HospitalRepository(this._hospital, {String? filePath}) 
    : _filePath = filePath ?? path.join(Directory.current.path, 'hospital_data.json');

  Future<void> load() async{
    final file = File(_filePath);
    if (!await file.exists()) return;

    final jsonStr = await file.readAsString();
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;

    for (final p in data['patients'] ?? <Map>[]) {
      final patient = Patient(
        p['id'] as String, 
        p['name'] as String, 
        p['phoneNumber'] as String,
        p['email'] as String,
        DateTime.parse(p['dob'] as String), 
        _genderFromString(p['gender'] as String),
        );
        _hospital.addPatient(patient);
    }

    for (final d in data['doctors'] ?? <Map>[]){
      final doctor = Doctor(
        d['id'] as String, 
        d['name'] as String, 
        d['phoneNumber'] as String, 
        d['email'] as String, 
        DateTime.parse(d['dob'] as String), 
        _genderFromString(d['gender'] as String),
        <DateTime, WorkingHours>{},
      );
      _hospital.addDoctor(doctor);
    }

    for (var a in data['appointment'] ?? <Map>[]) {
      final patient = _hospital._patients.firstWhere((p) => p.id == a['patientId'] as String);
      final doctor = _hospital._doctors.firstWhere((d) => d.id == a['doctorId'] as String);
      final appt = Appointment(
        a['id'] as String, 
        DateTime.parse(a['dataTime'] as String), 
        patient, 
        doctor,
        _statusFromString (a['status'] as String),
      );
      _hospital.scheduleAppointment(appt);
    }
  }  

  Future<void> save() async{
    final data = {
      'patients': _hospital._patients.map((p) => {
        'id': p.id, 
        'name': p.name,
        'phoneNumber': p.phoneNumber,
        'email': p.email,
        'dob': p.dob.toIso8601String(),
        'gender': p.gender.name,
      }).toList(),
      'doctors': _hospital._doctors.map((d) => {
        'id': d.id, 
        'name': d.name,
        'phoneNumber': d.phoneNumber,
        'email': d.email,
        'dob': d.dob.toIso8601String(),
        'gender': d.gender.name,
      }).toList(),
      'appointments': _hospital._appointments.map((a) => {
        'id': a.id, 
        'dateTime': a.dateTime.toIso8601String(),
        'patirntId': a.patient.id,
        'doctorId': a.doctor.id,
        'appointmentStatus': a.appointmentStatus.name,
      }).toList(),
    };
    await File(_filePath).writeAsString(jsonEncode(data));
  }

  //AI Generated
  Gender _genderFromString(String s){
    return Gender.values.firstWhere(
      (g) => g.name == s,
      orElse: () => Gender.preferNotToSay,
    );
  }

  AppointmentStatus _statusFromString(String s){
    return AppointmentStatus.values.firstWhere(
      (st) => st.name == s,
      orElse: () => AppointmentStatus.scheduled,
    );
  }
}