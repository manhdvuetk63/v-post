import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/home/user/delivery/delivery.module.dart';
import 'package:v_post/app/home/user/home.cubit.dart';
import 'package:v_post/app/home/user/home.view.dart';
import 'package:v_post/app/home/user/profile/profile.module.dart';

class UserHomeModule extends Module {
  static String profile = "/profile";
  static String delivery = "/delivery";

  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => UserHomeCubit())];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute(profile, module: ProfileModule(), transition: TransitionType.rightToLeftWithFade),
    ModuleRoute(delivery, module: DeliveryModule()),
    ChildRoute('/', child: (context, args) => UserHomeWidget()),
  ];
}
