import 'dart:async';
import 'dart:convert';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class IBluDataSource {
  Future<void> getData(BluetoothConnection? connection );
  Future<void> onLamp();
  Future<void> offLamp();
  Future<void> onRelay();
  Future<void> offRelay();
}

class BluDataSource implements IBluDataSource {
  final StreamController<String> streamController;

  BluDataSource(this.streamController);
 

  
  @override
  Future<void> getData(BluetoothConnection? connection ) async{
    
      connection!.input!.listen(
        (event) {
          
        streamController.add(
          
            String.fromCharCodes(event));
          
          
        },
      ).onDone(() {
        streamController.close();
        Error();
      });
      
      
    
    
  }

  @override
  Future<void> offLamp() {
    // TODO: implement offLamp
    throw UnimplementedError();
  }

  @override
  Future<void> offRelay() {
    // TODO: implement offRelay
    throw UnimplementedError();
  }

  @override
  Future<void> onLamp() {
    // TODO: implement onLamp
    throw UnimplementedError();
  }

  @override
  Future<void> onRelay() {
    // TODO: implement onRelay
    throw UnimplementedError();
  }
}
