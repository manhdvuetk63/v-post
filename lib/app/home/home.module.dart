import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/home/delivery/delivery.module.dart';
import 'package:v_post/app/home/home.cubit.dart';
import 'package:v_post/app/home/home.view.dart';
import 'package:v_post/app/home/profile/profile.module.dart';

class HomeModule extends Module {
  static String profile = "/profile";
  static String delivery = "/delivery";

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeCubit())
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute(profile, module: ProfileModule(), transition: TransitionType.rightToLeftWithFade),
    ModuleRoute(delivery, module: DeliveryModule()),
    ChildRoute('/', child: (context, args) => HomeWidget()),
  ];
}
