part of 'WalletBloc.dart';

class WalletState extends Equatable {
  final int version;


  const WalletState({required this.version});

  WalletState copyWith({
    required int? version
  }) {
    return WalletState(
        version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class WalletInitialState extends WalletState {

  const WalletInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;

  @override
  List<Object> get props => [version];
}

class GetWalletCompleteState extends WalletState {

  const GetWalletCompleteState({
    this.context,
    required this.version,
    required this.totalWalletAmount,
    required this.serverResponse
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final String totalWalletAmount;
  final Map<String,dynamic> serverResponse;


  @override
  List<Object> get props => [version];
}


class AddWalletCompleteState extends WalletState {

  const AddWalletCompleteState({
    this.context,
    required this.version,
    required this.cftoken,
    required this.orderId
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final String cftoken;
  final String orderId;



  @override
  List<Object> get props => [version];
}

class UpdateWalletCompleteState extends WalletState {

  const UpdateWalletCompleteState({
    this.context,
    required this.version,
    required this.isFromSuccess
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final bool isFromSuccess;




  @override
  List<Object> get props => [version];
}


class AddBonusWalletWalletCompleteState extends WalletState {

  const AddBonusWalletWalletCompleteState({
    this.context,
    required this.version,
    required this.cftoken,
    required this.orderId
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final String cftoken;
  final String orderId;



  @override
  List<Object> get props => [version];
}
