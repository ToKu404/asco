import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/class_detail_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_class_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/practicum_assistant_page.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void showAdminPracticumDetailPage(
    {required BuildContext context, required PracticumEntity practicumEntity}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PracticumDetailPage(
        practicumName: practicumEntity.course ?? '',
        practicumBadge: practicumEntity.badgePath ?? '',
        practicumId: practicumEntity.uid!,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class PracticumDetailPage extends StatelessWidget {
  final String practicumName;
  final String practicumId;
  final String practicumBadge;
  const PracticumDetailPage({
    super.key,
    required this.practicumBadge,
    required this.practicumId,
    required this.practicumName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAdminCreatePracticumPage(context: context, isEdit: true);
            },
            icon: const Icon(
              Icons.edit_rounded,
              color: Palette.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      AssetPath.getVector('badge_android.svg'),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mata Kuliah',
                          style: kTextTheme.titleSmall?.copyWith(
                              color: Palette.blackPurple,
                              fontWeight: FontWeight.w400,
                              height: 1.2),
                        ),
                        Text(
                          practicumName,
                          style: kTextTheme.headlineSmall?.copyWith(
                            color: Palette.blackPurple,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              _ClassroomSection(
                uid: practicumId,
                practicumName: practicumName,
              ),
              const SizedBox(
                height: 20,
              ),
              _AssistantsSection(
                uid: practicumId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssistantsSection extends StatefulWidget {
  final String uid;

  const _AssistantsSection({required this.uid});

  @override
  State<_AssistantsSection> createState() => __AssistantsSectionState();
}

class __AssistantsSectionState extends State<_AssistantsSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<PracticumNotifier>(context, listen: false)
        ..getDetail(uid: widget.uid),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<PracticumNotifier>();

    if (dataProvider.isLoadingState('single') || dataProvider.data == null) {
      return const SizedBox.shrink();
    } else if (dataProvider.isErrorState('single')) {
      return const SizedBox.shrink();
    }

    final List<ProfileEntity> listAssistant =
        dataProvider.data!.listAssistant == null
            ? []
            : dataProvider.data!.listAssistant!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${listAssistant.length}',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.purple70,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Asisten',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 30,
              height: 30,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Palette.purple70,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
                onPressed: () {
                  showAdminPracticumAssistantPage(
                    context: context,
                    assistants: listAssistant,
                    uid: widget.uid,
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return UserCard(
              user: listAssistant[index],
            );
          },
          itemCount: listAssistant.length,
        )
      ],
    );
  }
}

class _ClassroomSection extends StatefulWidget {
  final String uid;
  final String practicumName;
  const _ClassroomSection({
    required this.uid,
    required this.practicumName,
  });

  @override
  State<_ClassroomSection> createState() => _ClassroomSectionState();
}

class _ClassroomSectionState extends State<_ClassroomSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => Provider.of<ClassroomNotifier>(context, listen: false)
        ..fetch(
          practicumUid: widget.uid,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<ClassroomNotifier>();

    // Todo : Add Shimmer
    if (dataProvider.isLoadingState('find')) {
      return const SizedBox.shrink();
    } else if (dataProvider.isErrorState('find')) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${dataProvider.listData.length}',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.purple70,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Kelas',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 30,
              height: 30,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Palette.purple70,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
                onPressed: () {
                  showAdminCreateClassPage(
                    context: context,
                    practicumUid: widget.uid,
                    courseName: widget.practicumName,
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return PracticumClassCard(
              classroomEntity: dataProvider.listData[index],
              practicumName: widget.practicumName,
            );
          },
          itemCount: dataProvider.listData.length,
        )
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  final ProfileEntity user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: AppSize.getAppWidth(context),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(AssetPath.getImage('avatar1.jpg')),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username ?? '',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple60,
                  ),
                ),
                Text(
                  user.fullName ?? '',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple80,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PracticumClassCard extends StatelessWidget {
  final ClassroomEntity classroomEntity;
  final String practicumName;
  const PracticumClassCard({
    super.key,
    required this.practicumName,
    required this.classroomEntity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () {
        showAdminClassDetailPage(context: context);
      },
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    practicumName,
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple80,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    classroomEntity.classCode ?? '',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Setiap ${classroomEntity.meetingDay} ${ReusableHelper.timeFormater(TimeHelper(
                      startHour: classroomEntity.startHour,
                      endHour: classroomEntity.endHour,
                      startMinute: classroomEntity.startMinute,
                      endMinute: classroomEntity.endMinute,
                    ))}',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      // showAdminCreateClassPage(context: context, isEdit: true);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Palette.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Palette.white,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
