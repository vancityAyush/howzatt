part of 'HomePageBloc.dart';


abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends HomePageEvent {
  const GetUserDataEvent({required this.context});

  final BuildContext context;


  @override
  List<Object> get props => [context];

}


class AuthenticationEvent extends HomePageEvent {
  const AuthenticationEvent({required this.context});

  final BuildContext context;


  @override
  List<Object> get props => [context];

}



class GetScheduleMatchDataEvent extends HomePageEvent {
  const GetScheduleMatchDataEvent({required this.context,required this.accessToken});

  final BuildContext context;
  final String accessToken;


  @override
  List<Object> get props => [context];

}

class UpdateToken extends HomePageEvent {
  const UpdateToken({required this.context});

  final BuildContext context;


  @override
  List<Object> get props => [context];

}

class GetNotificationDataEvent extends HomePageEvent {
  const GetNotificationDataEvent({required this.context});

  final BuildContext context;


  @override
  List<Object> get props => [context];

}


class FetchNotificationsEvent extends HomePageEvent {
  const FetchNotificationsEvent({required this.context});

  final BuildContext context;


  @override
  List<Object> get props => [context];

}


