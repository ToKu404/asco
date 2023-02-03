import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/pretier_qr_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.purple80,
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID Card',
                  style: kTextTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Palette.white,
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    AssetPath.getIcons('edit.svg'),
                    color: Palette.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FlipCard(
                      key: cardKey,
                      flipOnTouch: true,
                      front: const IdCardFrontSide(),
                      back: const IdCardBackSide(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Palette.white),
                      color: Palette.purple60,
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        cardKey.currentState?.toggleCard();
                      },
                      child: Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: SvgPicture.asset(
                            AssetPath.getIcons('flip.svg'),
                            color: Palette.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IdCardFrontSide extends StatelessWidget {
  const IdCardFrontSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.white,
          border: Border.all(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Palette.blackPurple,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    height: 160,
                    color: Palette.white,
                  ),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Palette.violet60.withOpacity(.8),
                          Palette.violet60.withOpacity(.4),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Palette.purple60,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RotatedBox(
                quarterTurns: -2,
                child: SizedBox(
                  height: 160,
                  width: 200,
                  child: SvgPicture.asset(
                    AssetPath.getVector('bg_attribute.svg'),
                    color: Palette.purple80.withOpacity(.5),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AppBarTitle(),
              ),
            ),
            Positioned.fill(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 160 - 60,
                    ),
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      border: Border.all(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'H071191049',
                          style: kTextTheme.bodyLarge?.copyWith(
                            color: Palette.violet30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: RichText(
                            text: TextSpan(
                              text: 'Silverius Sony Lembang',
                              style: kTextTheme.titleMedium?.copyWith(
                                color: Palette.white,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                              ),
                              children: [
                                TextSpan(
                                  text: ' (Sony)',
                                  style: kTextTheme.titleMedium?.copyWith(
                                    color: Palette.violet30,
                                    height: 1.05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'SISTEM INFORMASI 21'.toUpperCase(),
                          style: kTextTheme.bodyLarge?.copyWith(
                            color: Palette.white,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                AssetPath.getIcons(
                                  'github_filled.svg',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                'github.com/yukiao',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  height: 1,
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                AssetPath.getIcons(
                                  'instagram_filled.svg',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                'github.com/yukiao',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  height: 1,
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class IdCardBackSide extends StatelessWidget {
  const IdCardBackSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.purple60,
          border: Border.all(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Palette.blackPurple,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                height: 160,
                width: 200,
                child: SvgPicture.asset(
                  AssetPath.getVector('bg_attribute.svg'),
                  color: Palette.purple80.withOpacity(.5),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RotatedBox(
                quarterTurns: -2,
                child: SizedBox(
                  height: 160,
                  width: 200,
                  child: SvgPicture.asset(
                    AssetPath.getVector('bg_attribute.svg'),
                    color: Palette.purple80.withOpacity(.5),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.white),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Scan QR dibawah dengan ',
                              style: kTextTheme.titleSmall?.copyWith(
                                color: Palette.purple80,
                                height: 1.05,
                              ),
                              children: [
                                TextSpan(
                                  text: 'asco',
                                  style: kTextTheme.titleSmall?.copyWith(
                                    color: Palette.violet30,
                                    fontWeight: FontWeight.w700,
                                    height: 1.05,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const AspectRatio(
                            aspectRatio: 1,
                            child: BarcodeBox(
                              data: 'github.com/toku404',
                              backgroundColor: Palette.white,
                              color: Palette.purple100,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Muh. Ikhsan',
                            maxLines: 2,
                            style: kTextTheme.titleSmall?.copyWith(
                              color: Palette.purple100,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'NIM. H071191049',
                            style: kTextTheme.bodyLarge?.copyWith(
                              color: Palette.purple60,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
