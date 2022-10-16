import 'package:crud/models/models.dart';
import 'package:crud/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const _homeScreen = "HOME";
  static const detailScreen = "DETAIL";
  static const addPostScreen = "ADD";

  static const initialRoute = _homeScreen;

  static final screenOptions = <ScreenOption>[
    ScreenOption(
        route: _homeScreen,
        icon: Icons.list_alt_outlined,
        name: "Posts",
        screen: const PostsScreen()),
    ScreenOption(
        route: detailScreen,
        icon: Icons.details_rounded,
        name: "Detalle",
        screen: const DetailScreen()),
    ScreenOption(
      route: addPostScreen,
      icon: Icons.post_add_outlined,
      name: "Adicionar Post",
      screen: const AddPostScreen(),
    )
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoute = {};

    appRoute
        .addAll({_homeScreen: (BuildContext context) => const PostsScreen()});

    for (final option in screenOptions) {
      appRoute.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoute;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PostsScreen(),
    );
  }
}
