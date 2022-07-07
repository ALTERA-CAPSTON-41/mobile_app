import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/viewModels/medical_rcord_view_model.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({Key? key}) : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  TextEditingController? _serachCtrl;
  _init() {
    _serachCtrl = TextEditingController();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Rekam Medis"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              TextFieldWidget(
                controller: _serachCtrl ?? TextEditingController(),
                onChange: (value) {},
                label: "Cari...",
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    Provider.of<MedicalRecordViewModel>(context, listen: false)
                        .getMedicalRecByNik(nik: _serachCtrl?.text ?? "");
                  },
                  child: Text(
                    "Cari",
                    style: kBodyText.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Consumer<MedicalRecordViewModel>(
                builder: (context, value, _) {
                  if (value.state == RequestState.LOADING) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (value.state == RequestState.ERROR) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: Text(value.errMsg),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        itemCount: value.medicalRec?.length ?? 0,
                        itemBuilder: (context, index) {
                          final medRec = value.medicalRec![index];
                          return Card(
                            margin: const EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: paddingAll(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Data Medical Record Pasien",
                                      style: kBodyText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: kBlack,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(thickness: 2),
                                  const SizedBox(height: 20),
                                  dataMedicalRec(
                                    "Nama Patient",
                                    medRec.patient?.name ?? "",
                                  ),
                                  dataMedicalRec(
                                    "NIK",
                                    medRec.patient?.nik ?? "",
                                  ),
                                  dataMedicalRec(
                                    "Poli",
                                    medRec.polyclinic?.name ?? "",
                                  ),
                                  dataMedicalRec(
                                    "Keluhan",
                                    medRec.symptoms ?? "",
                                  ),
                                  dataMedicalRec(
                                    "Saran",
                                    medRec.suggestions ?? "",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataMedicalRec(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: kBodyText.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: kBlack,
          ),
        ),
        Text(
          value,
          style: kBodyText.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: kGreen1,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
