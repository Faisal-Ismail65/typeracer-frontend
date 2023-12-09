import 'package:flutter/material.dart';
import 'package:typeracer/constants/strings.dart';
import 'package:typeracer/constants/styles.dart';
import 'package:typeracer/utils/socket_methods.dart';
import 'package:typeracer/widgets/custom_buttom.dart';
import 'package:typeracer/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();

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
                  Strings.createHeading,
                  style: AppStyle.createHeadingStyle,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: _nameController,
                  hint: 'Enter Your Nickname',
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: 'Create',
                    onTap: () {
                      if (_nameController.text.trim().isNotEmpty) {
                        _socketMethods.createGame(_nameController.text.trim());
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
