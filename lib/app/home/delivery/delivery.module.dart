import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/home/delivery/delivery.view.dart';

class DeliveryModule extends WidgetModule {
  static String profile = "/profile";

  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => DeliveryWidget()),
  ];

  @override
  Widget get view => DeliveryWidget();
}
