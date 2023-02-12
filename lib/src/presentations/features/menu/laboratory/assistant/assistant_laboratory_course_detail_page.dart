import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/mentor_tile.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/search_field.dart';
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
  late final ValueNotifier<String> _queryNotifier;

  @override
  void initState() {
    _queryNotifier = ValueNotifier('');

    super.initState();
  }

  @override
  void dispose() {
    _queryNotifier.dispose();

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
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
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
                            onPressed: () {},
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
              elevation: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Palette.grey,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const TitleSection(title: 'Absensi'),
                      ValueListenableBuilder<String>(
                        valueListenable: _queryNotifier,
                        builder: (context, value, child) {
                          return SearchField(
                            text: value,
                            onChanged: (query) {
                              _queryNotifier.value = query;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: students.length,
                (_, index) {
                  final isLast = (index == students.length - 1);

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: isLast ? 24 : 10,
                    ),
                    child: StudentAttendanceCard(student: students[index]),
                  );
                },
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
        onTap: () {},
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
                    AssetPath.getImage('avatar5.jpg'),
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
                    const SizedBox(height: 1),
                    Text(
                      student.name,
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student.isAttend!
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
              if (student.isAttend!) ...[
                const AttendanceStatusBadge(
                  borderColor: Palette.purple80,
                  fillColor: Palette.purple60,
                  icon: Icons.check_rounded,
                ),
              ] else ...[
                const AttendanceStatusBadge(
                  borderColor: Color(0xFF8A6913),
                  fillColor: Color(0xFFE4CC4B),
                  icon: Icons.remove_rounded,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceStatusBadge extends StatelessWidget {
  final Color borderColor;
  final Color fillColor;
  final IconData icon;

  const AttendanceStatusBadge({
    super.key,
    required this.borderColor,
    required this.fillColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 16,
          color: Palette.white,
        ),
      ),
    );
  }
}
