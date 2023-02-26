import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_blutooth/carousel/carousel_slider.dart';
import 'package:test_blutooth/data/datasource/blu_data_source.dart';
import 'package:test_blutooth/data/repo/blu_repository.dart';
import 'package:test_blutooth/gen/assets.gen.dart';
import 'package:test_blutooth/gen/fonts.gen.dart';
import 'package:test_blutooth/main.dart';
import 'package:test_blutooth/ui/room/room.dart';
import 'package:test_blutooth/ui/home/bloc/home_bloc.dart';
import 'package:test_blutooth/ui/setting/bloc/setting_bloc.dart';

   final StreamController<String> streamController = StreamController();
  Stream<String> get getstream => streamController.stream;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? homeBloc;
  late Stream<String> stream;
  late StreamSubscription<String> streamSubscription;
  @override
  void initState() {
    connectionNotifier.addListener(connectionNotifierListener);
    super.initState();
    stream=getstream;
  }

  void connectionNotifierListener() async {
    homeBloc?.add(HomeConnectionChanged(connectionNotifier.value));
  }

  @override
  void dispose() {
    super.dispose();
    connectionNotifier.removeListener(connectionNotifierListener);
    homeBloc!.close();
    streamSubscription.cancel();
    
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocProvider<HomeBloc>(
      create: (context) {
        final bloc = HomeBloc(BluRepository(BluDataSource(streamController)),stream);
        homeBloc = bloc;
        bloc.add(HomeStarted(connectionNotifier.value));
        return bloc;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 253, 253, 253),
          body: Stack(
            children: [
              Positioned.fill(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 101),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(36),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(CupertinoIcons.bell),
                                        Container(
                                          width: 80,
                                          height:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(36)),
                                          ),
                                          child: state is HomeLoading ||
                                                  state
                                                      is HomeConnectionRequired
                                              ? const Center(
                                                  child:
                                                      CupertinoActivityIndicator())
                                              : Center(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          32)),
                                                      child: Assets
                                                          .img.banners.panda
                                                          .image(
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'سلام محمد',
                                          style: themeData.textTheme.headline6,
                                        ),
                                        Text('به خانه هوشمند خوش آمدید'),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListHome(
                                  homeState: state,
                                  themeData: themeData,
                                  temp: state is HomeSuccess
                                      ? state.temperature
                                      : '',
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          state is HomeSuccess
                              ? CarouselSlide()
                              : state is HomeConnectionRequired
                                  ? Center(
                                      child: Text('ارتباط بلوتوث بر قرار نیست'),
                                    )
                                  : Center(child: Text('خطا')),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 86,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white.withOpacity(0),
                          ]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ListHome extends StatelessWidget {
  final String temp;
  final HomeState homeState;

  const ListHome({
    Key? key,
    required this.themeData,
    required this.temp,
    required this.homeState,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 20,
          spacing: 20,
          children: [
            ItemHome(
              homeState: homeState,
              iconPath: 'home.svg',
              themeData: themeData,
              data: temp,
              shadow: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              vahed: 'percent.svg',
            ),
            ItemHome(
              homeState: homeState,
              iconPath: 'temp.svg',
              themeData: themeData,
              data:temp,
              shadow: Colors.red.withOpacity(0.5),
              textColor: Colors.red,
              vahed: 'percent.svg',
            ),
            ItemHome(
              homeState: homeState,
              iconPath: 'water.svg',
              themeData: themeData,
              data:temp,
              shadow: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              vahed: 'percent.svg',
            ),
            ItemHome(
              homeState: homeState,
              iconPath: 'devices.svg',
              themeData: themeData,
              data:temp,
              shadow: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              vahed: 'percent.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (context, index, realIndex) => _CarouselItem(
              title: 'پدیرایی',
              devices: 6,
              imgPath: 'bath4.jpg',
              onTap: (() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Room()));
              }),
            ),
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          viewportFraction: 0.8,
          aspectRatio: 1,
          initialPage: 0,
          scrollPhysics: BouncingScrollPhysics(),
          disableCenter: false,
          autoPlay: false,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ));
  }
}

class _CarouselItem extends StatelessWidget {
  final String title;
  final String imgPath;
  final int devices;
  final Function() onTap;
  const _CarouselItem({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.devices,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
              top: 100,
              right: 65,
              left: 65,
              bottom: 24,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 20, color: Color(0xff0d253c))
                  ],
                ),
              )),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.center,
                      colors: [
                        Color.fromARGB(170, 127, 130, 135),
                        Colors.transparent
                      ])),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/banners/bath4.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 48,
              right: 42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'پذیرایی',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.white),
                  ),
                  Text(
                    'دستگاه ها 6',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .apply(
                          color: Colors.white,
                        )
                        .copyWith(fontSize: 16),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
