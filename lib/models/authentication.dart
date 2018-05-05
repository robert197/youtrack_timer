class Authentication {
  String _tokenType;
  String _accessToken;

  Authentication.map(dynamic obj) {
    this._tokenType = obj['tokenType'];
    this._accessToken = obj['accessToken'];
  }

  String get tokenType => _tokenType;
  String get accessToken => _accessToken;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['tokenType'] = _tokenType;
    map['accessToken'] = _accessToken;
    return map;
  }
}