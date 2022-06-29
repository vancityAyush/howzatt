class WatchListData {
  String _id;
  String user_id;
  String code;
  String created_at;
  String __v;

  WatchListData(this._id, this.user_id,this.code,this.created_at,this.__v);

  @override
  String toString() {
    return '{ ${this._id}, ${this.user_id},${this.code} ,${this.created_at} , ${this.__v}  }';
  }
}