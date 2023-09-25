import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

// Global elements.
import 'package:hearthstone_api/core/presentation/themes.dart';
import 'package:hearthstone_api/core/providers/dev_messages.dart';

class ErrorViewWidget extends ConsumerWidget {
  const ErrorViewWidget(
    this.error,
    this.trace, {
    super.key,
    this.showStackTrace = false,
  });

  final Object? error;
  final StackTrace? trace;
  final bool showStackTrace;

  const factory ErrorViewWidget.builder(Object? error, StackTrace? trace) = ErrorViewWidget;
  const factory ErrorViewWidget.view(Object? error, StackTrace? trace, {bool showStackTrace}) = ErrorViewWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDevMessages = ref.watch(showDevMessagesProvider);
    if (showDevMessages) {
      print(error);
      print(trace);
    }
    if (showStackTrace && showDevMessages) {
      return Column(
        children: [
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium!,
          ).padding(bottom: Spacing.four),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
