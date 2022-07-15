import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/helper/date_helper.dart';
import 'package:capston_project/helper/helper.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/pages/medical_record/medical_record_page.dart';
import 'package:capston_project/pages/patient/form_patient_page.dart';
import 'package:capston_project/viewModels/auth_view_model.dart';
import 'package:capston_project/viewModels/polyclinic_view_model.dart';
import 'package:capston_project/viewModels/queue_view_model.dart';
import 'package:capston_project/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddQueuePage extends StatefulWidget {
  const AddQueuePage({
    Key? key,
    this.isCreateQueue = false,
    this.isShowMedRicord = false,
    required this.patient,
  }) : super(key: key);

  final PatientModel patient;
  final bool isCreateQueue;
  final bool isShowMedRicord;

  @override
  State<AddQueuePage> createState() => _AddQueuePageState();
}

class _AddQueuePageState extends State<AddQueuePage> {
  @override
  Widget build(BuildContext context) {
    final role = Provider.of<AuthViewModel>(context).userModel?.role;
    final patient = widget.patient;
    return Scaffold(
      backgroundColor: kGreen1,
      appBar: AppBar(
        title: widget.isCreateQueue
            ? const Text("Buat Antrian")
            : const Text("Detail Pasien"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: paddingOnly(top: 20.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1,
          decoration: BoxDecoration(
            color: kwhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: paddingOnly(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PatientData(
                      patient: patient, isCreateQueue: widget.isCreateQueue),
                  Visibility(
                    visible: widget.isCreateQueue,
                    child: CreateQueue(patient: patient),
                  ),
                  // TODO: BTN FOR VIEW REKAM MEDIS - DOCTOR ONLY FOR ADD - ADMIN FOR VIEW
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !(widget.isCreateQueue) && widget.isShowMedRicord,
                    child: ViewMedicalRecord(widget: widget),
                  ),
                  // TODO: BTN FOR EDIT PATIENT
                  const SizedBox(height: 20),
                  Visibility(
                    visible: !(widget.isCreateQueue) &&
                        widget.isShowMedRicord &&
                        role == admin,
                    child: ButtonEditPatient(widget: widget),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewMedicalRecord extends StatelessWidget {
  const ViewMedicalRecord({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final AddQueuePage widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicalRecordPage(
                isViewMedicalRec: false,
                nikPatient: widget.patient.nik ?? "",
              ),
            ),
          );
        },
        child: Text(
          "Rekam Medis",
          style: kBodyText.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ButtonEditPatient extends StatelessWidget {
  const ButtonEditPatient({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final AddQueuePage widget;

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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          _onUpdate(context, widget.patient);
        },
        child: Text(
          "Edit patient",
          style: kBodyText.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CreateQueue extends StatefulWidget {
  const CreateQueue({
    Key? key,
    required this.patient,
  }) : super(key: key);

  final PatientModel patient;

  @override
  State<CreateQueue> createState() => _CreateQueueState();
}

class _CreateQueueState extends State<CreateQueue> {
  final _formKey = GlobalKey<FormState>();
  final QueueModel _queue = QueueModel();

  TextEditingController? _polyCtrl;
  TextEditingController? _statusCtrl;
  Polyclinic? _selectedPolyclinic;

  _init() {
    _polyCtrl = TextEditingController();
    _statusCtrl = TextEditingController();
    _queue.patient = widget.patient;
  }

  Future<List<Polyclinic>> _getPolyclinic() async {
    PolyclinicViewModel viewModel =
        Provider.of<PolyclinicViewModel>(context, listen: false);
    await viewModel.getAllPolyclinic();
    return viewModel.polyclinic ?? <Polyclinic>[];
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            "Pilih Poliklinik",
            style: kSubtitle.copyWith(
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DropdownSearchApiWidget(
            controller: _polyCtrl ?? TextEditingController(),
            onChanged: (value) {
              _selectedPolyclinic = value;
              _queue.polyclinic = value;
            },
            onFind: _getPolyclinic,
            label: "Poliklinik",
            selectedItem: _selectedPolyclinic,
          ),
          const SizedBox(height: 12),
          Text(
            "Pilih Status Pemeriksaan",
            style: kSubtitle.copyWith(
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DropdowndSearchWidget(
            controller: _statusCtrl ?? TextEditingController(),
            items: const ["RAWAT JALAN", "RUJUKAN"],
            label: "Status Pemeriksaan",
            onChanged: (value) {
              _queue.patientStatus = Helper.getKeyOrValueMapStatus(value);
            },
          ),
          const SizedBox(height: 20),
          Consumer<QueueViewModel>(
            builder: (context, value, _) {
              if (value.state == RequestState.LOADING) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      _queue.dailyQueueDate =
                          DateHelper.changeFormatIdToDateTimeFormat(
                              date: DateTime.now());
                      _formKey.currentState!.save();

                      await value.createQueue(_queue).then((ress) {
                        if (value.state == RequestState.LOADED) {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Successfully created queue!",
                              style: kBodyText.copyWith(
                                color: kwhite,
                              ),
                            ),
                            backgroundColor: kGreen1,
                            duration: const Duration(seconds: 1),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value.errMsg,
                              style: kBodyText.copyWith(
                                color: kwhite,
                              ),
                            ),
                            duration: const Duration(seconds: 1),
                          ));
                        }
                      });
                    }
                  },
                  child: Text(
                    "Buat Antrian",
                    style: kBodyText.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PatientData extends StatelessWidget {
  const PatientData({
    Key? key,
    required this.patient,
    this.isCreateQueue = false,
  }) : super(key: key);

  final PatientModel patient;
  final bool isCreateQueue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            "Biodata Pasien",
            style: kHeading5.copyWith(
              fontWeight: FontWeight.bold,
              color: kGreen1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Nama",
          style: kSubtitle.copyWith(
            color: kBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          patient.name ?? "-",
          style: kSubtitle.copyWith(
            color: const Color(0xff737373),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "NIK",
          style: kSubtitle.copyWith(
            color: kBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              patient.nik ?? "-",
              style: kSubtitle.copyWith(
                color: const Color(0xff737373),
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: patient.nik))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Copy!",
                      style: kBodyText.copyWith(
                        color: kwhite,
                      ),
                    ),
                    backgroundColor: kGreen1,
                    duration: const Duration(seconds: 1),
                  ));
                });
              },
              icon: const Icon(Icons.copy),
            )
          ],
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !isCreateQueue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanggal Lahir",
                style: kSubtitle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                patient.dob ?? "-",
                style: kSubtitle.copyWith(
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Golongan Darah",
                style: kSubtitle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                patient.bloodType ?? "-",
                style: kSubtitle.copyWith(
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Jenis Kelamin",
                style: kSubtitle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Helper.getKeyOrValueMapGender(patient.gender, false),
                style: kSubtitle.copyWith(
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "No. Telp",
                style: kSubtitle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                patient.phone ?? "-",
                style: kSubtitle.copyWith(
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Alamat",
                style: kSubtitle.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                patient.address ?? "-",
                style: kSubtitle.copyWith(
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
