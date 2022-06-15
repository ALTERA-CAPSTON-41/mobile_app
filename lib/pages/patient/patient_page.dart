import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/pages/patient/form_patient_page.dart';
import 'package:capston_project/pages/queue/add_queue.dart';
import 'package:capston_project/viewModels/patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  void _onDelete(BuildContext context, String id) {
    Provider.of<PatientViewModel>(context, listen: false).deletePatient(id);
  }

  void _onUpdate(BuildContext context, PatientModel patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPatientPage(
          patient: patient,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen1,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPatientPage()));
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
                final patient = value.patient![index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onDelete(context, patient.id ?? "");
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onUpdate(context, patient ?? PatientModel());
                        },
                        backgroundColor: kGreen1,
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                        label: 'Update',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      patient.name ?? "",
                      style: kSubtitle.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      patient.address ?? "",
                      style: kBodyText.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddQueuePage(
                              patient: patient ?? PatientModel(),
                            ),
                          ));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
