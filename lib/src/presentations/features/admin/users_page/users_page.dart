import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/users_page/create_user_page.dart';
import 'package:asco/src/presentations/features/admin/users_page/user_detail_page.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';

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

class AdminUserPage extends StatelessWidget {
  const AdminUserPage({super.key});

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
              width: AppSize.getAppWidth(context),
              height: 65,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InkWellContainer(
                    color: Colors.white,
                    onTap: () {
                      showAdminUserDetailPage(context: context);
                    },
                    radius: 12,
                    child: Container(
                      width: AppSize.getAppWidth(context),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage(AssetPath.getImage('avatar1.jpg')),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'H071191049',
                                  style: kTextTheme.bodyMedium?.copyWith(
                                    color: Palette.purple60,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'Ikhsan',
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
                                      badgeId: 3, title: 'Mahasiswa'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
