import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/providers/assistances_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void showAdminCreateAssistancePage(
    {required BuildContext context,
    bool isEdit = false,
    required String practicumUid,
    required String predictId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateAssistancePage(
        isEdit: isEdit,
        practicumUid: practicumUid,
        predictId: predictId,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateAssistancePage extends StatefulWidget {
  final String practicumUid;
  final String predictId;
  final bool isEdit;

  const CreateAssistancePage({
    super.key,
    required this.isEdit,
    required this.practicumUid,
    required this.predictId,
  });

  @override
  State<CreateAssistancePage> createState() => _CreateAssistancePageState();
}

class _CreateAssistancePageState extends State<CreateAssistancePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final idGroupController = TextEditingController();
  final ValueNotifier<String?> _assistantNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    idGroupController.text = widget.predictId;
    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
        ..fetchAll(
          roleId: 2,
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    idGroupController.dispose();
    _assistantNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = context.watch<ProfileNotifier>();
    final listAssistant = profileNotifier.listData;

    final notifier = context.watch<AssistancesNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (notifier.isSuccessState('create')) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        notifier.reset();
      }
    });

    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              final provider = context.read<AssistancesNotifier>();

              if (_formKey.currentState!.validate()) {
                final assistantIndex = listAssistant.indexWhere(
                    (element) => element.username == _assistantNotifier.value);

                //* Create new practicum
                provider.create(
                    entity: AssistanceGroupEntity(
                  assistant:
                      ProfileEntity.fromDetail(listAssistant[assistantIndex]),
                  name: idGroupController.text,
                  practicumUid: widget.practicumUid,
                ));
              }
            },
            icon: const Icon(
              Icons.check_rounded,
              color: Palette.white,
            ),
          )
        ],
        title: Text(
          widget.isEdit ? 'Edit Data' : 'Tambah Data',
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextField(
                    controller: idGroupController,
                    title: 'ID Group Asistensi (Auto Generate)'),
                const SizedBox(
                  height: 16,
                ),
                if (profileNotifier.isSuccessState('find')) ...[
                  InputDropdownField(
                    selectItem: _assistantNotifier,
                    title: 'Asisten',
                    listItem: listAssistant.map((e) => e.username!).toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
