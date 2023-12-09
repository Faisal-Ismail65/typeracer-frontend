import 'package:flutter/material.dart';
import 'package:typeracer/constants/strings.dart';
import 'package:typeracer/constants/styles.dart';
import 'package:typeracer/utils/socket_methods.dart';
import 'package:typeracer/widgets/custom_buttom.dart';
import 'package:typeracer/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGameListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  Strings.joinHeading,
                  style: AppStyle.joinHeadingStyle,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: _nameController,
                  hint: 'Enter Your Nickname',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _gameIdController,
                  hint: 'Enter Game ID',
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: 'Join',
                    onTap: () {
                      if (_gameIdController.text.trim().isNotEmpty &&
                          _nameController.text.trim().isNotEmpty) {
                        _socketMethods.joinGame(_gameIdController.text.trim(),
                            _nameController.text.trim());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
