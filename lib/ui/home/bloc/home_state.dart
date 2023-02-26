part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}
class HomeConnectionRequired extends HomeState{
  
}

class HomeSuccess extends HomeState {
  final String temperature;

  HomeSuccess(
    this.temperature,
  );
  @override
  // TODO: implement props
  List<Object> get props => [
        temperature,
      ];
}
