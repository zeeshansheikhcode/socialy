part of 'bottomnvabar_cubit.dart';

abstract class BottomnvabarState extends Equatable {
  const BottomnvabarState();

  @override
  List<Object> get props => [];
}

class BottomnvabarInitial extends BottomnvabarState {}

class BottomnvabarLoadingState extends BottomnvabarState {
  final int index;
  const BottomnvabarLoadingState(this.index);
  @override
  List<Object> get props => [index]; 
}

class BottomnvabarLoadedState extends BottomnvabarState 
{
  final int index;
  const BottomnvabarLoadedState(this.index);
  @override
  List<Object> get props => [index];  
}

class BottomnvabarErrorState extends BottomnvabarState {}
