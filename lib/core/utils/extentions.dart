import 'package:flutter/material.dart';

extension ContextExtentions on BuildContext {
  double get dw => MediaQuery.of(this).size.width;

  double get dh => MediaQuery.of(this).size.height;

  /// Get the current text scaler from the context
  TextScaler get textScaler => MediaQuery.of(this).textScaler;
}
