part of 'vehicle_inspection_bloc.dart';

class VehicleInspectionState extends Equatable {
  VehicleInspectionState({
    this.make = const BasicInfo.pure(),
    this.model = const BasicInfo.pure(),
    this.photo = const BasicInfo.pure(),
    DateTime? inspectionDate,
    this.identificationNumber = const BasicInfo.pure(),
    this.status = FormzStatus.pure,
  }) : inspectionDate = inspectionDate ?? DateTime(2022);

  final BasicInfo make;
  final BasicInfo model;
  final BasicInfo photo;
  final DateTime inspectionDate;
  final BasicInfo identificationNumber;
  final FormzStatus status;

  @override
  List<Object> get props => [
        make,
        model,
        photo,
        inspectionDate,
        identificationNumber,
        status,
      ];

  VehicleInspectionState copyWith({
    BasicInfo? make,
    BasicInfo? model,
    BasicInfo? photo,
    BasicInfo? identificationNumber,
    DateTime? inspectionDate,
    FormzStatus? status,
  }) {
    return VehicleInspectionState(
      make: make ?? this.make,
      model: model ?? this.model,
      photo: photo ?? this.photo,
      inspectionDate: inspectionDate ?? this.inspectionDate,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      status: status ?? this.status,
    );
  }
}
