part of 'new_account_bloc.dart';

abstract class NewAccountEvent extends Equatable {
  const NewAccountEvent();
  @override
  List<Object> get props => [];
}

class NewAccountHandleChanged extends NewAccountEvent {
  const NewAccountHandleChanged(this.handle);

  final Handle handle;

  @override
  List<Object> get props => [handle];
}

class NewAccountFullNameChanged extends NewAccountEvent {
  const NewAccountFullNameChanged(this.fullName);

  final FullName fullName;

  @override
  List<Object> get props => [fullName];
}

class NewAccountSubmitted extends NewAccountEvent {
  const NewAccountSubmitted(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
