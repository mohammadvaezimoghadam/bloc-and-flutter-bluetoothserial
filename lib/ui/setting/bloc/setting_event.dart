part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingStarted extends SettingEvent{
  final BluetoothState bluetoothState;
  

  const SettingStarted(this.bluetoothState, );
  @override
  // TODO: implement props
  List<Object> get props => [bluetoothState,];

}
class SettingClose extends SettingEvent{
  
}
class SettingEnableBluetooth extends SettingEvent{
 final  bool switchValue;
 final BluetoothState bluetoothState;

  SettingEnableBluetooth(this.switchValue, this.bluetoothState);
  @override
  // TODO: implement props
  List<Object> get props => [switchValue,bluetoothState];

}

class SettingDropdownItemSelected extends SettingEvent{
  final BluetoothDevice device;
  final BluetoothState bluetoothState;

  SettingDropdownItemSelected(this.device, this.bluetoothState);
  @override
  // TODO: implement props
  List<Object> get props => [device,bluetoothState];
}

class SettingConnectionBtnClicked extends SettingEvent{
  
  final BluetoothState bluetoothState;

  SettingConnectionBtnClicked( this.bluetoothState);
  @override
  // TODO: implement props
  List<Object> get props => [bluetoothState];

}
class SettingBluStateChanged extends SettingEvent{
  final BluetoothState bluetoothState;
  

  SettingBluStateChanged(this.bluetoothState);
  @override
  // TODO: implement props
  List<Object> get props => [bluetoothState];
}
