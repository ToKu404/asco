import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/admin/providers/asset_select_provider.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminPracticumAssistantPage(
    {required BuildContext context,
    required String uid,
    required List<ProfileEntity> assistants}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminPracticumAssistantPage(
        uid: uid,
        assistants: assistants,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminPracticumAssistantPage extends StatefulWidget {
  final String uid;
  final List<ProfileEntity> assistants;
  const AdminPracticumAssistantPage(
      {super.key, required this.uid, required this.assistants});

  @override
  State<AdminPracticumAssistantPage> createState() =>
      _AdminPracticumAssistantPageState();
}

class _AdminPracticumAssistantPageState
    extends State<AdminPracticumAssistantPage> {
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
          roleId: 2,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<PracticumNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (notifier.isSuccessState('update_assistant')) {
        notifier.reset();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    });

    return ChangeNotifierProvider<UserSelectedProvider>(
        create: (context) => UserSelectedProvider(
              init: widget.assistants,
            ),
        builder: (context, _) {
          final assistantSelect = context.watch<UserSelectedProvider>();

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
                  onPressed: () async {
                    notifier.updateAssistant(
                        assistants: assistantSelect.user,
                        practicumUid: widget.uid);
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                    color: Palette.white,
                  ),
                )
              ],
              title: Text(
                assistantSelect.user.isEmpty
                    ? 'Pilih Asisten'
                    : '${assistantSelect.user.length} Asisten Dipilih',
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
                                AssetPath.getIcons('search_outlined.svg'),
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
                      final dataProvider = context.watch<ProfileNotifier>();

                      // Todo : Add Shimmer
                      if (dataProvider.isLoadingState('find')) {
                        return const SizedBox.shrink();
                      } else if (dataProvider.isErrorState('find')) {
                        return const SizedBox.shrink();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16 + 65,
                        ),
                        itemBuilder: (context, index) {
                          final data = dataProvider.listData[index];
                          final profile = ProfileEntity.fromDetail(data);
                          return SelectUserCard(
                            asistant: profile,
                            isSelect: assistantSelect.isItemSelected(profile),
                            onTap: () {
                              assistantSelect.isItemSelected(profile)
                                  ? assistantSelect.removeAsset(profile)
                                  : assistantSelect.addAsset(profile);
                            },
                          );
                        },
                        itemCount: dataProvider.listData.length,
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
  final ProfileEntity asistant;
  final VoidCallback onTap;
  final bool isSelect;
  const SelectUserCard({
    super.key,
    required this.onTap,
    required this.asistant,
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
                  '@${asistant.username ?? ""}',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple60,
                  ),
                ),
                Text(
                  asistant.fullName ?? '',
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
