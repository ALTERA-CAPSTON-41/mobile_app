import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/admin.dart';
import 'package:capston_project/services/admin_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class AdminViewModel extends BaseViewModels {
  List<AdminModel>? _adminsList;
  List<AdminModel>? get adminList => _adminsList;

  Future<void> getAllAdmin() async {
    try {
      setState(RequestState.LOADING);
      _adminsList = await adminServices.getAllAdmin();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createAdmin(AdminModel admin) async {
    try {
      setState(RequestState.LOADING);
      await adminServices.createAdmin(admin);
      getAllAdmin();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> deleteAdmin(String id) async {
    try {
      setState(RequestState.LOADING);
      await adminServices.deleteAdmin(id);
      getAllAdmin();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> updateAdmin(AdminModel admin) async {
    try {
      setState(RequestState.LOADING);
      await adminServices.updateAdmin(admin);
      getAllAdmin();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
