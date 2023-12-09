import 'package:flutter/material.dart';
import 'package:typeracer/constants/routes.dart';
import 'package:typeracer/constants/strings.dart';
import 'package:typeracer/constants/styles.dart';
import 'package:typeracer/widgets/custom_buttom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Strings.mainHeading,
              style: AppStyle.mainHeadingStyle,
            ),
            SizedBox(height: size.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Create',
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.createRoom),
                  isHome: true,
                ),
                CustomButton(
                  text: 'Join',
                  onTap: () => Navigator.of(context).pushNamed(Routes.joinRoom),
                  isHome: true,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
