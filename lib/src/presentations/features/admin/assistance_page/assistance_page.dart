import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/presentations/features/admin/assistance_page/assistance_group_detail_page.dart';
import 'package:asco/src/presentations/features/admin/assistance_page/create_assistance_page.dart';
import 'package:asco/src/presentations/providers/assistances_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void showAdminAssistancePage({
  required BuildContext context,
  required PracticumEntity practicum,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AssistanceGroupPage(
        practicum: practicum,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AssistanceGroupPage extends StatefulWidget {
  final PracticumEntity practicum;

  const AssistanceGroupPage({super.key, required this.practicum});

  @override
  State<AssistanceGroupPage> createState() => _AssistanceGroupPageState();
}

class _AssistanceGroupPageState extends State<AssistanceGroupPage> {
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
                          widget.practicum.course ?? "-",
                          style: kTextTheme.headlineMedium?.copyWith(
                            color: Palette.blackPurple,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              _AssistanceGroupSection(practicumUid: widget.practicum.uid!),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssistanceGroupSection extends StatefulWidget {
  final String practicumUid;

  const _AssistanceGroupSection({
    required this.practicumUid,
  });

  @override
  State<_AssistanceGroupSection> createState() =>
      _AssistanceGroupSectionState();
}

class _AssistanceGroupSectionState extends State<_AssistanceGroupSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AssistancesNotifier>(context, listen: false)
          .fetch(practicumUid: widget.practicumUid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<AssistancesNotifier>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              dataProvider.isSuccessState('find')
                  ? '${dataProvider.listData.length}'
                  : '0',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.purple70,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Grup Asistensi',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const Spacer(),
            if (dataProvider.isSuccessState('find'))
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
                  onPressed: () async {
                    try {
                      showAdminCreateAssistancePage(
                        context: context,
                        practicumUid: widget.practicumUid,
                        predictId: ReusableHelper.createPredictId(
                            dataProvider.listData),
                      );
                    } catch (e) {
                      print(e.toString());
                    }
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
        if (dataProvider.isSuccessState('find'))
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AssistanceGroupCard(
                groupEntity: dataProvider.listData[index],
              );
            },
            itemCount: dataProvider.listData.length,
          ),
      ],
    );
  }
}

class AssistanceGroupCard extends StatelessWidget {
  final AssistanceGroupEntity groupEntity;
  const AssistanceGroupCard({
    super.key,
    required this.groupEntity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {
        showAdminAssistanceGroupDetailPage(
          context: context,
          groupEntity: groupEntity,
        );
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
                    'Grup Asistensi #${groupEntity.name}',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    groupEntity.assistant != null
                        ? groupEntity.assistant!.fullName ?? ''
                        : '-',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple80,
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
                      // showAdminCreateAssistancePage(
                      //     context: context, isEdit: true);
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
