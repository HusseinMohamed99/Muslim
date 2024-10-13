part of './../../core/helpers/export_manager/export_manager.dart';

class Space extends StatelessWidget {
  final double width;
  final double height;
  const Space({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
    );
  }
}
