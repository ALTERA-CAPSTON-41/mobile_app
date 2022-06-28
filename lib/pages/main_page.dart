import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/pages/admin/admin_page.dart';
import 'package:capston_project/pages/components/card_menu_item.dart';
import 'package:capston_project/pages/doctors/doctor_page.dart';
import 'package:capston_project/pages/patient/patient_page.dart';
import 'package:capston_project/pages/polyclinic/polyclinic_page.dart';
import 'package:capston_project/pages/queue/queue_page.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<AuthViewModel>(context, listen: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final role = Provider.of<AuthViewModel>(context).userModel?.role;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hallo, ${Provider.of<AuthViewModel>(context).userModel?.role ?? "Guest"}",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: paddingOnly(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: role == admin,
                  child: CradMenuItem(
                    title: "Dokter",
                    iconData: FontAwesomeIcons.houseMedical,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorPage(),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: role == admin || role == docotor || role == nurse,
                  child: CradMenuItem(
                    title: "Pasien",
                    iconData: FontAwesomeIcons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PatientPage(),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: role == admin || role == docotor || role == nurse,
                  child: CradMenuItem(
                    title: "Antrian",
                    iconData: FontAwesomeIcons.clipboardList,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QueuePage(),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: role == admin,
                  child: CradMenuItem(
                    title: "Poliklinik",
                    iconData: FontAwesomeIcons.house,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PolyclinicPage(),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: role == admin || role == docotor || role == nurse,
                  child: CradMenuItem(
                    title: "Rekam Medis",
                    iconData: FontAwesomeIcons.bookMedical,
                    onTap: () {},
                  ),
                ),
                Visibility(
                  visible: role == admin,
                  child: CradMenuItem(
                    title: "Admin",
                    iconData: FontAwesomeIcons.personCircleCheck,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
