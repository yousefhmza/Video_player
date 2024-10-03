import '../services/responsive/responsive_service.dart';

extension SizeExtension on num {
  bool isBetweenExclusive(num start, num end) => this >= start && this < end;

  double get w => Responsive.instance.widthScaleFactor.toDouble() * this;

  double get h => Responsive.instance.heightScaleFactor.toDouble() * this;

  double get r => Responsive.instance.radiusScaleFactor.toDouble() * this;

  double get sp => Responsive.instance.textScaleFactor.toDouble() * this;
}
