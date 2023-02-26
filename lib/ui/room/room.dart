import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_blutooth/gen/assets.gen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            
            foregroundColor: themeData.colorScheme.onSecondary,
            toolbarHeight: 85,
            actions: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(36)),
                ),
                child: Center(
                    child: Assets.img.icons.manage.svg(height: 32, width: 32)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'پذیرایی',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'خانه هوشمند خود را مدیریت کنید',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 8, left: 4, right: 4),
                          child: Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 15,
                            spacing: 20,
                            children: [
                              _ItemRoom(
                                isActive: false,
                                iconPath: 'sound.svg',
                                themeData: themeData,
                                data: 'Sound',
                                onTap: () {},
                              ),
                              _ItemRoom(
                                isActive: false,
                                iconPath: 'fan.svg',
                                themeData: themeData,
                                data: 'Fan',
                                onTap: () {},
                              ),
                              _ItemRoom(
                                isActive: false,
                                iconPath: 'heating.svg',
                                themeData: themeData,
                                data: 'Heating',
                                onTap: () {},
                              ),
                              _ItemRoom(
                                isActive: true,
                                iconPath: 'lamp.svg',
                                themeData: themeData,
                                data: 'Lamp',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: DottedBorder(
                              radius: Radius.circular(125),
                              child: Container(
                                decoration: BoxDecoration(
                                  
                                ),
                              ),
                              borderType: BorderType.RRect,
                              strokeWidth: 10,
                              
                              color: themeData.textTheme.caption!.color!
                                  .withOpacity(0.4),
                              dashPattern: [2, 44],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SleekCircularSlider(
                                innerWidget: (percentage) {
                                  return Center(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: themeData
                                                  .textTheme.caption!.color!
                                                  .withOpacity(0.3),
                                              blurRadius: 20)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(75),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Assets.img.icons.brightness
                                                .svg(width: 24, height: 24),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Brightness'),
                                            Text(
                                              percentage.toInt().toString() +
                                                  "%",
                                              style: themeData
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                      color: themeData
                                                          .colorScheme.primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                appearance: CircularSliderAppearance(
                                  infoProperties: InfoProperties(
                                    topLabelText: 'brightmess',
                                  ),
                                  counterClockwise: false,
                                  spinnerMode: false,
                                  startAngle: 180,
                                  angleRange: 360,
                                  customWidths: CustomSliderWidths(
                                      trackWidth: 3,
                                      progressBarWidth: 3,
                                      handlerSize: 10),
                                  customColors: CustomSliderColors(
                                      trackColor: themeData
                                          .textTheme.caption!.color!
                                          .withOpacity(0.3),
                                      shadowColor:
                                          themeData.colorScheme.primary,
                                      progressBarColor:
                                          themeData.colorScheme.primary,
                                      dotColor: themeData.colorScheme.primary,
                                      shadowMaxOpacity: 0.5),
                                  size: 200,
                                ),
                                onChange: (double value) {
                                  print(value);
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 101,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemRoom extends StatelessWidget {
  final String data;
  final String iconPath;
  final bool isActive;
  final Function() onTap;

  const _ItemRoom({
    Key? key,
    required this.themeData,
    required this.data,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          boxShadow: isActive == false
              ? null
              : [
                  BoxShadow(
                    blurRadius: 14,
                    color: themeData.colorScheme.primary,
                  )
                ],
          border: isActive
              ? null
              : Border.all(
                  width: 2,
                  color: Colors.white,
                ),
          borderRadius: BorderRadius.circular(16),
          color: isActive ? themeData.colorScheme.primary : Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/img/icons/' + "${iconPath}",
              width: 24,
              height: 24,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: themeData.textTheme.bodyText2!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
