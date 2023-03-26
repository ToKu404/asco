import 'package:asco/src/data/models/meeting_models/meeting_models.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/laboratory/student/student_laboratory_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/meeting_card.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class StudentLaboratoryPage extends StatefulWidget {
  final String? classroomId;
  const StudentLaboratoryPage({
    super.key,
    required this.classroomId,
  });

  @override
  State<StudentLaboratoryPage> createState() => _StudentLaboratoryPageState();
}

class _StudentLaboratoryPageState extends State<StudentLaboratoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<ClassroomNotifier>(context, listen: false)
            ..getDetail(uid: widget.classroomId!),
          Provider.of<MeetingNotifier>(context, listen: false)
            ..fetch(classroomUid: widget.classroomId),
        });
  }

  @override
  Widget build(BuildContext context) {
    final labNotifier = context.watch<ClassroomNotifier>();
    final meetingNotifier = context.watch<MeetingNotifier>();

    if (labNotifier.isLoadingState('single') ||
        labNotifier.data == null ||
        meetingNotifier.isLoadingState("find")) {
      return const AscoLoading(
        withScaffold: true,
      );
    }
    final classroom = labNotifier.data;

    final labMenuCards = <MenuCard>[
      MenuCard(
        title: 'Tata Tertib',
        strokeColor: Palette.purple40,
        fillColor: Palette.purple20,
        iconName: 'card_list_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Kontrak Kuliah',
        strokeColor: Palette.salmon40,
        fillColor: Palette.salmon20,
        iconName: 'file_contract_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Rekap Materi',
        strokeColor: Palette.plum40,
        fillColor: Palette.plum20,
        iconName: 'book_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Riwayat Kehadiran',
        strokeColor: Palette.azure40,
        fillColor: Palette.azure20,
        iconName: 'history_outlined.svg',
        onTap: () {},
      ),
    ];

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  bottom: -8,
                  child: Container(
                    width: AppSize.getAppWidth(context) - 80,
                    height: 16,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      color: Palette.purple100,
                    ),
                  ),
                ),
                Container(
                  width: AppSize.getAppWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Palette.purple60,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${classroom?.practicum?.course} ${classroom?.classCode}",
                                style: kTextTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Setiap hari ${classroom?.meetingDay} Pukul 10.10 - 12.40',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  color: Palette.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 43,
                          height: 47,
                          child: SvgPicture.asset(
                            AssetPath.getVector('badge_android.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 16 / 7,
                shrinkWrap: true,
                children: labMenuCards,
              ),
            ),
            const SizedBox(height: 16),
            Builder(builder: (context) {
              final List<DetailMeetingEntity> meetingData = [];
              final DateTime now = DateTime.now();
              int lastIndex = 0;
              for (int i = 0; i < meetingNotifier.listData.length; i++) {
                if (meetingNotifier.listData[i].meetingDate!
                    .isBefore(DateTime(now.year, now.month, now.day))) {
                  meetingData.add(meetingNotifier.listData[i]);
                  lastIndex = i;
                } else {
                  break;
                }
              }
              if (lastIndex < meetingNotifier.listData.length - 1) {
                meetingData.add(meetingNotifier.listData[lastIndex + 1]);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Pertemuan',
                          style: kTextTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Palette.purple100,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AssetPath.getIcon('arrow_sort_filled.svg'),
                            color: Palette.purple100,
                            width: 20,
                          ),
                          tooltip: 'Sort',
                        ),
                      ],
                    ),
                  ),
                  if (meetingData.length < meetingNotifier.listData.length)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            width: 2,
                            color: Palette.white,
                          ),
                          foregroundColor: Palette.white,
                          disabledForegroundColor: Palette.white,
                          backgroundColor: Palette.purple60.withOpacity(.4),
                          disabledBackgroundColor:
                              Palette.purple60.withOpacity(.4),
                        ),
                        child: Text(
                            'Pertemuan ${meetingData.length + 1} Segera...'),
                      ),
                    ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return MeetingCard(
                        meetingData:
                            MeetingEntity.fromDetail(meetingData[index]),
                        number: index + 1,
                        onTap: () {
                          showStudentLaboratoryCourseDetailPage(context);
                        },
                      );
                    },
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meetingData.length,
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
