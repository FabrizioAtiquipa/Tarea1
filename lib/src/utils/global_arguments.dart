class GlobalArguments {

  static final GlobalArguments _instance = GlobalArguments._internal();
  factory GlobalArguments() => _instance;
  GlobalArguments._internal() {
    _uid = '';
    _name = '';
    _email = '';
    _url_perfil = 'https://www.semana.com/resizer/j0-vmg1Lq8iUt4qCWu6Aj3QUutw=/1200x675/filters:format(jpg):quality(50)//cloudfront-us-east-1.images.arcpublishing.com/semana/SMRIIBXEONCRDPXLAOVVTRHAVI.jpg';
  }
  
  String _uid;
  String _name;
  String _email;
  String _url_perfil;

  String get uid => _uid;
  String get name => _name;
  String get email => _email;
  String get url_perfil => _url_perfil;

  set uid(String value) => uid = value;
  set name(String value) => name = value;
  set email(String value) => email = value;
  set url_perfil(String value) => url_perfil = value;
  void setUid(String newUid) => _uid = newUid;
  void setName(String newName) => _name = newName;
  void setEmail(String newEmail) => _email = newEmail;
  void setUrlPerfil(String newUrl) => _url_perfil = newUrl;
}