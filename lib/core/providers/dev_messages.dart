import 'package:riverpod/riverpod.dart';

/// A provider overridden in each flavor to either enable or disable dev messages.
final showDevMessagesProvider = Provider<bool>((ref) => throw UnimplementedError());
