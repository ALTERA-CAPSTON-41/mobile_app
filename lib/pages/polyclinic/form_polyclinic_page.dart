import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/viewModels/polyclinic_view_model.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormPolyclinicPage extends StatefulWidget {
  const FormPolyclinicPage({
    Key? key,
    this.polyclinic,
  }) : super(key: key);
  final Polyclinic? polyclinic;

  @override
  State<FormPolyclinicPage> createState() => _FormPolyclinicPageState();
}

class _FormPolyclinicPageState extends State<FormPolyclinicPage> {
  Polyclinic _polyclinic = Polyclinic();
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameCtrl;

  @override
  void initState() {
    _init();
    _onUpdateOrCreate();
    super.initState();
  }

  _init() {
    _nameCtrl = TextEditingController();
  }

  _onUpdateOrCreate() {
    if (widget.polyclinic != null) {
      _polyclinic = widget.polyclinic ?? Polyclinic();
      _nameCtrl?.text = widget.polyclinic?.name ?? "";
    }
  }

  _onCreate(PolyclinicViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.createPolyclinic(_polyclinic).then((ress) {
        if (value.state == RequestState.LOADED) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully created polyclinic!",
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

  _onUpdate(PolyclinicViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.updatePolyclinic(_polyclinic).then((ress) {
        if (value.state == RequestState.LOADED) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully updated polyclinic!",
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

  _getAllPoly() {
    Future.microtask(() =>
        Provider.of<PolyclinicViewModel>(context, listen: false)
            .getAllPolyclinic());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _getAllPoly();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Poliklinik"),
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
                      _polyclinic.name = value;
                    },
                    label: "Nama Poli",
                    formatters: [
                      FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Consumer<PolyclinicViewModel>(builder: (context, value, _) {
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
                          if (widget.polyclinic == null) {
                            _onCreate(value);
                          } else {
                            _onUpdate(value);
                          }
                        },
                        child: Text(
                          widget.polyclinic != null ? "Update" : "Daftar",
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
