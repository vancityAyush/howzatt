part of 'WalletBloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetWalletEvent extends WalletEvent {
  const GetWalletEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [context];
}

class AddWalletEvent extends WalletEvent {
  const AddWalletEvent(
      {required this.context,
      required this.amount,
      required this.type,
      required this.status,
      required this.user_id,
      required this.isFromSuccess});

  final BuildContext context;
  final String amount;
  final String type;
  final String status;
  final String user_id;
  final bool isFromSuccess;

  @override
  List<Object> get props => [context];
}

class AddBonusWalletEvent extends WalletEvent {
  const AddBonusWalletEvent(
      {required this.context,
      required this.amount,
      required this.type,
      required this.status,
      required this.user_id,
      required this.isFromSuccess,
      required this.remarks});

  final BuildContext context;
  final String amount;
  final String type;
  final String status;
  final String user_id;
  final bool isFromSuccess;
  final String remarks;

  @override
  List<Object> get props => [context];
}

class UpdateWallet extends WalletEvent {
  const UpdateWallet(
      {required this.context,
      required this.response,
      required this.status,
      required this.orderId,
      required this.isFromSuccess});

  final BuildContext context;
  final String response;
  final String status;
  final String orderId;
  final bool isFromSuccess;

  @override
  List<Object> get props => [context];
}
