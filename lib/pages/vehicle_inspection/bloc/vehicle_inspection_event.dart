part of 'vehicle_inspection_bloc.dart';

@immutable
abstract class VehicleInspectionEvent {}

class DateChangedEvent extends VehicleInspectionEvent {}

class IdentificationNumberChangedEvent extends VehicleInspectionEvent {
  IdentificationNumberChangedEvent(this.identificationNumber);

  final String identificationNumber;
}

class VehicleMakeEvent extends VehicleInspectionEvent {
  VehicleMakeEvent(this.make);

  final BasicInfo make;
}

class VehicleModelEvent extends VehicleInspectionEvent {
  VehicleModelEvent(this.model);

  final BasicInfo model;
}

class VehiclePhotoEvent extends VehicleInspectionEvent {
  VehiclePhotoEvent(this.photo);

  final BasicInfo photo;
}
