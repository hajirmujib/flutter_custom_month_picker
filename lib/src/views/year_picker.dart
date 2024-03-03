part of 'custom_month_picker.dart';

class _YearPicker extends StatefulWidget {
  const _YearPicker(
      {required this.highlightColor,
      this.backgroundColor = Colors.white,
      required this.onSelected,
      this.textStyle});

  final Color highlightColor;
  final Color backgroundColor;
  final Function(int, int) onSelected;
  final TextStyle? textStyle;

  @override
  State<_YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<_YearPicker> {
  late _MonthYearController controller;

  @override
  void initState() {
    super.initState();
    // get the controller from the parent
    controller = _MonthYearController.of();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: widget.backgroundColor,
      padding: const EdgeInsets.only(bottom: 10),
      child: RawScrollbar(
        radius: const Radius.circular(20),
        thickness: 4,
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 1.8,
          children: List.generate(
              controller.yearList.length,
              (index) => GestureDetector(
                    onTap: () {
                      // set the selected year and close the year selection
                      controller.setYear(int.parse(controller.yearList[index]));
                      controller.yearSelectionStarted(false);
                      widget.onSelected(
                          controller.selected.month, controller.selected.year);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.selectedYear.value ==
                                  int.parse(controller.yearList[index])
                              ? widget.highlightColor
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          controller.yearList[index],
                          style: widget.textStyle == null
                              ? TextStyle(
                                  color: controller.selectedYear.value ==
                                          int.parse(controller.yearList[index])
                                      ? Colors.white
                                      : const Color(
                                          0xFF546071,
                                        ),
                                  fontWeight: FontWeight.w500,
                                )
                              : widget.textStyle!.copyWith(
                                  color: controller.selectedYear.value ==
                                          int.parse(controller.yearList[index])
                                      ? Colors.white
                                      : const Color(0xFF546071),
                                  fontWeight: FontWeight.w500,
                                ),
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
