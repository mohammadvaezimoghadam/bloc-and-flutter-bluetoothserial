import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_blutooth/gen/assets.gen.dart';
import 'package:test_blutooth/theme.dart';
import 'package:test_blutooth/ui/setting/bloc/setting_bloc.dart';

class SetingScreen extends StatefulWidget {
  @override
  State<SetingScreen> createState() => _SetingScreenState();
}

class _SetingScreenState extends State<SetingScreen> {
  late final SettingBloc settingBloc;
  @override
  void initState() {
    super.initState();
    bluStateNotifier.addListener(bluStateNotifierListener);
  }

  void bluStateNotifierListener() {
    settingBloc.add(SettingBluStateChanged(bluStateNotifier.value));
  }

  @override
  void dispose() {
    settingBloc.close();
    bluStateNotifier.removeListener(bluStateNotifierListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocProvider<SettingBloc>(
      create: (context) {
        final bloc = SettingBloc();
        settingBloc = bloc;
        settingBloc.add(SettingStarted(bluStateNotifier.value));

        return bloc;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return state is SettingSuccess
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 101),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Text(
                                      'تنظیمات',
                                      style: themeData.textTheme.headline6,
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'بلوتوث فعال است',
                                          style: themeData.textTheme.bodyText2!
                                              .copyWith(color: Colors.green),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Text(
                                      'دستگاه های جفت شده',
                                      style: themeData.textTheme.headline6!
                                          .copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Expanded(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            alignment:
                                                AlignmentDirectional.centerStart,
                                            hint: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Assets.img.icons.devices.svg(
                                                    width: 14,
                                                    height: 14,
                                                    color: LightThemeColors
                                                        .secondaryTextColor),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'دستگاه های جفت شده',
                                                  style: themeData
                                                      .textTheme.bodyText2!
                                                      .copyWith(
                                                          color: LightThemeColors
                                                              .secondaryTextColor),
                                                ),
                                              ],
                                            ),
                                            items: state.dropdownItems,
                                            onChanged: ((value) {
                                              settingBloc.add(SettingDropdownItemSelected(value!, bluStateNotifier.value));
                                            }),
                                            value: state.dropdownValue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              settingBloc.add(SettingConnectionBtnClicked(bluStateNotifier.value));
                                            },
                                            child: state.connectionState
                                                ? Text('قطع ارتباط')
                                                : Text(' جفت سازی')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : state is SettingLoading
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : state is SettingBluetoothRequired
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "بلوتوث را فعال کنید",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                          : throw Exception();
            },
          ),
        ),
      ),
    );
  }
}
