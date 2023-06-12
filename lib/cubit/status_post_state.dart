part of 'status_post_cubit.dart';

abstract class StatusPostState extends Equatable {
  const StatusPostState();

  @override
  List<Object> get props => [];

  get posts => null;
}

class StatusPostInitial extends StatusPostState {}

class StatusPostLoadingState extends StatusPostState {}

class StatusPostLoadedState extends StatusPostState {
  final List<List<StoryModel>>? allStories;
  final List<PostModel>? allPost;
  const StatusPostLoadedState({this.allStories, this.allPost});
  @override
  List<Object> get props => [allStories! ,allPost!];
}

class StatusPostErrorState extends StatusPostState {
  final String? errorMessage;
  const StatusPostErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage!];
}
