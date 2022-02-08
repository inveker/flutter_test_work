import 'package:flutter/material.dart';

/// Base class for widgets that propagate their arguments.
abstract class PropsWidget extends InheritedWidget {
  const PropsWidget({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  /// Explicitly overridden at this level for ease of use.
  /// You can override it in your classes however you like.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

/// Context extension adding [props] method
///
/// [props] method implements a PropsWidget search up the tree.
extension ContextExt on BuildContext {
  T props<T extends PropsWidget>() {
    final T? result = dependOnInheritedWidgetOfExactType<T>();
    assert(result != null, 'No ${T.toString()} found in context');
    return result!;
  }
}
