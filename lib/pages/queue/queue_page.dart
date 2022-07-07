import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/pages/medical_record/form_medical_record.dart';
import 'package:capston_project/pages/queue/patient_list.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:capston_project/viewModels/queue_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          .getAllQueueByPoly(doctorId: user?.id ?? ""));
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
              itemCount: value.queueModel?.length ?? 0,
              itemBuilder: (context, index) {
                final QueueModel queue = value.queueModel![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormMedicalRecord(queue: queue),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: kGreen2,
                    child: Padding(
                      padding: paddingOnly(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Pasien",
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                ),
                              ),
                              Text(
                                queue.patient?.name ?? "",
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                "Poli",
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                ),
                              ),
                              Text(
                                queue.polyclinic?.name ?? "",
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "No Antrian",
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                ),
                              ),
                              Text(
                                queue.dailyQueueNumber.toString(),
                                style: kSubtitle.copyWith(
                                  color: kBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  queue.serviceDoneAt =
                                      DateTime.now().toString();
                                  await value.doneQueue(queue);
                                },
                                icon: const Icon(FontAwesomeIcons.stopwatch),
                              ),
                            ],
                          )
                        ],
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
