class MatchLeague {
  String leagueName;
  String leagueKey;
  MatchLeague(this.leagueName, this.leagueKey);
  @override
  String toString() {
    return '{ ${this.leagueName}, ${this.leagueKey} }';
  }
}