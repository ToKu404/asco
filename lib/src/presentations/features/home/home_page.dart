import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entities.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/features/menu/main_menu_page.dart';
import 'package:asco/src/presentations/features/menu/profile/assistant/assistant_profile_page.dart';
import 'package:asco/src/presentations/features/menu/profile/student/profile_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/side_menu/side_menu_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showHomePage({required BuildContext context, required int roleId}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          roleId: roleId,
        ),
        settings: const RouteSettings(
          name: AppRoute.homePage,
        ),
      ),
      (route) => false);
}

class HomePage extends StatefulWidget {
  final int roleId;
  const HomePage({super.key, required this.roleId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false).getSelfDetail();
    });
  }

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SideMenuParent(
      onSelect: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      isMainMenu: false,
      isShowBottomNav: false,
      body: Builder(builder: (context) {
        if (_selectedIndex == -2) {
          return widget.roleId == 1
              ? const StudentProfilePage()
              : const AssistantProfilePage();
        } else if (_selectedIndex == 5) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
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
            child: Builder(builder: (context) {
              final provider = context.watch<ProfileNotifier>();

              if (provider.isLoadingState('self') || provider.data == null) {
                return const AscoLoading();
              } else if (provider.isErrorState('self')) {
                return const Center(
                  child: Text('Error'),
                );
              }
              final List<ClassroomEntity> classrooms = [];
              for (var k in provider.data!.userPracticums!.keys) {
                classrooms.add(provider.data!.userPracticums![k]!.classroom!);
              }
              return ListView.builder(
                padding: const EdgeInsets.all(
                  16,
                ),
                itemBuilder: (context, index) {
                  return CourseCard(
                    badge: AssetPath.getVector('badge_android.svg'),
                    colorBg: Palette.purple60,
                    time:
                        'Setiap hari ${classrooms[index].meetingDay} Pukul 10.10 - 12.40',
                    title:
                        '${classrooms[index].practicum?.course} ${classrooms[index].classCode}',
                  );
                },
                itemCount: classrooms.length,
              );
            }),
          ),
        );
      }),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String badge;
  final String title;
  final String time;
  final Color colorBg;
  const CourseCard({
    Key? key,
    required this.badge,
    required this.title,
    required this.time,
    required this.colorBg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          showMainMenuPage(context: context);
        },
        child: Stack(
          children: [
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
                  AssetPath.getVector(
                    'bg_attribute2.svg',
                  ),
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
                  AssetPath.getVector(
                    'bg_attribute2.svg',
                  ),
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
                  children: [
                    Row(
                      children: [
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
                          child: SvgPicture.asset(
                            badge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                          child: Builder(builder: (context) {
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
                                border:
                                    Border.all(width: 1, color: Palette.grey),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    AssetPath.getImage(
                                        'avatar${index + 1}.jpg'),
                                  ),
                                ),
                              ),
                            );
                          }),
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
