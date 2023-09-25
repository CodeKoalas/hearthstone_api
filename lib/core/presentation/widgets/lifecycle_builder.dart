import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension LifecycleBuilderX on Widget {
  Widget onInit(VoidCallback fn) {
    return LifecycleBuilder(
      onInit: fn,
      child: this,
    );
  }

  Widget afterInit(VoidCallback fn) {
    return LifecycleBuilder(
      afterInit: fn,
      child: this,
    );
  }

  Widget onDispose(VoidCallback fn) {
    return LifecycleBuilder(
      onDispose: fn,
      child: this,
    );
  }

  Widget onAppPaused(VoidCallback fn) {
    return LifecycleBuilder(
      onAppPaused: fn,
      child: this,
    );
  }

  Widget onAppResumed(VoidCallback fn) {
    return LifecycleBuilder(
      onAppResumed: fn,
      child: this,
    );
  }

  Widget onAppInactive(VoidCallback fn) {
    return LifecycleBuilder(
      onAppInactive: fn,
      child: this,
    );
  }
}

class LifecycleBuilder extends StatefulWidget {
  const LifecycleBuilder({
    super.key,
    this.onInit,
    this.afterInit,
    this.onDispose,
    this.onAppPaused,
    this.onAppResumed,
    this.onAppInactive,
    required this.child,
  });

  final VoidCallback? onInit;
  final VoidCallback? afterInit;
  final VoidCallback? onDispose;
  final VoidCallback? onAppPaused;
  final VoidCallback? onAppResumed;
  final VoidCallback? onAppInactive;
  final Widget child;

  @override
  LifecycleBuilderState createState() => LifecycleBuilderState();
}

class LifecycleBuilderState extends State<LifecycleBuilder> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        widget.onAppPaused?.call();
      case AppLifecycleState.resumed:
        widget.onAppResumed?.call();
      case AppLifecycleState.inactive:
        widget.onAppInactive?.call();
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
    if (widget.afterInit != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.afterInit!();
      });
    }
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
