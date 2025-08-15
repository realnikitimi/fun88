import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselInitial()) {
    on<LoadCarouselImages>(_onLoadCarouselImages);
  }

  void _onLoadCarouselImages(
    LoadCarouselImages event,
    Emitter<CarouselState> emit,
  ) {
    emit(CarouselLoaded(images: event.initialImageList));
  }
}

abstract class CarouselEvent {
  const CarouselEvent();
}

class LoadCarouselImages extends CarouselEvent {
  /// `String` || `Widget`
  final List<dynamic> initialImageList;

  const LoadCarouselImages({required this.initialImageList});
}

abstract class CarouselState {
  const CarouselState();
}

class CarouselInitial extends CarouselState {}

class CarouselLoaded extends CarouselState {
  /// `String` || `Widget`
  final List<dynamic> images;

  const CarouselLoaded({required this.images});
}
