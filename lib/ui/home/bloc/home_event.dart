part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {
   final BluetoothConnection? connection;

  const HomeStarted(this.connection);
}

class HomeClosed extends HomeEvent {}

class HomeConnectionBtnIsClicek extends HomeEvent {}
class HomeConnectionChanged extends HomeEvent{
  final BluetoothConnection? connection;

  const HomeConnectionChanged(this.connection);
}
