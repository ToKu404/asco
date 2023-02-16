import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/laboratory/assistant/assistant_laboratory_quiz_value_input_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/attendance_dialog.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/mentor_tile.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';
import 'package:asco/src/presentations/widgets/input_field/search_field.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';

class AssistantLaboratoryCourseDetailPage extends StatefulWidget {
  const AssistantLaboratoryCourseDetailPage({super.key});

  @override
  State<AssistantLaboratoryCourseDetailPage> createState() =>
      _AssistantLaboratoryCourseDetailPageState();
}

class _AssistantLaboratoryCourseDetailPageState
    extends State<AssistantLaboratoryCourseDetailPage> {
  late final ValueNotifier<String> queryNotifier;

  @override
  void initState() {
    queryNotifier = ValueNotifier('');

    super.initState();
  }

  @override
  void dispose() {
    queryNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Pertemuan 1',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: Palette.purple80,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: -2,
                      child: SvgPicture.asset(
                        AssetPath.getVector('bg_attribute.svg'),
                        width: AppSize.getAppWidth(context) / 2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                          child: Text(
                            'Mengenal Bahasa Pemrograman Kotlin',
                            style: kTextTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Palette.white,
                            ),
                          ),
                        ),
                        const MentorTile(
                          name: 'Richard Enrico',
                          role: 'Pemateri',
                          assetName: 'avatar1.jpg',
                        ),
                        const MentorTile(
                          name: 'Muh. Yusuf Syam',
                          role: 'Pendamping',
                          assetName: 'avatar2.jpg',
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              elevation: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 6,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Palette.violet60,
                      Palette.violet30,
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const TitleSection(
                      title: 'Modul',
                      paddingBottom: 6,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.auto_stories_outlined,
                              size: 20,
                            ),
                            label: const Text('Tampilkan'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Palette.azure20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.file_upload_outlined,
                            color: Palette.white,
                            size: 20,
                          ),
                          tooltip: 'Upload',
                          style: IconButton.styleFrom(
                            backgroundColor: Palette.purple60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 1),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: Palette.white,
                            size: 20,
                          ),
                          tooltip: 'Delete',
                          style: IconButton.styleFrom(
                            backgroundColor: Palette.plum20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const TitleSection(
                      title: 'Quiz',
                      paddingBottom: 6,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Palette.purple20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Buat Quiz'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              showAssistantLaboratoryQuizValueInputPage(
                                context,
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Palette.purple60,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Input Nilai'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Palette.grey,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 64),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const TitleSection(title: 'Absensi'),
                      ValueListenableBuilder(
                        valueListenable: queryNotifier,
                        builder: (context, value, child) {
                          return SearchField(
                            text: value,
                            onChanged: (query) => queryNotifier.value = query,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: students.length,
                  (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: StudentAttendanceCard(student: students[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 4,
        backgroundColor: Palette.purple100,
        foregroundColor: Palette.white,
        shape: const CircleBorder(
          side: BorderSide(
            width: 2,
            color: Palette.purple60,
          ),
        ),
        tooltip: 'Scan QR',
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }

  void showAssistantLaboratoryQuizValueInputPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AssistantLaboratoryQuizValueInputPage(),
        settings: const RouteSettings(
          name: AppRoute.assistantLaboratoryQuizValueInputPage,
        ),
      ),
    );
  }
}

class StudentAttendanceCard extends StatelessWidget {
  final Student student;

  const StudentAttendanceCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          barrierLabel: '',
          barrierDismissible: false,
          builder: (_) => AttendanceDialog(student: student),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 28,
                backgroundColor: Palette.purple80,
                child: CircleAvatar(
                  radius: 26,
                  foregroundImage: AssetImage(
                    AssetPath.getImage('avatar${student.id}.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      student.nim,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student.name,
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student.isAttend
                          ? 'Waktu absensi: 23:59'
                          : 'Terhalang Banjir',
                      style: kTextTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (student.isAttend) ...[
                const CircleBorderContainer(
                  size: 32,
                  borderColor: Palette.purple80,
                  fillColor: Palette.purple60,
                  child: Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Palette.white,
                  ),
                ),
              ] else ...[
                const CircleBorderContainer(
                  size: 32,
                  borderColor: Color(0xFF8A6913),
                  fillColor: Color(0xFFE4CC4B),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 18,
                    color: Palette.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
