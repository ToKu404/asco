import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/core/helpers/time_helper.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/features/menu/main_menu_page.dart';
import 'package:asco/src/presentations/features/menu/profile/assistant/assistant_profile_page.dart';
import 'package:asco/src/presentations/features/menu/profile/student/profile_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/side_menu/side_menu_parent.dart';

void showHomePage({required BuildContext context, required int roleId}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(roleId: roleId),
      settings: const RouteSettings(name: AppRoute.homePage),
    ),
    (route) => false,
  );
}

class HomePage extends StatefulWidget {
  final int roleId;

  const HomePage({super.key, required this.roleId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false).getSelfDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuParent(
      onSelect: (index) => setState(() => _selectedIndex = index),
      isMainMenu: false,
      isShowBottomNav: false,
      body: Builder(
        builder: (context) {
          if (_selectedIndex == -2) {
            return widget.roleId == 1
                ? const StudentProfilePage()
                : const AssistantProfilePage();
          }

          if (_selectedIndex == 5) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              context.read<ProfileNotifier>().reset();
              context.read<AuthNotifier>().logout();

              showWelcomePage(context: context);
            });

            return const Scaffold(
              body: SizedBox.shrink(),
            );
          }

          return Scaffold(
            backgroundColor: Palette.grey,
            appBar: AppBar(
              title: const AppBarTitle(),
            ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  final provider = context.watch<ProfileNotifier>();

                  if (provider.isLoadingState('self') ||
                      provider.data == null) {
                    return const AscoLoading();
                  }

                  if (provider.isErrorState('self')) {
                    return const Center(
                      child: Text('unknown error occured'),
                    );
                  }

                  final userPracticum = <UserPracticumEntity>[];

                  for (var k in provider.data!.userPracticums!.keys) {
                    userPracticum.add(provider.data!.userPracticums![k]!);
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: userPracticum.length,
                    itemBuilder: (_, i) {
                      final classroom = userPracticum[i].classroom;

                      return CourseCard(
                        badge: AssetPath.getVector('badge_android.svg'),
                        title: setTitleText(
                          classroom?.practicum?.course,
                          classroom?.classCode,
                        ),
                        time: setTimeText(
                          classroom?.meetingDay,
                          ReusableHelper.timeFormatter(
                            TimeHelper(
                              startHour: classroom?.startHour,
                              endHour: classroom?.endHour,
                              startMinute: classroom?.startMinute,
                              endMinute: classroom?.endMinute,
                            ),
                          ),
                        ),
                        colorBg: Palette.purple60,
                        classroomId: classroom!.uid!,
                        groupId: userPracticum[i].group != null
                            ? userPracticum[i].group!.uid!
                            : '',
                        practicumId: classroom.practicum!.uid!,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String setTitleText(String? text1, String? text2) {
    return '${text1 ?? ''} ${text2 ?? ''}';
  }

  String setTimeText(String? day, String? time) {
    return 'Setiap hari ${day ?? ''}, Pukul ${time ?? ''}';
  }
}

class CourseCard extends StatelessWidget {
  final String badge;
  final String title;
  final String time;
  final Color colorBg;
  final String classroomId;
  final String groupId;
  final String practicumId;

  const CourseCard({
    Key? key,
    required this.badge,
    required this.title,
    required this.time,
    required this.colorBg,
    required this.classroomId,
    required this.groupId,
    required this.practicumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => showMainMenuPage(
          context: context,
          classroomId: classroomId,
          groupId: groupId,
          practicumId: practicumId,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: AppSize.getAppWidth(context),
              height: 180,
              color: colorBg,
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                height: 180,
                width: 200,
                child: SvgPicture.asset(
                  AssetPath.getVector('bg_attribute2.svg'),
                  fit: BoxFit.cover,
                  color: Palette.black.withOpacity(.1),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                height: 180,
                width: 180,
                child: SvgPicture.asset(
                  AssetPath.getVector('bg_attribute2.svg'),
                  fit: BoxFit.cover,
                  color: Palette.black.withOpacity(.1),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: Text(
                            title,
                            style: kTextTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 43,
                          height: 47,
                          child: SvgPicture.asset(badge),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      time,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.white,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        4,
                        (index) => Transform.translate(
                          offset: Offset((-18 * index).toDouble(), 0),
                          child: Builder(
                            builder: (context) {
                              if (index == 3) {
                                return Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Palette.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+10',
                                      style: kTextTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Palette.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Palette.grey,
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      AssetPath.getImage(
                                        'avatar${index + 1}.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
