import 'package:capston_project/common/const.dart';
import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/models/nurse.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/doctor_service.dart';
import 'package:capston_project/services/nurse_service.dart';
import 'package:capston_project/services/queue_services.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class QueueViewModel extends BaseViewModels {
  List<QueueModel>? _queueModel;
  List<QueueModel>? get queueModel => _queueModel;

  Future<void> getAllQueue() async {
    try {
      setState(RequestState.LOADING);
      _queueModel = await queueServices.getAllQueue();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> getAllQueueByPoly({
    required String doctorId,
    required String role,
  }) async {
    try {
      DoctorModel doctorPolyId;
      NurseModel nursePolyId;
      setState(RequestState.LOADING);

      if (role == docotor) {
        doctorPolyId = await doctorService.getDoctorByID(
          doctorId: doctorId,
        );

        _queueModel = await queueServices.getAllQueueByPoli(
          polyId: doctorPolyId.polyclinic?.id ?? 0,
        );
      } else if (role == nurse) {
        nursePolyId = await nurseService.getNurseByID(
          nurseId: doctorId,
        );

        _queueModel = await queueServices.getAllQueueByPoli(
          polyId: nursePolyId.polyclinic?.id ?? 0,
        );
      }

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createQueue(QueueModel queue) async {
    try {
      setState(RequestState.LOADING);
      await queueServices.createQueue(queue);
      getAllQueue();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> doneQueue(QueueModel queue) async {
    try {
      setState(RequestState.LOADING);
      await queueServices.doneQueue(queue);
      getAllQueue();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
