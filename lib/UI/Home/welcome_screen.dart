import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Home/achievements.dart';
import 'package:quiz_v2/UI/Home/choose_category_screen.dart';
import 'package:quiz_v2/UI/Home/shop_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/player_provider.dart';
import '../../providers/question_provider.dart';
import '../Widgets/playerProfile/welcome_screen_item.dart';

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
        backgroundColor: Colors.white,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            playerProvider.fetchPlayerData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AchievementsPage(),
                              ),
                            );
                          },
                          child: const WelcomeScreenButton(
                            name: 'Achievements',
                            buttonColor: Colors.cyanAccent,
                            icon: FontAwesomeIcons.trophy,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                          child: const WelcomeScreenButton(
                            name: 'Shop',
                            buttonColor: Colors.redAccent,
                            icon: FontAwesomeIcons.cartShopping,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            playerProvider.playTapSound();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChooseCategoryScreen(),
                              ),
                            );
                          },
                          child: const WelcomeScreenButton(
                            name: 'Play!',
                            buttonColor: Colors.lightGreenAccent,
                            icon: FontAwesomeIcons.gamepad,
                          ),
                        ),
                        const SizedBox(height: 40),
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
