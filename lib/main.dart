import 'package:bus_ticketing/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope( // river pod wrapper , at the root
      child : GogoBusApp()
    )
  );
}
