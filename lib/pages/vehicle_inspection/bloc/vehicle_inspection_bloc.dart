import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:meta/meta.dart';

part 'vehicle_inspection_event.dart';
part 'vehicle_inspection_state.dart';

class VehicleInspectionBloc extends Bloc<VehicleInspectionEvent, VehicleInspectionState> {
  VehicleInspectionBloc() : super(VehicleInspectionState()) {

  }
}
