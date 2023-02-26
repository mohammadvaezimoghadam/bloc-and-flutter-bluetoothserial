// For performing some operations asynchronously
import 'dart:async';

// For using PlatformException
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_blutooth/ui/home/bloc/home_bloc.dart';
import 'package:test_blutooth/ui/setting/bloc/setting_bloc.dart';

import 'test.dart';
import 'theme.dart';
import 'ui/home/home.dart';
import 'ui/setting/seting.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 255, 196, 48),
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Color.fromARGB(255, 255, 196, 48),
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await getBluetoothState();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontFamily: 'Vazir', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: defaultTextStyle,
          caption: defaultTextStyle.apply(
              color: LightThemeColors.secondaryTextColor),
          headline6: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 22),
        ),
        colorScheme: ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: LightThemeColors.primaryTextColor,
        ),
      ),
      home:
          Directionality(textDirection: TextDirection.rtl, child: MainScreen()),
    );
  }
}

// @override
// void initState() {
//   super.initState();
//   _bluetoothSerial.state.then((state) {
//     setState(() {
//       _bluetoothState = state;
//     });
//   });
//   _deviceState = 0;

//   getPairedDevices();

//   _bluetoothSerial.onStateChanged().listen((state) {
//     setState(() {
//       _bluetoothState = state;
//     });
//   });
// }

// Future<void> enableBluetooth() async {
//   _bluetoothState = await _bluetoothSerial.state;
//   if (_bluetoothState == BluetoothState.STATE_OFF) {
//     await _bluetoothSerial.requestEnable();
//     await getPairedDevices();
//   }
// }

// Future<void> getPairedDevices() async {
//   _bluetoothState = await _bluetoothSerial.state;
//   List<BluetoothDevice> devices = [];

//   devices = await _bluetoothSerial.getBondedDevices();

//   if (!mounted) {
//     return;
//   }
//   setState(() {
//     _devicesList = devices;
//   });
// }

// List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
//   List<DropdownMenuItem<BluetoothDevice>> items = [];
//   if (_devicesList.isEmpty) {
//     items.add(DropdownMenuItem(child: Text('NONE')));
//   } else {
//     _devicesList.forEach((device) {
//       items.add(DropdownMenuItem(
//         child: Text(device!.name.toString()),
//         value: device,
//       ));
//     });
//   }
//   return items;
// }

// void _connect() async {
//   if (_device == null) {
//   } else {
//     if (!isConnected) {
//       await BluetoothConnection.toAddress(_device!.address)
//           .then((_connection) {
//         connection = _connection;
//         setState(() {
//           _connected = true;
//         });
//       });
//     }
//   }
// }

// void _disconnect() async {
//   await connection!.close();

//   if (!connection!.isConnected) {
//     setState(() {
//       _connected = false;
//     });
//   }
// }

// void _sendOnMessageToBluetooth(int m) async {
//   connection!.output.add(ascii.encode("$m" + "\r\n"));
//   await connection!.output.allSent;
//   setState(() {
//     _deviceState = 1;
//   });
// }

// void _sendOffMessageToBluetooth() async {
//   connection!.output.add(ascii.encode("0" + "\r\n"));
//   await connection!.output.allSent;
//   setState(() {
//     _deviceState = -1;
//   });
// }

// @override
// void dispose() {
//   if (isConnected) {
//     isDisconnecting = true;
//     connection!.dispose();
//     connection = null;
//   }
//   super.dispose();
// }

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;
const int setingIndex = 2;
const int testIndex = 1;

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _testKey = GlobalKey();
  GlobalKey<NavigatorState> _settingKey = GlobalKey();
  late final map = {
    homeIndex: _homeKey,
    testIndex: _testKey,
    setingIndex: _settingKey,
  };
  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTab =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTab.canPop()) {
      currentSelectedTab.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: selectedScreenIndex,
                children: [
                  _navigator(_homeKey, homeIndex, HomeScreen()),
                  _navigator(_testKey, testIndex, TestScreen()),
                  _navigator(_settingKey, setingIndex, SetingScreen()),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: _BottomNavigation(
                selectedIndex: selectedScreenIndex,
                onTap: (index) {
                  setState(() {
                    _history.remove(selectedScreenIndex);
                    _history.add(selectedScreenIndex);
                    selectedScreenIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)),
          );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedIndex;

  const _BottomNavigation(
      {super.key, required this.onTap, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.2),
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavigationItem(
            title: 'خانه',
            isActive: selectedIndex == homeIndex,
            iconFileName: 'assets/img/icons/home.svg',
            activeIconFileName: '',
            onTap: () {
              onTap(homeIndex);
            },
          ),
          BottomNavigationItem(
            title: 'اینترنت',
            isActive: selectedIndex == testIndex,
            iconFileName: 'assets/img/icons/internet.svg',
            activeIconFileName: '',
            onTap: () {
              onTap(testIndex);
            },
          ),
          BottomNavigationItem(
            title: 'تنظیمات',
            isActive: selectedIndex == setingIndex,
            iconFileName: 'assets/img/icons/setting.svg',
            activeIconFileName: '',
            onTap: () {
              onTap(setingIndex);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String title;
  final String iconFileName;
  final bool isActive;
  final String activeIconFileName;
  final Function() onTap;

  const BottomNavigationItem(
      {super.key,
      required this.title,
      required this.iconFileName,
      required this.activeIconFileName,
      required this.onTap,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32.5),
      child: Container(
        height: isActive ? 48 : 50,
        width: isActive ? 130 : 50,
        decoration: BoxDecoration(
          boxShadow: isActive == false
              ? null
              : [
                  BoxShadow(
                    blurRadius: 8,
                    color: themeData.colorScheme.primary,
                  ),
                ],
          border: isActive ? null : Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(32.5),
          color: isActive ? themeData.colorScheme.primary : Colors.white,
        ),
        child: isActive
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: SvgPicture.asset(
                        iconFileName,
                        color: Colors.black,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: Text(title)),
                  ],
                ),
              ))
            : Center(
                child: SvgPicture.asset(
                  iconFileName,
                  color: Colors.grey,
                  width: 32,
                  height: 32,
                ),
              ),
      ),
    );
  }
}

class ItemHome extends StatelessWidget {
  final String data;
  final String iconPath;
  final Color shadow;
  final Color textColor;
  final String? vahed;
  final HomeState homeState;

  const ItemHome({
    Key? key,
    required this.themeData,
    required this.data,
    required this.iconPath,
    required this.shadow,
    required this.textColor,
    required this.vahed,
    required this.homeState,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          boxShadow: [BoxShadow(color: shadow, blurRadius: 11)],
          border: Border.all(
            width: 0.2,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(16)),
      child:homeState ==HomeLoading?CupertinoActivityIndicator(): Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/img/icons/' + "${iconPath}",
              color: textColor,
              width: 24,
              height: 24,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              vahed != null
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/img/icons/' + "${vahed}",
                        color: textColor,
                        width: 16,
                        height: 16,
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              Text(
                data,
                style: themeData.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
