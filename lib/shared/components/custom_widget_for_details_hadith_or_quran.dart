part of './../../core/helpers/export_manager/export_manager.dart';

class CustomWidgetForDetailsHadithOrQuran extends StatelessWidget {
  const CustomWidgetForDetailsHadithOrQuran({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.imageIcon,
  });

  final Color backgroundColor;
  final String title;
  final String imageIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor == Colors.white
                ? ThemeApp.yellow
                : ThemeApp.lightPrimary,
            child: ImageIcon(
              AssetImage(imageIcon),
              color:
                  backgroundColor != Colors.white ? Colors.black : Colors.white,
            ),
          ),
          const Space(width: 10, height: 0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.elMessiri(
              fontSize: getResponsiveFontSize(context, fontSize: 25.sp),
              color:
                  backgroundColor == Colors.white ? Colors.white : Colors.black,
            ),
          ),
          const Space(width: 10, height: 0),
        ],
      ),
    );
  }
}
