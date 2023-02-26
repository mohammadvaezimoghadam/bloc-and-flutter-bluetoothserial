part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingLoading extends SettingState {}

class SettingErrore extends SettingState {}

class SettingSuccess extends SettingState {
  final List<DropdownMenuItem<BluetoothDevice>> dropdownItems;
  final BluetoothDevice? dropdownValue;
  final bool connectionState;

  const SettingSuccess( this.dropdownItems, this.connectionState,
      this.dropdownValue);
  @override
  
  List<Object> get props =>
      [ dropdownItems, connectionState];
}

class SettingBluetoothRequired extends SettingState {}
