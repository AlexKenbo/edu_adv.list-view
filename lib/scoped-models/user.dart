import '../models/user.dart';
import './connected_products.dart';

mixin UserModel on ConnectedProducts {

  void login(String email, String password) {
    authenticatedUser = User(id: 'efeewrerr', email: email, password: password);
  }

}