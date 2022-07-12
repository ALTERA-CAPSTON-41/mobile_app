import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/nurse.dart';
import 'package:capston_project/services/nurse_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class NurseViewModel extends BaseViewModels {
  List<NurseModel>? _nurse;
  List<NurseModel>? get nurse => _nurse;

  Future<void> getAllNurse() async {
    try {
      setState(RequestState.LOADING);
      _nurse = await nurseService.getAllNurse();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createNurse(NurseModel nurse) async {
    try {
      setState(RequestState.LOADING);
      await nurseService.createNurse(nurse);
      await getAllNurse();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> updateNurse(NurseModel nurse) async {
    try {
      setState(RequestState.LOADING);
      await nurseService.updateNurse(nurse);
      await getAllNurse();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> deleteDoctor(String id) async {
    try {
      setState(RequestState.LOADING);
      await nurseService.deleteNurse(id);
      await getAllNurse();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
