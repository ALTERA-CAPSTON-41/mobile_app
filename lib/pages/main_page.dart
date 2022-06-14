import 'package:capston_project/common/const.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/pages/components/card_menu_item.dart';
import 'package:capston_project/pages/patient/patient_page.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingOnly(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "Daftar Pasien",
                style: kHeading6.copyWith(
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 10),
              CradMenuItem(
                iconData: Icons.person_add,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                "Rekam Medis",
                style: kHeading6.copyWith(
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 10),
              CradMenuItem(
                iconData: Icons.add_box_sharp,
                onTap: () {},
              ),
              const SizedBox(height: 30),
              Text(
                "Bantuan",
                style: kHeading6.copyWith(
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 10),
              CradMenuItem(
                iconData: Icons.help_center,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
