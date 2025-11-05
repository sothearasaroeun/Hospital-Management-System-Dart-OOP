import 'ui/hospital_management_ui.dart';
import 'domain/hospital.dart';
import 'data/hospital_repository.dart';

void main() async {
  final hospital = Hospital();
  final repo = HospitalRepository(hospital);
  await repo.load();

  final ui = HospitalUI(hospital);
  await ui.run();
  
  await repo.save();
  print('Data saved to hospital_data.json');
}