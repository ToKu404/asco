import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/features/admin/users_page/create_user_page.dart';
import 'package:asco/src/presentations/features/admin/users_page/user_detail_page.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminUsersPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminUserPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false).fetchAll();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

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
        title: Text(
          'Data Pengguna',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.blackPurple,
          shape: const CircleBorder(
              side: BorderSide(width: 1, color: Palette.purple60)),
          child: const Icon(
            Icons.add_rounded,
            color: Palette.white,
          ),
          onPressed: () {
            showAdminCreateUserPage(context: context);
          }),
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
                  hintText: 'Cari nama atau nim',
                  hintStyle:
                      kTextTheme.bodyLarge?.copyWith(color: Palette.disable),
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
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                final profileNotifier = context.watch<ProfileNotifier>();

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
                    return UserCard(
                      profileData: profileNotifier.listData[index],
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
  }
}

class UserCard extends StatelessWidget {
  final DetailProfileEntity profileData;
  const UserCard({
    required this.profileData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {
        showAdminUserDetailPage(context: context);
      },
      margin: const EdgeInsets.only(bottom: 8),
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
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
                    profileData.userRole!.id! == 1
                        ? profileData.username ?? ''
                        : '@${profileData.username}',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    profileData.fullName ?? '',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  BuildBadge(
                    badgeHelper: TempBadgeHelper(
                        badgeId: profileData.userRole!.id! == 1 ? 3 : 4,
                        title: profileData.userRole!.name!),
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
                      showAdminCreateUserPage(context: context, isEdit: true);
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
