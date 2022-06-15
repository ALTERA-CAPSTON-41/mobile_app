import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/pages/doctors/form_doctor_page.dart';
import 'package:capston_project/viewModels/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    Future.microtask(() =>
        Provider.of<DoctorViewModel>(context, listen: false).getAllDoctor());
  }

  _onDelete(BuildContext context, String id) {
    Provider.of<DoctorViewModel>(context, listen: false).deleteDoctor(id);
  }

  _onUpdate(BuildContext context, DoctorModel doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormDoctorPage(
          doctor: doctor,
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
              MaterialPageRoute(builder: (context) => const FormDoctorPage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Data Dokter"),
        centerTitle: true,
      ),
      body: Consumer<DoctorViewModel>(
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
              itemCount: value.doctor?.length ?? 0,
              itemBuilder: (context, index) {
                final doctor = value.doctor?[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onDelete(context, doctor?.id ?? "");
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onUpdate(context, doctor ?? DoctorModel());
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
                      doctor?.name ?? "",
                      style: kSubtitle.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      doctor?.address ?? "",
                      style: kBodyText.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {},
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
