import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class AssistanceDialog extends StatefulWidget {
  final int number;
  final Student student;

  const AssistanceDialog({
    super.key,
    required this.number,
    required this.student,
  });

  @override
  State<AssistanceDialog> createState() => _AssistanceDialogState();
}

class _AssistanceDialogState extends State<AssistanceDialog> {
  DateTime _date = DateTime.now();

  late final TextEditingController _dateController;
  late final TextEditingController _noteController;
  late final ValueNotifier<String> _dateNotifier;

  @override
  void initState() {
    _dateController = TextEditingController();
    _noteController = TextEditingController();
    _dateNotifier = ValueNotifier('');

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _noteController.dispose();
    _dateNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Palette.grey10,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Palette.purple100,
                    ),
                    tooltip: 'Close',
                  ),
                  Expanded(
                    child: Text(
                      'Asistensi ${widget.number}',
                      textAlign: TextAlign.center,
                      style: kTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.purple100,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => onPressedSubmitButton(context),
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Palette.purple60,
                    ),
                    tooltip: 'Submit',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.student.nim,
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.student.name,
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.purple80,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: _dateNotifier,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _dateController,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Palette.white,
                          hintText: 'Tanggal asistensi',
                          hintStyle: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Palette.greyDark.withOpacity(.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.today_rounded,
                            color: Palette.greyDark,
                          ),
                          suffixIcon: value.isEmpty
                              ? const SizedBox()
                              : IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Palette.purple80,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    _dateController.clear();
                                    _dateNotifier.value = '';
                                  },
                                ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Palette.greyDark,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Palette.greyDark,
                            ),
                          ),
                        ),
                        style: kTextTheme.bodyLarge?.copyWith(
                          color: Palette.greyDark,
                        ),
                        onTap: () => showAssistanceDatePicker(context),
                        onChanged: (value) => _dateNotifier.value = value,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _noteController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.white,
                      hintText: 'Tambahkan catatan',
                      hintStyle: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Palette.greyDark.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Palette.greyDark,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Palette.greyDark,
                        ),
                      ),
                    ),
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.greyDark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Text(
                      'Note: kosongkan tanggal untuk membatalkan asistensi.',
                      style: kTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Palette.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showAssistanceDatePicker(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(_date.year),
      lastDate: DateTime(_date.year, 12, 31),
      currentDate: _date,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'Pilih Tanggal Asistensi',
    );

    if (newDate != null) {
      _date = newDate;

      _dateController.text = '${_date.day}/${_date.month}/${_date.year}';

      _dateNotifier.value = _dateController.text;
    }
  }

  void onPressedSubmitButton(BuildContext context) {
    // remove the focus of keybooard
    FocusScope.of(context).unfocus();

    // Do something else
    Navigator.pop(context, true);
  }
}
