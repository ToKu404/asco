import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/input_field/input_dropdown_field.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:flutter/material.dart';

void showAdminCreateAssistancePage(
    {required BuildContext context, bool isEdit = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateAssistancePage(isEdit: isEdit),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class CreateAssistancePage extends StatefulWidget {
  final bool isEdit;

  const CreateAssistancePage({super.key, required this.isEdit});

  @override
  State<CreateAssistancePage> createState() => _CreateAssistancePageState();
}

class _CreateAssistancePageState extends State<CreateAssistancePage> {
  final idGroupController = TextEditingController();
  final ValueNotifier<String?> _assistantNotifier = ValueNotifier(null);

  final _listAssistant = [
    'Alip',
    'Richard',
    'Fajri',
    'Sony',
    'Taksim',
    'Toku',
  ];

  @override
  void dispose() {
    super.dispose();
    idGroupController.dispose();
    _assistantNotifier.dispose();
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
            Icons.close_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextField(
                  controller: idGroupController,
                  title: 'ID Group Asistensi (Auto Generate)'),
              const SizedBox(
                height: 16,
              ),
              InputDropdownField(
                selectItem: _assistantNotifier,
                title: 'Asisten',
                listItem: _listAssistant,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
