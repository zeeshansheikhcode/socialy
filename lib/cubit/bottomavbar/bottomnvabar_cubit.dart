import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnvabar_state.dart';

class BottomnvabarCubit extends Cubit<BottomnvabarState> {
  BottomnvabarCubit() : super(const BottomnvabarLoadingState(0));
  
  void selectView(int index) {
    emit(BottomnvabarLoadedState(index));
  }
}
