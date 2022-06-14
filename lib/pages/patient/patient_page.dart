import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/pages/patient/add_patient_page.dart';
import 'package:capston_project/viewModels/patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    Future.microtask(() =>
        Provider.of<PatientViewModel>(context, listen: false).getAllPatient());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen1,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPatientPage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Data Pasien"),
        centerTitle: true,
      ),
      body: Consumer<PatientViewModel>(
        builder: (context, value, _) {
          if (value.state == RequestState.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.state == RequestState.ERROR) {
            return Center(
              child: Text(value.errMsg),
            );
          } else {
            return ListView.builder(
              itemCount: value.patient?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    value.patient[index].name,
                    style: kSubtitle.copyWith(
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    value.patient[index].address,
                    style: kBodyText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
