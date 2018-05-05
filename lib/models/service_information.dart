class ServiceInformation {
  String _serviceId;
  String _serviceUrl;
  String _serviceSecret;
  String _ringServiceId;
  String _serviceHubUrl;

  ServiceInformation.map(dynamic obj) {
    this._serviceId = obj['serviceId'];
    this._serviceUrl = obj['serviceUrl'];
    this._serviceSecret = obj['serviceSecret'];
    this._ringServiceId = obj['ringServiceId'];
    this._serviceHubUrl = obj['serviceHubUrl'];
  }

  String get serviceId => _serviceId;
  String get serviceUrl => _serviceUrl;
  String get serviceSecret => _serviceSecret;
  String get ringServiceId => _ringServiceId;
  String get serviceHubUrl => _serviceHubUrl;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['serviceId'] = _serviceId;
    map['serviceUrl'] = _serviceUrl;
    map['serviceSecret'] = _serviceSecret;
    map['ringServiceId'] = _ringServiceId;
    map['serviceHubUrl'] = _serviceHubUrl;

    return map;
  }
}