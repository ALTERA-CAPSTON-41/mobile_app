import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/icd_model.dart';
import 'package:capston_project/models/medical_record.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/medical_record_service.dart';
import 'package:capston_project/viewModels/medical_rcord_view_model.dart';
import 'package:capston_project/widgets/drop_down_widget.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormMedicalRecord extends StatefulWidget {
  const FormMedicalRecord({
    Key? key,
    required this.queue,
  }) : super(key: key);

  final QueueModel? queue;

  @override
  State<FormMedicalRecord> createState() => _FormMedicalRecordState();
}

class _FormMedicalRecordState extends State<FormMedicalRecord> {
  final _formKey = GlobalKey<FormState>();
  MedicalRecordModel? _medical;

  TextEditingController? _lcdCtrl;
  TextEditingController? _gejalaCtrl;
  TextEditingController? _rekomCtrl;

  _init() {
    _medical = MedicalRecordModel();
    _lcdCtrl = TextEditingController();
    _rekomCtrl = TextEditingController();
    _rekomCtrl = TextEditingController();
    _medical?.patientId = widget.queue?.patient?.id;
    _medical?.polyId = widget.queue?.polyclinic?.id;
  }

  IcdModel? selectedIcd;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _onCreate(MedicalRecordViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value
          .createMedicalRecord(_medical ?? MedicalRecordModel())
          .then((ress) {
        if (value.state == RequestState.LOADED) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully created medical record!",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Medical Record"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: paddingOnly(
            left: 20.0,
            right: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _dataPatient(),
                const SizedBox(height: 12),
                DropdownSearchApiWidget(
                  controller: _lcdCtrl ?? TextEditingController(),
                  onChanged: (value) {
                    _medical?.icd10Code = value.toString();
                  },
                  onFind: () {
                    return medicalRecordService
                        .getAllIcd(_lcdCtrl?.text ?? "A70");
                  },
                  label: "ICD - 10",
                  selectedItem: selectedIcd,
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _gejalaCtrl ?? TextEditingController(),
                  maxLength: 3,
                  minLength: 3,
                  onChange: (value) {
                    _medical?.symptoms = value;
                  },
                  label: "Gejala",
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _rekomCtrl ?? TextEditingController(),
                  maxLength: 3,
                  minLength: 3,
                  onChange: (value) {
                    _medical?.suggestions = value;
                  },
                  label: "Rekomendasi",
                ),
                const SizedBox(height: 12),
                Consumer<MedicalRecordViewModel>(builder: (context, value, _) {
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
                        _onCreate(value);
                      },
                      child: Text(
                        "Tambah",
                        style: kBodyText.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataPatient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nama Pasien",
          style: kSubtitle.copyWith(
            color: kBlack,
          ),
        ),
        Text(
          widget.queue?.patient?.name ?? "",
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
          widget.queue?.polyclinic?.name ?? "",
          style: kSubtitle.copyWith(
            color: kBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "Nomor Antrian",
          style: kSubtitle.copyWith(
            color: kBlack,
          ),
        ),
        Text(
          widget.queue?.dailyQueueNumber.toString() ?? "-",
          style: kSubtitle.copyWith(
            color: kBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
