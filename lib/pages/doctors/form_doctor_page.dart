import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/helper/helper.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/viewModels/doctor_view_model.dart';
import 'package:capston_project/viewModels/polyclinic_view_model.dart';
import 'package:capston_project/widgets/date_picker.dart';
import 'package:capston_project/widgets/drop_down_widget.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormDoctorPage extends StatefulWidget {
  const FormDoctorPage({
    Key? key,
    this.doctor,
  }) : super(key: key);

  final DoctorModel? doctor;

  @override
  State<FormDoctorPage> createState() => _FormDoctorPageState();
}

class _FormDoctorPageState extends State<FormDoctorPage> {
  final _formKey = GlobalKey<FormState>();

  DoctorModel _doctor = DoctorModel();
  Polyclinic? _selectedPolyclinic;

  TextEditingController? _nameCtrl;
  TextEditingController? _nipCtrl;
  TextEditingController? _sipCtrl;
  TextEditingController? _polyCtrl;
  TextEditingController? _addressCtrl;
  TextEditingController? _dobCtrl;
  TextEditingController? _genderCtrl;
  TextEditingController? _emailCtrl;
  TextEditingController? _passwordCtrl;

  _init() {
    _nameCtrl = TextEditingController();
    _nipCtrl = TextEditingController();
    _sipCtrl = TextEditingController();
    _polyCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _dobCtrl = TextEditingController();
    _genderCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  _onUpdateOrCreate() {
    if (widget.doctor != null) {
      _doctor = widget.doctor ?? DoctorModel();
      _nameCtrl?.text = widget.doctor?.name ?? "";
      _emailCtrl?.text = widget.doctor?.email ?? "";
      _nipCtrl?.text = widget.doctor?.nip ?? "";
      _sipCtrl?.text = widget.doctor?.sip ?? "";
      _polyCtrl?.text = widget.doctor?.polyclinic?.name ?? "";
      _addressCtrl?.text = widget.doctor?.address ?? "";
      _dobCtrl?.text = widget.doctor?.dob?.toString() ?? "";
      _genderCtrl?.text =
          Helper.getKeyOrValueMapGender(widget.doctor?.gender, false);
      _selectedPolyclinic = widget.doctor?.polyclinic;
    }
  }

  _onCreate(DoctorViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.createDoctor(_doctor).then((ress) {
        if (value.state == RequestState.LOADED) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully created doctor!",
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

  _onUpdate(DoctorViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.updateDoctor(_doctor).then((ress) {
        if (value.state == RequestState.LOADED) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully updated doctor!",
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

  Future<List<Polyclinic>> _getPolyclinic() async {
    PolyclinicViewModel viewModel = Provider.of<PolyclinicViewModel>(
      context,
      listen: false,
    );
    await viewModel.getAllPolyclinic();
    return viewModel.polyclinic ?? <Polyclinic>[];
  }

  _getAllPolyclinic() async {
    Future.microtask(() =>
        Provider.of<DoctorViewModel>(context, listen: false).getAllDoctor());
  }

  @override
  void initState() {
    _init();
    _onUpdateOrCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _getAllPolyclinic();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Dokter"),
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
                    controller: _emailCtrl ?? TextEditingController(),
                    onChange: (value) {
                      _doctor.email = value;
                    },
                    isEmail: true,
                    isEnabled: widget.doctor == null,
                    label: "Email",
                  ),
                  Visibility(
                    visible: widget.doctor == null,
                    child: const SizedBox(height: 12),
                  ),
                  Visibility(
                    visible: widget.doctor == null,
                    child: TextFieldWidget(
                      controller: _passwordCtrl ?? TextEditingController(),
                      obscureText: true,
                      onChange: (value) {
                        _doctor.password = value;
                      },
                      label: "Password",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    controller: _nameCtrl ?? TextEditingController(),
                    onChange: (value) {
                      _doctor.name = value;
                    },
                    label: "Nama Dokter",
                    formatters: [
                      FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    controller: _nipCtrl ?? TextEditingController(),
                    onChange: (value) {
                      _doctor.nip = value;
                    },
                    label: "NIP",
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    controller: _sipCtrl ?? TextEditingController(),
                    onChange: (value) {
                      _doctor.sip = value;
                    },
                    label: "SIP",
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    controller: _addressCtrl ?? TextEditingController(),
                    maxLength: 3,
                    minLength: 3,
                    onChange: (value) {
                      _doctor.address = value;
                    },
                    label: "Alamat",
                  ),
                  const SizedBox(height: 12),
                  DateFieldWidget(
                    label: "Tanggal Lahir",
                    onChanged: (value) {
                      _doctor.dob = value;
                    },
                    dateController: _dobCtrl ?? TextEditingController(),
                  ),
                  const SizedBox(height: 12),
                  DropdowndSearchWidget(
                    controller: _genderCtrl ?? TextEditingController(),
                    items: const ["PEREMPUAN", "LAKI-LAKI"],
                    label: "Jenis Kelamin",
                    onChanged: (value) {
                      _doctor.gender = Helper.getKeyOrValueMapGender(value);
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownSearchApiWidget(
                    controller: _polyCtrl ?? TextEditingController(),
                    onChanged: (value) {
                      _selectedPolyclinic = value;
                      _doctor.polyclinic = value;
                    },
                    onFind: _getPolyclinic,
                    label: "Poliklinik",
                    selectedItem: _selectedPolyclinic,
                  ),
                  const SizedBox(height: 12),
                  Consumer<DoctorViewModel>(builder: (context, value, _) {
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
                          if (widget.doctor == null) {
                            _onCreate(value);
                          } else {
                            _onUpdate(value);
                          }
                        },
                        child: Text(
                          widget.doctor != null ? "Update" : "Daftar",
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
      ),
    );
  }
}
