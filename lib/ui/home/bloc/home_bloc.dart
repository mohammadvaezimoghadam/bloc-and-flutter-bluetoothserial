import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_blutooth/data/repo/blu_repository.dart';
import 'package:test_blutooth/ui/setting/bloc/setting_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBluRepository repository;
  final Stream<String> stream1;
  HomeBloc(this.repository, this.stream1) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        final connection = event.connection;
        if (connection == null || connection.isConnected == false) {
          emit(HomeConnectionRequired());
        } else {
          try {
            emit(HomeLoading());
            await repository.getData(event.connection);
            await for (final events in stream1) {
              emit(HomeSuccess(events));
            }


            // final temp = await repository.getData(event.connection).listen((event) { });

          } catch (e) {}
        }
      } else if (event is HomeConnectionChanged) {
        if (event.connection == null ||
            event.connection!.isConnected == false) {
          emit(HomeConnectionRequired());
        } else {
          if (state is HomeConnectionRequired) {
            try {
              emit(HomeLoading());
              await repository.getData(event.connection);

              await for (final events in stream1) {
                emit(HomeSuccess(events));
              }


            } catch (e) {}
          }
        }
      }
    });
  }
}
