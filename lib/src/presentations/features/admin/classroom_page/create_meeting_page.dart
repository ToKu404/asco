import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/input_field/input_date_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void showAdminCreateMeetingPage({
  required BuildContext context,
  bool isEdit = false,
  required String classroomUid,
  required List<ProfileEntity> students,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateMeetingPage(
        isEdit: isEdit,
        classroomUid: classroomUid,
        students: students,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateMeetingPage extends StatefulWidget {
  final String classroomUid;
  final bool isEdit;
  final List<ProfileEntity> students;
  const CreateMeetingPage({
    super.key,
    required this.isEdit,
    required this.classroomUid,
    required this.students,
  });

  @override
  State<CreateMeetingPage> createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final ValueNotifier<String?> _assistant1 = ValueNotifier(null);
  final ValueNotifier<String?> _assistant2 = ValueNotifier(null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? meetingDate;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
        ..fetchAll(
          roleId: 2,
        ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    _dateController.dispose();
    _assistant1.dispose();
    _assistant2.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = context.watch<ProfileNotifier>();
    final listAssistant = profileNotifier.listData;

    final notifier = context.watch<MeetingNotifier>();

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
              FocusScope.of(context).unfocus();
              final provider = context.read<MeetingNotifier>();

              if (_formKey.currentState!.validate()) {
                final assistant1Index = listAssistant.indexWhere(
                    (element) => element.username == _assistant1.value);
                final assistant2Index = listAssistant.indexWhere(
                    (element) => element.username == _assistant2.value);
                //* Create new practicum
                provider.create(
                    entity: DetailMeetingEntity(
                      assistant1Uid: assistant1Index != -1
                          ? listAssistant[assistant1Index].uid
                          : null,
                      assistant2Uid: assistant2Index != -1
                          ? listAssistant[assistant2Index].uid
                          : null,
                      classUid: widget.classroomUid,
                      meetingDate: meetingDate,
                      modulPath: '',
                      topic: _topicController.text,
                    ),
                    listStudentId:
                        widget.students.map((e) => e.username!).toList());
              }
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
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(controller: _topicController, title: 'Materi'),
              const SizedBox(
                height: 16,
              ),
              InputDateField(
                action: (DateTime dt) {
                  meetingDate = dt;
                },
                controller: _dateController,
                title: 'Tanggal Pertemuan',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Modul',
                style: kTextTheme.titleSmall?.copyWith(
                  color: Palette.black,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.azure40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.auto_stories_outlined,
                        size: 20,
                        color: Palette.white,
                      ),
                      label: Text(
                        'Tampilkan',
                        style: kTextTheme.bodyLarge?.copyWith(
                          color: Palette.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.file_upload_rounded,
                      color: Palette.white,
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.plum40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Palette.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              if (profileNotifier.isSuccessState('find'))
                InputDropdownField(
                  selectItem: _assistant1,
                  title: 'Pemateri',
                  listItem: listAssistant.map((e) => e.username!).toList(),
                ),
              const SizedBox(
                height: 16,
              ),
              if (profileNotifier.isSuccessState('find'))
                InputDropdownField(
                  selectItem: _assistant2,
                  title: 'Pendamping',
                  listItem: listAssistant.map((e) => e.username!).toList(),
                ),
            ],
          ),
        ),
      )),
    );
  }
}
