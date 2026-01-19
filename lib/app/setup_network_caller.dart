import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';

NetworkCaller getNetworkCaller(){
  NetworkCaller networkCaller = NetworkCaller(onUnauthorize: (){
    // move to login screen
  }, header: {
    "Content-type" : "application/json",
    "token" : AuthController.accessToken ?? ''
  });

  return networkCaller;
}