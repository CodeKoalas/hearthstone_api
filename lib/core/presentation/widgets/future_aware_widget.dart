import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Typedef for the builder function called.
typedef FutureAwareWidgetBuilder<T> = Widget Function(BuildContext context, void Function(T), AsyncSnapshot<void> snapshot);

/// This widget provides an easy way to have a widget rebuild based on the status of the future.
class FutureAwareWidget<T extends Future> extends HookConsumerWidget {
  const FutureAwareWidget({super.key, required this.builder});

  final FutureAwareWidgetBuilder<T> builder;

  void setFuture(ValueNotifier<T?> setter, T future) {
    setter.value = future;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = useState<T?>(null);
    final snapshot = useFuture(future.value);
    final setter = useCallback<void Function(T)>((T f) => future.value = f, [key]);

    return builder(context, setter, snapshot);
  }
}
