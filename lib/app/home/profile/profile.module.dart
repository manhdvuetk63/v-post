import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/home/profile/profile.view.dart';
class ProfileModule extends Module {
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => ProfileWidget()),
  ];
}
