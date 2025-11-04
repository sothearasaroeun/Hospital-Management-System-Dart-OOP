enum Gender {male, female, preferNotToSay}

class WorkingHours{
  final DateTime start;
  final DateTime end;

  WorkingHours({required this.start, required this.end});
}

class Staff {
  final String _id;
  final String _name;
  final String _role;
  final String _phoneNumber;
  final String _email;
  final DateTime _dob;
  final Gender _gender;
  final Map<DateTime, WorkingHours> workingHours;


  Staff(this._id, this._name, this._role, this._phoneNumber, this._email,this._dob, this._gender, this.workingHours);

  String get id => _id;
  String get name => _name;
  String get role => _role;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  DateTime  get dob => _dob;
  Gender get gender => _gender;
  Map<DateTime, WorkingHours> get getWorkingHours => workingHours;

}