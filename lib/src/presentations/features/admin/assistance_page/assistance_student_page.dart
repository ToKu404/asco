import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/admin/providers/asset_select_provider.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminAssistanceStudentPage(
    {required BuildContext context,
    required String assistanceGroupUid,
    required String practicumUid,
    required List<ProfileEntity> students}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminAssistanceStudentPage(
        assistanceGroupUid: assistanceGroupUid,
        students: students,
        practicumUid: practicumUid,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminAssistanceStudentPage extends StatefulWidget {
  final String assistanceGroupUid;
  final List<ProfileEntity> students;
  final String practicumUid;

  const AdminAssistanceStudentPage(
      {super.key,
      required this.assistanceGroupUid,
      required this.students,
      required this.practicumUid});

  @override
  State<AdminAssistanceStudentPage> createState() =>
      _AdminAssistanceStudentPageState();
}

class _AdminAssistanceStudentPageState
    extends State<AdminAssistanceStudentPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
        ..fetchAll(
          roleId: 1,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AssistanceNotifier>();
    final profileNotifier = context.watch<ProfileNotifier>();
    // final userPracticumNotifier = context.watch<UserPracticumNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (notifier.isSuccessState('update_student') &&
          profileNotifier.isSuccessState('update_practicums')) {
        notifier.reset();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    });

    return ChangeNotifierProvider<UserSelectedProvider>(
        create: (context) => UserSelectedProvider(
              init: widget.students,
            ),
        builder: (context, _) {
          final userSelect = context.watch<UserSelectedProvider>();

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
                if (profileNotifier.isSuccessState('find'))
                  IconButton(
                    onPressed: () async {
                      await notifier.updateStudent(
                        assistanceGroupUid: widget.assistanceGroupUid,
                        students: userSelect.user,
                      );
                      final data = ReusableHelper.getPracticumData(
                        allData: profileNotifier.listData,
                        selectData: userSelect.user,
                        groupUid: widget.assistanceGroupUid,
                        practicumUid: widget.practicumUid,
                      );
                      await profileNotifier.multiplePracticumUpdate(data: data);
                    },
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Palette.white,
                    ),
                  )
              ],
              title: Text(
                userSelect.user.isEmpty
                    ? 'Pilih Mahasiswa'
                    : '${userSelect.user.length} Mahasiswa Dipilih',
                style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {},
                      keyboardType: TextInputType.text,
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.blackPurple,
                      ),
                      cursorColor: Palette.blackPurple,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'Cari nama atau username',
                        hintStyle: kTextTheme.bodyLarge
                            ?.copyWith(color: Palette.disable),
                        filled: true,
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 18,
                              width: 18,
                              child: SvgPicture.asset(
                                AssetPath.getIcon('search_outlined.svg'),
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ],
                        ),
                        prefixIconColor: Palette.blackPurple,
                        fillColor: Palette.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Palette.blackPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Palette.blackPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      // Todo : Add Shimmer
                      if (profileNotifier.isLoadingState('find')) {
                        return const SizedBox.shrink();
                      } else if (profileNotifier.isErrorState('find')) {
                        return const SizedBox.shrink();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16 + 65,
                        ),
                        itemBuilder: (context, index) {
                          final data = profileNotifier.listData[index];
                          final profile = ProfileEntity.fromDetail(data);
                          return SelectUserCard(
                            student: profile,
                            isSelect: userSelect.isItemSelected(profile),
                            onTap: () {
                              userSelect.isItemSelected(profile)
                                  ? userSelect.removeAsset(profile)
                                  : userSelect.addAsset(profile);
                            },
                          );
                        },
                        itemCount: profileNotifier.listData.length,
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class SelectUserCard extends StatelessWidget {
  final ProfileEntity student;
  final VoidCallback onTap;
  final bool isSelect;
  const SelectUserCard({
    super.key,
    required this.onTap,
    required this.student,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
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
                  '@${student.username ?? ""}',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple60,
                  ),
                ),
                Text(
                  student.fullName ?? '',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple80,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Palette.greyDark,
              ),
              color: isSelect ? Palette.purple60 : Palette.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: ClipOval(
                child: InkWell(
                  onTap: onTap,
                  child: isSelect
                      ? const Icon(
                          Icons.check_rounded,
                          color: Palette.white,
                          size: 15,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
