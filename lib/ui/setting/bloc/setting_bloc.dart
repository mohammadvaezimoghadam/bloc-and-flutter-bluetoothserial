import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_blutooth/data/datasource/blu_data_source.dart';
import 'package:test_blutooth/data/repo/blu_repository.dart';

import 'setting_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

final ValueNotifier<BluetoothState> bluStateNotifier =
    ValueNotifier(_bluetoothState);
final ValueNotifier<BluetoothConnection?> connectionNotifier =
    ValueNotifier(null);

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingLoading()) {
    on<SettingEvent>((event, emit) async {
      if (event is SettingStarted) {
        final bluetoothState = event.bluetoothState;
        if (bluetoothState == BluetoothState.STATE_OFF) {
          emit(SettingBluetoothRequired());
        } else {
          await getBluetoothState();
          final BluetoothDevice? dropdownValue = await _getDeviceSelected();
          final List<DropdownMenuItem<BluetoothDevice>> dropdownItems =
              await _getDeviceItems();
          final bool connectionState = await _getConnectionState();
          emit(SettingSuccess(
            dropdownItems,
            connectionState,
            dropdownValue,
          ));
        }
      } else if (event is SettingDropdownItemSelected) {
        final bluetoothState = event.bluetoothState;
        if (bluetoothState == BluetoothState.STATE_OFF) {
          emit(SettingBluetoothRequired());
        } else {
          await setDeviceSelected(event.device);
          final BluetoothDevice? dropdownValue = await _getDeviceSelected();
          final List<DropdownMenuItem<BluetoothDevice>> dropdownItems =
              await _getDeviceItems();
          final bool connectionState = await _getConnectionState();
          emit(SettingSuccess(dropdownItems, connectionState, dropdownValue));
        }
      } else if (event is SettingConnectionBtnClicked) {
        final bluetoothState = event.bluetoothState;
        if (bluetoothState == BluetoothState.STATE_OFF) {
          emit(SettingBluetoothRequired());
        } else {
          try {
            emit(SettingLoading());
            final BluetoothDevice? dropdownValue = await _getDeviceSelected();
            final List<DropdownMenuItem<BluetoothDevice>> dropdownItems =
                await _getDeviceItems();
            await _connectionState();
            final bool connectionState = await _getConnectionState();

            emit(SettingSuccess(dropdownItems, connectionState, dropdownValue));
          } catch (e) {
            emit(SettingErrore());
          }
        }
      } else if (event is SettingClose) {
        dispose();
      } else if (event is SettingBluStateChanged) {
        final bluetoothState = event.bluetoothState;
        if (bluetoothState == BluetoothState.STATE_OFF) {
          emit(SettingBluetoothRequired());
        } else {
          try {
            await getBluetoothState();
            final BluetoothDevice? dropdownValue = await _getDeviceSelected();
            final List<DropdownMenuItem<BluetoothDevice>> dropdownItems =
                await _getDeviceItems();
            await _connectionState();
            final bool connectionState = await _getConnectionState();
            final bool bluetoothEnable = await getEnableBluetooth();
            emit(SettingSuccess(dropdownItems, connectionState, dropdownValue));
          } catch (e) {}
        }
      }
    });
  }

//connection

}

BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
BluetoothConnection? connection;
List<BluetoothDevice> _devicesList = [];
bool isDisconnecting = false;
bool _connected = false;
bool _isButtonUnavailable = false;
int? _deviceState = null;
BluetoothDevice? _device;
bool get isConnected => connection != null && connection!.isConnected;
String a = "";

Future<void> getBluetoothState() async {
  await _bluetoothSerial.state.then((state) async {
    _bluetoothState = state;
    bluStateNotifier.value = state;
    if (_bluetoothState == BluetoothState.STATE_ON) {
      await getPairedDevices();
    }
  });
  _deviceState = 0;

  _bluetoothSerial.onStateChanged().listen((state) async {
    _bluetoothState = state;
    bluStateNotifier.value = state;
    if (_bluetoothState == BluetoothState.STATE_ON) {
      await getPairedDevices();
    }
  });
}

Future<bool> getEnableBluetooth() async {
  if (_bluetoothState == BluetoothState.STATE_ON) {
    return false;
  } else {
    return true;
  }
}

Future<void> setDeviceSelected(BluetoothDevice device) async {
  _device = device;
}

Future<void> enableBluetooth() async {
  _bluetoothState = await _bluetoothSerial.state;

  if (_bluetoothState == BluetoothState.STATE_OFF) {
    await _bluetoothSerial.requestEnable();
    await getPairedDevices();
  } else {
    await getPairedDevices();
  }
}

Future<void> getPairedDevices() async {
  List<BluetoothDevice> devices = [];
  try {
    devices = await _bluetoothSerial.getBondedDevices();
  } catch (e) {}
  _devicesList = devices;
}

void dispose() {
  if (isConnected) {
    isDisconnecting = true;
    connection!.dispose();
    connection = null;
  }
}

Future<List<DropdownMenuItem<BluetoothDevice>>> _getDeviceItems() async {
  List<DropdownMenuItem<BluetoothDevice>> items = [];
  if (_devicesList.isEmpty) {
    items.add(DropdownMenuItem(child: Text('خالی')));
  } else {
    _devicesList.forEach((device) {
      items.add(DropdownMenuItem(
        child: Text(device.name.toString()),
        value: device,
      ));
    });
  }
  return items;
}

Future<void> _deviceSelected(DropdownMenuItem<BluetoothDevice> device) async {
  _device = device.value;
}

Future<BluetoothDevice?> _getDeviceSelected() async {
  if (_devicesList.isNotEmpty) {
    return _device;
  } else {
    return null;
  }
}

Future<void> _connectionState() async {
  _isButtonUnavailable
      ? null
      : _connected
          ? await _disconnect()
          : await _connect();
}

Future<bool> _getConnectionState() async {
  return _connected ? true : false;
}

Future<void> _connect() async {
  if (_device == null) {
    //show errore
  } else {
    if (!isConnected) {
      await BluetoothConnection.toAddress(_device!.address).then((value) {
        connection = value;
        _connected = true;
        setConnection();
      });
    }
  }
}

Future<void> _disconnect() async {
  connection!.close();
  //connection = null;
  if (!connection!.isConnected) {
    _connected = false;
  }
  connection = null;
  setConnection();
}

BluetoothConnection? getConnection() {
  return connection != null ? connection : null;
}

Future<void> setConnection() async {
  connectionNotifier.value = connection;
}
