import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_blutooth/data/datasource/blu_data_source.dart';
import 'package:test_blutooth/ui/home/home.dart';
import 'package:test_blutooth/ui/setting/bloc/setting_bloc.dart';

abstract class IBluRepository {
  Future<void> getData(BluetoothConnection? connection);
  Future<void> onLamp();
  Future<void> offLamp();
  Future<void> onRelay();
  Future<void> offRelay();
}

class BluRepository implements IBluRepository {
  final IBluDataSource dataSource;

  BluRepository(this.dataSource);
  @override
  Future<void> getData(BluetoothConnection? connection) {
    return dataSource.getData(connection);
  }

  @override
  Future<void> offLamp() {
    return dataSource.offLamp();
  }

  @override
  Future<void> offRelay() {
    return dataSource.offRelay();
  }

  @override
  Future<void> onLamp() {
    return dataSource.onLamp();
  }

  @override
  Future<void> onRelay() {
    return dataSource.onRelay();
  }
}
