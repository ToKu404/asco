import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/core/utils/snack_bar_utils.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/snack_bar/content_type.dart';

class StudentAssistancePractitionerPage extends StatefulWidget {
  final String groupName;
  final String practicumId;
  final List<String> studentIds;

  const StudentAssistancePractitionerPage({
    super.key,
    required this.groupName,
    required this.practicumId,
    required this.studentIds,
  });

  @override
  State<StudentAssistancePractitionerPage> createState() =>
      _StudentAssistancePractitionerPageState();
}

class _StudentAssistancePractitionerPageState
    extends State<StudentAssistancePractitionerPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
          .fetchMultiple(multipleId: widget.studentIds),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, profileNotifier, child) {
        if (profileNotifier.isSuccessState('multiple')) {
          final classCodes = profileNotifier.listData.map((detailProfile) {
            final key = detailProfile.userPracticums!.keys
                .where((e) => e == widget.practicumId)
                .first;

            return detailProfile.userPracticums![key]!.classroom!.classCode;
          }).toList();

          return buildMainPage(
            context,
            students: profileNotifier.listData,
            classCodes: classCodes,
          );
        }

        if (profileNotifier.isErrorState('multiple')) {
          return const Scaffold(
            backgroundColor: Palette.grey,
            body: Center(
              child: Text('unknown error occured'),
            ),
          );
        }

        return const AscoLoading(
          withScaffold: true,
        );
      },
    );
  }

  Scaffold buildMainPage(
    BuildContext context, {
    required List<DetailProfileEntity> students,
    required List<String?> classCodes,
  }) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Grup Asistensi ${widget.groupName}',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        itemCount: students.length,
        itemBuilder: (_, index) => CustomStudentCard(
          student: students[index],
          isThreeLine: true,
          thirdLine: BuildBadge(
            badgeHelper: TempBadgeHelper(
              badgeId: 3,
              title: 'Kelas ${classCodes[index]}',
            ),
          ),
          hasTrailing: true,
          trailing: IconButton(
            onPressed: students[index].github!.isEmpty
                ? () {
                    final snackbar = SnackBarUtils.createSnackBar(
                      title: 'Github Tidak Ada!',
                      message: 'Siswa belum melengkapi akun Github.',
                      type: ContentType.warning,
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackbar);
                  }
                : () async {
                    await ReusableHelper.urlLauncher(students[index].github!);
                  },
            icon: SvgPicture.asset(
              AssetPath.getIcon('github_filled.svg'),
              color: Palette.purple80,
              width: 24,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Palette.grey10,
            ),
            tooltip: 'Github',
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
    );
  }
}

void showStudentAssistancePractitionerPage(
  BuildContext context, {
  required String groupName,
  required String practicumId,
  required List<String> studentIds,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => StudentAssistancePractitionerPage(
        groupName: groupName,
        practicumId: practicumId,
        studentIds: studentIds,
      ),
      settings: const RouteSettings(
        name: AppRoute.studentAssistancePractitionerPage,
      ),
    ),
  );
}
