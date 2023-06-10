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
   QuerySnapshot? snapshot;
   String? chatRoomId;
   bool? isSent;
   List<dynamic>? searchResult;
   ChatLoadedState({this.snapshot,this.isSent,this.searchResult, this.chatRoomId});
  @override
  List<Object> get props => [snapshot!,chatRoomId!,isSent!,searchResult!];

}

class ChatErrorState extends ChatState {
  final String? errorMessage;
  const ChatErrorState(this.errorMessage);
   @override
  List<Object> get props => [errorMessage!];
}