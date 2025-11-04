import 'ui/hospital_management_ui.dart';
import 'domain/hospital.dart';
import 'data/hospital_repository.dart';

void main() async {
  final hospital = Hospital();
  final repo = HospitalRepository(hospital);
  await repo.load();

  await repo.save();
  print('Data saved. Existed');
}