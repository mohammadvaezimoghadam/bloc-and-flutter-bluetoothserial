import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text('test'),),
    ) ;
  }

}














// Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Switch(
//                                     value: _bluetoothState.isEnabled,
//                                     onChanged: ((value) {
//                                       future() async {
//                                         if (value) {
//                                           await _bluetoothSerial
//                                               .requestEnable();
//                                         } else {
//                                           await _bluetoothSerial
//                                               .requestDisable();
//                                         }
//                                         await getPairedDevices();
//                                         _isButtonUnavailable = false;

//                                         if (_connected) {}
//                                         future().then((_) {
//                                           setState(() {});
//                                         });
//                                       }
//                                     })),
//                                 DropdownButton(
//                                   items: _getDeviceItems(),
//                                   onChanged: ((value) {
//                                     setState(() {
//                                       _device = value;
//                                     });
//                                   }),
//                                   value:
//                                       _devicesList.isNotEmpty ? _device : null,
//                                 ),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       _isButtonUnavailable
//                                           ? null
//                                           : _connected
//                                               ? _disconnect()
//                                               : _connect();
//                                     },
//                                     child: Text(
//                                         _connected ? 'Disconnect' : 'Connect')),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       _connected
//                                           ? _sendOnMessageToBluetooth(1)
//                                           : null;
//                                     },
//                                     child: Text('ON')),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       _connected
//                                           ? _sendOffMessageToBluetooth()
//                                           : null;
//                                     },
//                                     child: Text('OFF')),
//                                 SizedBox(
//                                   height: 24,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "دمای محیط:",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ),
//                                     SizedBox(
//                                       width: 32,
//                                     ),
//                                     Container(
//                                       child: Text(
//                                         "$a" + " " + "درجه سانتی گراد",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),