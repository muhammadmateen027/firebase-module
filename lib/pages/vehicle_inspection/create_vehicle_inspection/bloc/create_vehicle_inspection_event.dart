part of 'create_vehicle_inspection_bloc.dart';

@immutable
abstract class CreateVehicleInspectionEvent {}

class DateChangedEvent extends CreateVehicleInspectionEvent {}

class IdentificationNumberChangedEvent extends CreateVehicleInspectionEvent {
  IdentificationNumberChangedEvent(this.identificationNumber);

  final String identificationNumber;
}

class VehicleMakeEvent extends CreateVehicleInspectionEvent {
  VehicleMakeEvent(this.make);

  final BasicInfo make;
}

class VehicleModelEvent extends CreateVehicleInspectionEvent {
  VehicleModelEvent(this.model);

  final BasicInfo model;
}

class VehiclePhotoEvent extends CreateVehicleInspectionEvent {
  VehiclePhotoEvent(this.photo);

  final BasicInfo photo;
}
