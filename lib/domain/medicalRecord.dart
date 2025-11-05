import 'doctor.dart';
import 'patient.dart';

class MedicalRecord {
  Doctor doctor;
  Patient patient;
  String _diagnosis;
  String _treatment;

  MedicalRecord(this._diagnosis, this._treatment, {required this.doctor, required this.patient} );

  String get diagnosis => _diagnosis;
  String get treatment => _treatment;

  void updateMedicalRecord (String newDiagnosis, String newTreatment ) {
    _diagnosis = newDiagnosis;
    _treatment = newTreatment;
  } 

  void showRecord () {

    print(' Medical Record ');
    print(' Patient: ${patient.name}');
    print(' Doctor: ${doctor.name}');
    print(' Diagnosis: ${diagnosis}');
    print(' Treatment: ${treatment}');

  }

}
