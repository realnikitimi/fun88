// carousel_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselInitial()) {
    on<LoadCarouselImages>(_onLoadImages);
    on<UpdateCarouselImages>(_onUpdateImages);
  }

  final _imageStreamController = StreamController<List<String>>();
  Stream<List<String>> get imageStream => _imageStreamController.stream;

  void _onLoadImages(LoadCarouselImages event, Emitter<CarouselState> emit) {
    // Initial load - could be from API

    _imageStreamController.add(event.initialImageList);
    emit(CarouselLoaded());
  }

  void _onUpdateImages(
    UpdateCarouselImages event,
    Emitter<CarouselState> emit,
  ) {
    _imageStreamController.add(event.imageUrls);
  }

  @override
  Future<void> close() {
    _imageStreamController.close();
    return super.close();
  }
}

// Events
abstract class CarouselEvent {}

class LoadCarouselImages extends CarouselEvent {
  final List<String> initialImageList;
  LoadCarouselImages({required this.initialImageList});
}

class UpdateCarouselImages extends CarouselEvent {
  final List<String> imageUrls;
  UpdateCarouselImages(this.imageUrls);
}

// States
abstract class CarouselState {}

class CarouselInitial extends CarouselState {}

class CarouselLoaded extends CarouselState {}
