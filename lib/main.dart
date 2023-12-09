import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/routes.dart';
import 'package:typeracer/provders/client_provider.dart';
import 'package:typeracer/provders/game_provider.dart';
import 'package:typeracer/screens/create_room_screen.dart';
import 'package:typeracer/screens/game_screen.dart';
import 'package:typeracer/screens/home_screen.dart';
import 'package:typeracer/screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientStateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Type Racer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          Routes.homeScreen: (context) => const HomeScreen(),
          Routes.createRoom: (context) => const CreateRoomScreen(),
          Routes.joinRoom: (context) => const JoinRoomScreen(),
          Routes.gameScreen: (context) => const GameScreen(),
        },
      ),
    );
  }
}
