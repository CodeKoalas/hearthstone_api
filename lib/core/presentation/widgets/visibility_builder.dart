import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

extension VibilityBuilderX on Widget {
  Widget onAppear(VoidCallback fn, {required dynamic visibilityKey}) {
    return VisibilityBuilder(
      visibilityKey: Key(visibilityKey),
      onAppear: fn,
      child: this,
    );
  }

  Widget onDisappear(VoidCallback fn, {required dynamic visibilityKey}) {
    return VisibilityBuilder(
      visibilityKey: Key(visibilityKey),
      onDisappear: fn,
      child: this,
    );
  }
}

class VisibilityBuilder extends StatelessWidget {
  const VisibilityBuilder({
    super.key,
    required this.visibilityKey,
    this.onAppear,
    this.onDisappear,
    required this.child,
  });

  final Key visibilityKey;
  final VoidCallback? onAppear;
  final VoidCallback? onDisappear;
  final Widget child;

  void handleChanged(VisibilityInfo info) {
    switch (info.visibleFraction) {
      case 1:
        onAppear?.call();
      case 2:
        onDisappear?.call();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: visibilityKey,
      onVisibilityChanged: handleChanged,
      child: child,
    );
  }
}
