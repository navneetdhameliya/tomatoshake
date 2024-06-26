import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatshake/Game/gamePlay_screen.dart';
import 'package:tomatshake/Game/tomotoShake.dart';

class GameOver extends StatelessWidget {
  int score;

  GameOver({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/gameOverBg.png",
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Game over!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Money",
                style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$score",
                    style: const TextStyle(color: Colors.green, fontSize: 23),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/dollar.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.fill,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  onPressed: () {
                    Get.to(() {
                      return GameWidget(
                        game: TomatoShake(),
                        overlayBuilderMap: {
                          'TomatoSwiper':
                              (BuildContext context, TomatoShake game) {
                            return const TomatoSwiper();
                          }
                        },
                      );
                    });
                  },
                  color: const Color(0xff434343),
                  height: 40,
                  child: const Text(
                    "Sart Again",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
