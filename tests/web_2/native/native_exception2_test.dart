// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.7

// Similar to native_exception_test.dart but also defines a native
// class.  This exercises a different code path in emitter.dart.

library native_exception2_test;

import 'native_exception_test.dart' as other;
import 'native_testing.dart';

@Native("NativeClass")
class NativeClass {
  foo() => 'oof';
}

makeNativeClass() native;

setup() {
  JS('', r"""
(function(){
  function NativeClass() {}
  self.makeNativeClass = function() { return new NativeClass(); };
  self.nativeConstructor(NativeClass);
})()""");
  applyTestExtensions(['NativeClass']);
}

main() {
  nativeTesting();
  setup();
  Expect.equals('oof', makeNativeClass().foo());
  other.main();
}
