import 'package:alice_lightweight/alice.dart';
import 'package:riverpod/riverpod.dart';

import 'package:hearthstone_api/core/data/constants.dart';

// A provider for the Alice instance.
final aliceProvider = Provider<Alice>((ref) {
  return Alice(
    navigatorKey: navigatorKey,
    darkTheme: true,
  );
});
