import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Home/achievements.dart';
import 'package:quiz_v2/UI/Home/home.dart';
import 'package:quiz_v2/UI/Home/shop_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with WidgetsBindingObserver {
  // / ADD THIS AppLifecycleState VARIABLE
  late AppLifecycleState appLifecycle;
  final player = AudioPlayer();

  // ADD THIS FUNCTION WITH A AppLifecycleState PARAMETER
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycle = state;
    setState(() {});

    if (state == AppLifecycleState.paused) {
      // IF YOUT APP IS IN BACKGROUND...
      // YOU CAN ADDED THE ACTION HERE
      player.pause();
      log('My app is in background');
    } else {
      // player.stop();
      player.resume();
      player.onPlayerComplete.listen((event) {
        player.play(
          AssetSource('sounds/technoLoop.mp3'),
        );
      });
    }
  }

  // CREATE INITSTATE AND DISPOSE METHODS
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // playBackgroundMusic();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void playBackgroundMusic() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool shouldPlayMusic = pref.getBool('shouldPlayMusic') ?? true;
    if (shouldPlayMusic) {
      player.play(AssetSource('sounds/backgroundMusic.mp3'));
      player.onPlayerComplete.listen((event) {
        player.play(
          AssetSource('sounds/backgroundMusic.mp3'),
        );
      });
    } else {
      player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final hawkFabMenuController = HawkFabMenuController();
    return Consumer2<QuesProvider, PlayerProvider>(
      builder: (context, quesProvider, playerProvider, _) => Scaffold(
        backgroundColor: Colors.yellow.shade100,
        // floatingActionButton: HawkFabMenu(
        //   icon: AnimatedIcons.list_view,
        //   fabColor: Colors.white,
        //   iconColor: Colors.black,
        //   hawkFabMenuController: hawkFabMenuController,
        //   backgroundColor: Colors.transparent,
        //   blur: 0,
        //   buttonBorder: const BorderSide(color: Colors.black, width: 4),
        //   items: [
        //     HawkFabMenuItem(
        //       label: 'Sound',
        //       buttonBorder: const BorderSide(color: Colors.black, width: 4),
        //       ontap: () {
        //         playerProvider.toggleSoundButton();
        //       },
        //       icon: Icon(
        //         playerProvider.soundShouldPlay
        //             ? Icons.volume_up_rounded
        //             : Icons.volume_off_rounded,
        //       ),
        //       color: Colors.orange,
        //       labelColor: Colors.black,
        //     ),
        //     HawkFabMenuItem(
        //       label: 'Music',
        //       buttonBorder: const BorderSide(color: Colors.black, width: 4),
        //       ontap: () async {
        //         SharedPreferences pref = await SharedPreferences.getInstance();
        //         bool shouldPlayMusic = pref.getBool('shouldPlayMusic') ?? true;
        //         shouldPlayMusic = !shouldPlayMusic;
        //         pref.setBool('shouldPlayMusic', shouldPlayMusic);
        //         playBackgroundMusic();
        //       },
        //       icon: const Icon(Icons.music_off),
        //       labelColor: Colors.black,
        //       labelBackgroundColor: Colors.white,
        //     ),
        //   ],
        //   body: const Center(
        //     child: Text(''),
        //   ),
        // ),
        body: SafeArea(
          // background animation
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Lottie.asset(
                  'assets/lottieAnimations/patternBack.zip',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 300,
                  child: Lottie.asset(
                    'assets/lottieAnimations/redPattern.zip',
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              playerProvider.playTapSound();
                              playerProvider.fetchPlayerData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AchievementsPage(),
                                ),
                              );
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.trophy,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              playerProvider.playTapSound();
                              playerProvider.fetchPlayerData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 4,
                                ),
                              ),
                              child: const Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.cartShopping,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Shop',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 32,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: Border.all(color: Colors.black, width: 5),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: const Text(
                              'PLAY!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
