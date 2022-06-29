part of 'CryptoBloc.dart';

class CryptoState extends Equatable {
  final int version;


  const CryptoState({required this.version});

  CryptoState copyWith({
    required int? version
  }) {
    return CryptoState(
      version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class CryptoInitialState extends CryptoState {

  const CryptoInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class CryptoCompleteState extends CryptoState {

  const CryptoCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Response serverResponse;



  @override
  List<Object> get props => [version];
}

class MarketDepthCompleteState extends CryptoState {

  const MarketDepthCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Response serverResponse;



  @override
  List<Object> get props => [version];
}


class AddtoWatchListCompleteState extends CryptoState {

  const AddtoWatchListCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;

  @override
  List<Object> get props => [version];
}


class GetWatchListCompleteState extends CryptoState {

  const GetWatchListCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;



  @override
  List<Object> get props => [version];
}