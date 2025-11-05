# Hospital Appointment Management System

A **console-based** hospital management tool written in **Dart**.  
Allows admins to add patients/doctors, schedule/cancel appointments, view schedules, and persist data in a **pretty-printed JSON** file.

---

## Features

- Add Patient / Doctor
- Schedule Appointment (with conflict check)
- Cancel Appointment
- View Patient or Doctor Schedule
- Data saved to `hospital_data.json` (human-readable)
- Unit tested (9 passing tests)
- Clean domain model with polymorphism

---

## Project Structure
lib/
├── domain/       Patient, Doctor, Appointment, Hospital, Staff
├── data/         HospitalRepository (JSON load/save)
├── ui/           HospitalUI (console menu)
└── main.dart     Entry point
test/             Unit tests

Run: dart run lib/ui/main.dart
Test: dart test

Data: hospital_data.json
UML: uml/hospital_uml.png