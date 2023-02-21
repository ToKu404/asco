import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void showAdminCreateClassPage(
    {required BuildContext context,
    bool isEdit = false,
    required String practicumUid,
    required String courseName,
    }) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateClassPage(
        isEdit: isEdit,
        practicumUid: practicumUid,
        courseName: courseName,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateClassPage extends StatefulWidget {
  final String practicumUid;
  final String courseName;
  final bool isEdit;

  const CreateClassPage(
      {super.key, required this.isEdit, required this.practicumUid, required this.courseName,});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final idClassController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final ValueNotifier<String?> _dayNotifier = ValueNotifier(null);
  TimeHelper? classTime;

  final _listDay = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  @override
  void dispose() {
    super.dispose();
    idClassController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    _dayNotifier.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ClassroomNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (notifier.isSuccessState('create')) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        notifier.reset();
      }
    });
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _onSubmit();
            },
            icon: const Icon(
              Icons.check_rounded,
              color: Palette.white,
            ),
          )
        ],
        title: Text(
          widget.isEdit ? 'Edit Data' : 'Tambah Data',
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextField(
                    controller: idClassController, title: 'Nama Kelas'),
                const SizedBox(
                  height: 16,
                ),
                InputDropdownField(
                  selectItem: _dayNotifier,
                  title: 'Setiap Hari',
                  listItem: _listDay,
                ),
                const SizedBox(
                  height: 16,
                ),
                InputTimeField(
                  controller1: startTimeController,
                  title: 'Waktu Mulai - Selesai',
                  action: (TimeHelper th) {
                    classTime = th;
                  },
                  withEndTime: true,
                  controller2: endTimeController,
                  isRequired: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    final provider = context.read<ClassroomNotifier>();

    if (_formKey.currentState!.validate()) {
      //* Create new practicum
      provider.create(
        entity: ClassroomEntity(
          startHour: classTime?.startHour,
          endHour: classTime?.endHour,
          endMinute: classTime?.endMinute,
          startMinute: classTime?.startMinute,
          meetingDay: _dayNotifier.value,
          classCode: idClassController.text,
          courseName: widget.courseName,
        ),
        practicumUid: widget.practicumUid,
      );
    }
  }
}
