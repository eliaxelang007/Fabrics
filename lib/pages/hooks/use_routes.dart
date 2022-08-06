import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _RouteCallbacks extends RouteAware {
  final void Function()? onPop;
  final void Function()? onPopNext;
  final void Function()? onPush;
  final void Function()? onPushNext;

  _RouteCallbacks({this.onPop, this.onPopNext, this.onPush, this.onPushNext});

  @override
  void didPop() {
    onPop?.call();
  }

  @override
  void didPopNext() {
    onPopNext?.call();
  }

  @override
  void didPush() {
    onPush?.call();
  }

  @override
  void didPushNext() {
    onPushNext?.call();
  }
}

void useRoutes(RouteObserver<ModalRoute> observer,
    {void Function()? onPop, void Function()? onPopNext, void Function()? onPush, void Function()? onPushNext, List<Object?> keys = const []}) {
  final context = useContext();
  final route = ModalRoute.of(context);

  useEffect(
    () {
      if (route == null) return null;

      final callbacks = _RouteCallbacks(
        onPop: onPop,
        onPopNext: onPopNext,
        onPush: onPush,
        onPushNext: onPushNext,
      );

      observer.subscribe(callbacks, route);

      return () => observer.unsubscribe(callbacks);
    },
    [route, observer, ...keys],
  );
}
