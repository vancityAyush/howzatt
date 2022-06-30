class MatchLeague {
  String leagueName;
  String leagueKey;
  MatchLeague(this.leagueName, this.leagueKey);
  @override
  String toString() {
    return '{ ${this.leagueName}, ${this.leagueKey} }';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchLeague &&
          runtimeType == other.runtimeType &&
          leagueKey == other.leagueKey;

  @override
  int get hashCode => leagueKey.hashCode;
}
