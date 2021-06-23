class GlobalArguments {

  static final GlobalArguments _instance = GlobalArguments._internal();
  factory GlobalArguments() => _instance;
  GlobalArguments._internal() {
    _uid = '';
  }
  String _uid;
  String get uid => _uid;
  set uid(String value) => uid = value;
  void setUid(String newUid) => _uid = newUid;
}