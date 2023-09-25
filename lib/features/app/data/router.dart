import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

// App feature elements.
import 'package:hearthstone_api/features/home/presentation/screens/home.dart';

// Cards feature elements.
import 'package:hearthstone_api/features/cards/presentation/screens/cards_search/cards_search.dart';
import 'package:hearthstone_api/features/cards/presentation/screens/card_detail/card_detail.dart';
import 'package:hearthstone_api/features/cards/presentation/screens/card_router.dart';

part 'router.gr.dart';

// The main router object.
final router = RootRouter();

/// The root router for the application. The class name is rewritten to a route following this
/// convention:
///
/// MyCoolScreen => MyCoolRoute (The word "Screen" is replaced with "Route").
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class RootRouter extends _$RootRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      AutoRoute(page: HomeRoute.page, initial: true),
      AutoRoute(
        page: CardsRouterRoute.page,
        path: '/cards',
        children: [
          AutoRoute(page: CardsSearchRoute.page, path: ''),
          AutoRoute(page: CardDetailRoute.page, path: ':cardName')
        ],
      ),
    ];
  }
}