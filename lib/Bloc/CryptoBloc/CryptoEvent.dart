part of 'CryptoBloc.dart';


abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

class FetchCryptoEvent extends CryptoEvent {
  const FetchCryptoEvent({required this.context});

  final BuildContext context;



  @override
  List<Object> get props => [context];

}


class FetchMarketDepthEvent extends CryptoEvent {
  const FetchMarketDepthEvent({required this.context,required this.symbol,required this.limit,required this.fromWhere});

  final BuildContext context;
  final String symbol;
  final String limit;
  final bool fromWhere;



  @override
  List<Object> get props => [context];

}


class AddtoWatchList extends CryptoEvent {
  const AddtoWatchList({required this.context,required this.code});

  final BuildContext context;
  final String code;



  @override
  List<Object> get props => [context];

}

class GetWatchList extends CryptoEvent {
  const GetWatchList({required this.context});

  final BuildContext context;




  @override
  List<Object> get props => [context];

}

