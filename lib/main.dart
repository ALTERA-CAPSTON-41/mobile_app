import 'package:capston_project/common/const.dart';
import 'package:capston_project/pages/auth/sign_in.dart';
import 'package:capston_project/viewModels/admin_view_model.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:capston_project/viewModels/doctor_view_model.dart';
import 'package:capston_project/viewModels/medical_rcord_view_model.dart';
import 'package:capston_project/viewModels/patient_view_model.dart';
import 'package:capston_project/viewModels/polyclinic_view_model.dart';
import 'package:capston_project/viewModels/queue_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PatientViewModel()),
        ChangeNotifierProvider(create: (_) => DoctorViewModel()),
        ChangeNotifierProvider(create: (_) => PolyclinicViewModel()),
        ChangeNotifierProvider(create: (_) => QueueViewModel()),
        ChangeNotifierProvider(create: (_) => AdminViewModel()),
        ChangeNotifierProvider(create: (_) => PolyclinicViewModel()),
        ChangeNotifierProvider(create: (_) => MedicalRecordViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(colorScheme: kColorScheme),
        debugShowCheckedModeBanner: false,
        home: const SignInPage(),
      ),
    );
  }
}
