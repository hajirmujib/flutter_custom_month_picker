part of 'custom_month_picker.dart';

class _MonthPicker extends StatefulWidget {
  const _MonthPicker(
      {required this.highlightColor,
      this.backgroundColor = Colors.white,
      this.textStyle,
      required this.onSelected});
  final TextStyle? textStyle;
  final Color highlightColor;
  final Color backgroundColor;
  final Function(int, int) onSelected;

  @override
  State<_MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  late MonthYearController controller;

  @override
  void initState() {
    super.initState();
    // get the controller from the parent
    controller = MonthYearController.of();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(controller.monthsName.length, (index) {
          bool isDisabled = controller.isDisabledMonth(index + 1);
          return GestureDetector(
            onTap: () {
              // if the month is disabled, do nothing
              if (isDisabled) {
                return;
              }
              // set the selected month
              controller.setMonth(index + 1);
              controller.monthSelectionStarted(false);
              widget.onSelected(
                  controller.selected.month, controller.selected.year);
            },
            child: Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                width: (MediaQuery.of(context).size.width / 3) - 40,
                margin: EdgeInsets.only(bottom: index > 8 ? 0 : 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: controller.selectedMonth.value - 1 == index
                        ? widget.highlightColor
                        : Colors.transparent),
                child: Center(
                  child: Text(
                    controller.monthsName[index],
                    style: widget.textStyle == null
                        ? TextStyle(
                            color: isDisabled
                                ? Colors.grey
                                : controller.selectedMonth.value - 1 == index
                                    ? Colors.white
                                    : const Color(0xFF546071),
                            fontSize: 14,
                            fontWeight:
                                controller.selectedMonth.value - 1 == index
                                    ? FontWeight.w700
                                    : FontWeight.w500)
                        : widget.textStyle!.copyWith(
                            color: isDisabled
                                ? Colors.grey
                                : controller.selectedMonth.value - 1 == index
                                    ? Colors.white
                                    : const Color(0xFF546071),
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
