import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:meta/meta.dart';

part 'create_vehicle_inspection_event.dart';

part 'create_vehicle_inspection_state.dart';

class CreateVehicleInspectionBloc
    extends Bloc<CreateVehicleInspectionEvent, CreateVehicleInspectionState> {
  CreateVehicleInspectionBloc() : super(CreateVehicleInspectionState()) {
    // Add all the functions and listener
  }
}
