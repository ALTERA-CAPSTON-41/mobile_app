import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/helper/helper.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/pages/medical_record/form_medical_record.dart';
import 'package:capston_project/pages/queue/patient_list.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:capston_project/viewModels/queue_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    logging("RUN INIT STATE");
    final user = Provider.of<AuthViewModel>(context, listen: false).userModel;

    if (user?.role == docotor || user?.role == nurse) {
      Future.microtask(() => Provider.of<QueueViewModel>(context, listen: false)
          .getAllQueueByPoly(doctorId: user?.id ?? "", role: user?.role ?? ""));
    } else {
      Future.microtask(() =>
          Provider.of<QueueViewModel>(context, listen: false).getAllQueue());
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = Provider.of<AuthViewModel>(context).userModel?.role;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Antrian"),
        centerTitle: true,
      ),
      floatingActionButton: Visibility(
        visible: !(role == docotor || role == nurse),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientListPage()));
          },
          backgroundColor: kGreen1,
          child: const Icon(Icons.add),
        ),
      ),
      body: Consumer<QueueViewModel>(
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
              itemCount: (role == docotor || role == nurse)
                  ? 1
                  : value.queueModel?.length ?? 0,
              itemBuilder: (context, index) {
                final QueueModel queue =
                    value.queueModel?[index] ?? QueueModel();
                return InkWell(
                  onTap: () {
                    if (role != admin && role != nurse) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormMedicalRecord(queue: queue),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xff32D8B2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: paddingOnly(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Sedang Berjalan",
                              style: kSubtitle.copyWith(
                                color: kwhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            queue.dailyQueueNumber.toString(),
                            style: kSubtitle.copyWith(
                              color: kwhite,
                              fontSize: 64,
                            ),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            queue.patient?.name ?? "",
                            style: kSubtitle.copyWith(
                              color: kwhite,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            queue.polyclinic?.name ?? "",
                            style: kSubtitle.copyWith(
                              color: kwhite,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            Helper.getKeyOrValueMapStatus(
                                queue.patientStatus, false),
                            style: kSubtitle.copyWith(
                              color: kwhite,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Nama Pasien",
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //           ),
                      //         ),
                      //         Text(
                      //           queue.patient?.name ?? "",
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         const SizedBox(height: 10.0),
                      //         Text(
                      //           "Poli",
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //           ),
                      //         ),
                      //         Text(
                      //           queue.polyclinic?.name ?? "",
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           "No Antrian",
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //           ),
                      //         ),
                      //         Text(
                      //           queue.dailyQueueNumber.toString(),
                      //           style: kSubtitle.copyWith(
                      //             color: kBlack,
                      //             fontSize: 24,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         const SizedBox(height: 10.0),
                      //       ],
                      //     ),
                      //     Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         IconButton(
                      //           onPressed: () async {
                      //             doneQueue(queue, value, role ?? "");
                      //           },
                      //           icon: const Icon(FontAwesomeIcons.stopwatch),
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      // ),
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
