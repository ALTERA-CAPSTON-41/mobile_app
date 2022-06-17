import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/viewModels/queue_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
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
    Future.microtask(() =>
        Provider.of<QueueViewModel>(context, listen: false).getAllQueue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Antrian"),
        centerTitle: true,
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
                final queue = value.queueModel![index];
                return Container(
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
