
import 'package:server_app_delivery/modules/users/view_models/register_input_model.dart';

class RegisterInputModelMapper{
  final Map<String,dynamic> _requestMap;

  RegisterInputModelMapper(this._requestMap);

  RegisterInputModel mapper(){
    return RegisterInputModel(
      name: _requestMap['name'],
      email: _requestMap['email'],
      password: _requestMap['password']
    );


  }

}