library test_bot_async;

import 'dart:async';
import 'package:bot/bot_async.dart';
import 'package:bot_test/bot_test.dart';
import 'package:unittest/unittest.dart';

part 'test_delayed_result.dart';

void main() {
  group('bot_async', (){
    registerDelayedResultTests();
  });
}
