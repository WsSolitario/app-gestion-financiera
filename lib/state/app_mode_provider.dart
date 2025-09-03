import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the current application mode, either `public` or `private`.
/// Defaults to `public`.
final appModeProvider = Provider<String>((ref) => 'public');

