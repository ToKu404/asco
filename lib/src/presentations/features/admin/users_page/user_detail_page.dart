import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

void showAdminUserDetailPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const UserDetailPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key});

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
            onPressed: () {},
            icon: const Icon(
              Icons.edit_rounded,
              color: Palette.white,
            ),
          )
        ],
        title: Text(
          'Detail Pengguna',
          style: kTextTheme.titleMedium?.copyWith(
            color: Palette.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppSize.getAppWidth(context),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Palette.purple80,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        AssetPath.getImage('avatar1.jpg'),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Username',
                style: kTextTheme.titleSmall?.copyWith(
                  color: Palette.black,
                ),
              ),
              Text(
                'H071191049',
                style: kTextTheme.titleMedium?.copyWith(
                  color: Palette.purple60,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Nama Lengkap',
                style: kTextTheme.titleSmall?.copyWith(
                  color: Palette.black,
                ),
              ),
              Text(
                'Austin',
                style: kTextTheme.titleMedium?.copyWith(
                  color: Palette.purple80,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Role',
                style: kTextTheme.titleSmall?.copyWith(
                  color: Palette.black,
                ),
              ),
              Chip(
                label: Text(
                  'Asisten',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.white,
                  ),
                ),
                backgroundColor: Palette.purple60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
