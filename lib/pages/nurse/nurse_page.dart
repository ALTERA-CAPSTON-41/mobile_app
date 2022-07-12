import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/models/nurse.dart';
import 'package:capston_project/pages/doctors/form_doctor_page.dart';
import 'package:capston_project/pages/nurse/form_nurse_page.dart';
import 'package:capston_project/viewModels/doctor_view_model.dart';
import 'package:capston_project/viewModels/nurse_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class NursePage extends StatefulWidget {
  const NursePage({Key? key}) : super(key: key);

  @override
  State<NursePage> createState() => _NursePageState();
}

class _NursePageState extends State<NursePage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    Future.microtask(() =>
        Provider.of<NurseViewModel>(context, listen: false).getAllNurse());
  }

  _onDelete(BuildContext context, String id) {
    Provider.of<NurseViewModel>(context, listen: false).deleteDoctor(id);
  }

  _onUpdate(BuildContext context, NurseModel nurse) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormNursePage(
          nurse: nurse,
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
              MaterialPageRoute(builder: (context) => const FormNursePage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Data Perawat"),
        centerTitle: true,
      ),
      body: Consumer<NurseViewModel>(
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
              itemCount: value.nurse?.length ?? 0,
              itemBuilder: (context, index) {
                final nurse = value.nurse?[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onDelete(context, nurse?.id ?? "");
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onUpdate(context, nurse ?? NurseModel());
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
                      nurse?.name ?? "",
                      style: kSubtitle.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      nurse?.address ?? "",
                      style: kBodyText.copyWith(
                        color: Colors.grey,
                      ),
                    ),
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
