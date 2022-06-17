import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/admin.dart';
import 'package:capston_project/pages/admin/admin_form_page.dart';
import 'package:capston_project/viewModels/admin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  _init() {
    Future.microtask(() =>
        Provider.of<AdminViewModel>(context, listen: false).getAllAdmin());
  }

  _onDelete(BuildContext context, String id) {
    Provider.of<AdminViewModel>(context, listen: false).deleteAdmin(id);
  }

  _onUpdate(BuildContext context, AdminModel admin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminFormPage(
          admin: admin,
        ),
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen1,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminFormPage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Data Admin"),
        centerTitle: true,
      ),
      body: Consumer<AdminViewModel>(
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
              itemCount: value.adminList?.length ?? 0,
              itemBuilder: (context, index) {
                final admin = value.adminList?[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onDelete(context, admin?.id ?? "");
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onUpdate(context, admin ?? AdminModel());
                        },
                        backgroundColor: kGreen1,
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                        label: 'Update',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      admin?.name ?? "",
                      style: kSubtitle.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      admin?.nip ?? "",
                      style: kBodyText.copyWith(
                        color: Colors.grey,
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
