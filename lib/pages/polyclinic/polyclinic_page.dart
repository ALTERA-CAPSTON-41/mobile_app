import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/pages/polyclinic/form_polyclinic_page.dart';
import 'package:capston_project/viewModels/polyclinic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PolyclinicPage extends StatefulWidget {
  const PolyclinicPage({Key? key}) : super(key: key);

  @override
  State<PolyclinicPage> createState() => _PolyclinicPageState();
}

class _PolyclinicPageState extends State<PolyclinicPage> {
  _init() {
    Future.microtask(() =>
        Provider.of<PolyclinicViewModel>(context, listen: false)
            .getAllPolyclinic());
  }

  _onDelete(BuildContext context, String id) {
    Provider.of<PolyclinicViewModel>(context, listen: false)
        .deletePolyclinic(id);
  }

  _onUpdate(BuildContext context, Polyclinic polyclinic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPolyclinicPage(
          polyclinic: polyclinic,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormPolyclinicPage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Data Poliklinik"),
        centerTitle: true,
      ),
      body: Consumer<PolyclinicViewModel>(
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
              itemCount: value.polyclinic?.length ?? 0,
              itemBuilder: (context, index) {
                final poly = value.polyclinic?[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onDelete(context, poly!.id.toString());
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          _onUpdate(context, poly ?? Polyclinic());
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
                      poly?.name ?? "",
                      style: kSubtitle.copyWith(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
