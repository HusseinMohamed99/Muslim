part of './../../core/helpers/export_manager/export_manager.dart';
// Scale Factor
// Responsive Font Size
// (min , max) Font Size

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  final double scaleFactor = getScaleFactor(context);
  final double responsiveFontSize = fontSize * scaleFactor;
  final double lowerLimit = fontSize * .8;
  final double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  final double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
