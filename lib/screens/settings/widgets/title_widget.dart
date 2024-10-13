part of './../../../core/helpers/export_manager/export_manager.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.titleText,
  });
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveFontSize(context, fontSize: 20.sp),
          ),
    );
  }
}
