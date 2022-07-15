import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/extensions/ext.dart';
import 'package:capston_project/models/admin.dart';
import 'package:capston_project/viewModels/admin_view_model.dart';
import 'package:capston_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminFormPage extends StatefulWidget {
  const AdminFormPage({
    Key? key,
    this.admin,
  }) : super(key: key);

  final AdminModel? admin;

  @override
  State<AdminFormPage> createState() => _AdminFormPageState();
}

class _AdminFormPageState extends State<AdminFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameCtrl;
  TextEditingController? _nipCtrl;
  TextEditingController? _emailCtrl;
  TextEditingController? _passwordCtrl;
  AdminModel _admin = AdminModel();

  _init() {
    _nameCtrl = TextEditingController();
    _nipCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  _onCreate(AdminViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.createAdmin(_admin).then((ress) {
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

  _onUpdate(AdminViewModel value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await value.updateAdmin(_admin).then((ress) {
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

  _onUpdateOrCreate() {
    if (widget.admin != null) {
      _admin = widget.admin ?? AdminModel();
      _nameCtrl?.text = widget.admin?.name ?? "";
      _nipCtrl?.text = widget.admin?.nip ?? "";
      _emailCtrl?.text = widget.admin?.email ?? "";
      _passwordCtrl?.text = widget.admin?.password ?? "";
    }
  }

  @override
  void initState() {
    _init();
    _onUpdateOrCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Admin"),
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
                    _admin.email = value;
                  },
                  isEnabled: widget.admin == null,
                  label: "Email",
                ),
                Visibility(
                  visible: widget.admin == null,
                  child: const SizedBox(height: 12),
                ),
                Visibility(
                  visible: widget.admin == null,
                  child: TextFieldWidget(
                    controller: _passwordCtrl ?? TextEditingController(),
                    onChange: (value) {
                      _admin.password = value;
                    },
                    label: "Password",
                  ),
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _nameCtrl ?? TextEditingController(),
                  onChange: (value) {
                    _admin.name = value;
                  },
                  formatters: [
                    FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                  ],
                  label: "Nama Admin",
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: _nipCtrl ?? TextEditingController(),
                  onChange: (value) {
                    _admin.nip = value;
                  },
                  label: "NIP",
                ),
                const SizedBox(height: 12),
                Consumer<AdminViewModel>(builder: (context, value, _) {
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
                        if (widget.admin == null) {
                          _onCreate(value);
                        } else {
                          _onUpdate(value);
                        }
                      },
                      child: Text(
                        widget.admin != null ? "Update" : "Daftar",
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
