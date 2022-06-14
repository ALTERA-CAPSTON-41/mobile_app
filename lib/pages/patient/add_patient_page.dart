import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/viewModels/patient_view_model.dart';
import 'package:capston_project/widgets/date_picker.dart';
import 'package:capston_project/widgets/drop_down_widget.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({Key? key}) : super(key: key);

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final PatientModel _patient = PatientModel();
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameCtrl;
  TextEditingController? _nikCtrl;
  TextEditingController? _phoneCtrl;
  TextEditingController? _addressCtrl;
  TextEditingController? _dobCtrl;
  TextEditingController? _genderCtrl;
  TextEditingController? _blodTypeCtrl;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _nameCtrl = TextEditingController();
    _nikCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _dobCtrl = TextEditingController();
    _genderCtrl = TextEditingController();
    _blodTypeCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pasien"),
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
              children: [
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: _nameCtrl ?? TextEditingController(),
                  onChange: (value) {
                    _patient.name = value;
                  },
                  label: "Nama Pasien",
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _nikCtrl ?? TextEditingController(),
                  onChange: (value) {
                    _patient.nik = value;
                  },
                  label: "NIK",
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _phoneCtrl ?? TextEditingController(),
                  onChange: (value) {
                    _patient.phone = value;
                  },
                  label: "Nomor Telepon",
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _addressCtrl ?? TextEditingController(),
                  maxLength: 3,
                  minLength: 3,
                  onChange: (value) {
                    _patient.address = value;
                  },
                  label: "Alamat",
                ),
                const SizedBox(height: 12),
                DateFieldWidget(
                  label: "Tanggal Lahir",
                  onChanged: (value) {
                    _patient.dob = value;
                  },
                  dateController: _dobCtrl ?? TextEditingController(),
                ),
                const SizedBox(height: 12),
                DropdowndSearchWidget(
                  controller: _blodTypeCtrl ?? TextEditingController(),
                  items: const ["A", "B", "AB", "O"],
                  label: "Golongan Darah",
                  onChanged: (value) {
                    _patient.bloodType = value;
                  },
                ),
                const SizedBox(height: 12),
                DropdowndSearchWidget(
                  controller: _genderCtrl ?? TextEditingController(),
                  items: const ["Laki laki", "Perempuan"],
                  label: "Jenis Kelamin",
                  onChanged: (value) {
                    _patient.gender = value;
                  },
                ),
                const SizedBox(height: 12),
                Consumer<PatientViewModel>(builder: (context, value, _) {
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
                          _formKey.currentState!.save();
                          await value.createPatient(_patient).then((ress) {
                            if (value.state == RequestState.LOADED) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Successfully created patient!",
                                  style: kBodyText.copyWith(
                                    color: kwhite,
                                  ),
                                ),
                                backgroundColor: kGreen1,
                                duration: const Duration(seconds: 1),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                        "Daftar",
                        style: kBodyText.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
