import 'package:auto_route/auto_route.dart';
import '/features/auth/ui/auth_screen.dart';
import '/features/home/ui/home_screen.dart';
import '/features/home/ui/add_task_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          children: [
            AutoRoute(
              page: AddTaskRoute.page,
              path: 'new_task',
            ),
          ],
        ),
      ];
}
