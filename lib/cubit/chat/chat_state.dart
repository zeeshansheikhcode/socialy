part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {

}
class ChatLoadedState extends ChatState {

}

class ChatErrorState extends ChatState {
  final String? errorMessage;
  const ChatErrorState(this.errorMessage);
   @override
  List<Object> get props => [errorMessage!];
}