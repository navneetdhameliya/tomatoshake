import 'dart:math';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tomatshake/Game/Component/button.dart';
import 'package:tomatshake/Game/Model/tile.dart';
import 'package:tomatshake/Game/gameOverScreen.dart';
import 'package:tomatshake/Game/managers/tomatoBoardManager.dart';
import '../const/colors.dart';
import 'animated_tile.dart';

class TomatoBoardWidget extends ConsumerWidget {
  TomatoBoardWidget(
      {super.key, required this.moveAnimation, required this.scaleAnimation});

  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;
  Tile? tile;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(boardManager.select((board) => board.score));

    final localScore = boardManager.select((board) => board.score);
    final board = ref.watch(boardManager);

    final size = max(
        MediaQuery.of(context).size.width *0.9,
        min((MediaQuery.of(context).size.shortestSide * 0.93).floorToDouble(),
            MediaQuery.of(context).size.height *0.5));
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = (sizePerTile * 4);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 13),
      child: SizedBox(
        width: boardSize + 10,
        height: boardSize + 40,
        child: Stack(
          children: [
            ...List.generate(board.tiles.length, (i) {
                     tile = board.tiles[i];
              return Stack(
                children: [
                  tileColors[tile!.value] != null ?AnimatedTile(
                    key: ValueKey(tile!.id),
                    tile: tile!,
                    moveAnimation: moveAnimation,
                    scaleAnimation: scaleAnimation,
                    size: tileSize,

                    child: tile!.index >= 12
                            ? Column(children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: tileColors[tile!.value],
                                  ),
                                  child: Image.asset(
                                    "assets/images/flower.png",
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.23,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      color: tileColors2[tile!.value]),
                                ),
                              ])
                            : Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      height: tile!.index >= 8 &&
                                              tile!.index < 7
                                          ? MediaQuery.of(context).size.height *
                                              0.106
                                          : MediaQuery.of(context).size.height *
                                              0.053,
                                      decoration: BoxDecoration(
                                        color: tileColors[tile!.value],
                                      ),
                                      child: Image.asset(
                                        "assets/images/flower.png",
                                      )),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.23,
                                    height: tile!.index >= 8 && tile!.index < 7
                                        ? MediaQuery.of(context).size.height *
                                            0.106
                                        : MediaQuery.of(context).size.height *
                                            0.053,
                                    decoration: BoxDecoration(
                                      color: tileColors2[tile!.value],
                                    ),
                                  ),
                                ],
                              )

                  ):AnimatedTile(
                      key: ValueKey(tile!.id),
                      tile: tile!,
                      moveAnimation: moveAnimation,
                      scaleAnimation: scaleAnimation,
                      size: tileSize,

                      child: tile!.index >= 12
                          ? Column(children: [
                        Container(
                          width:
                          MediaQuery.of(context).size.width * 0.23,
                          height:
                          MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: tileColors[128],
                          ),
                          child: Image.asset(
                            "assets/images/flower.png",
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.width * 0.23,
                          height:
                          MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              color: tileColors2[128]),
                        ),
                      ])
                          : Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width *
                                  0.23,
                              height: tile!.index >= 8 &&
                                  tile!.index < 7
                                  ? MediaQuery.of(context).size.height *
                                  0.106
                                  : MediaQuery.of(context).size.height *
                                  0.053,
                              decoration: BoxDecoration(
                                color: tileColors[128],
                              ),
                              child: Image.asset(
                                "assets/images/flower.png",
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.23,
                            height: tile!.index >= 8 && tile!.index < 7
                                ? MediaQuery.of(context).size.height *
                                0.106
                                : MediaQuery.of(context).size.height *
                                0.053,
                            decoration: BoxDecoration(
                              color: tileColors2[128],
                            ),
                          ),
                        ],
                      )

                  ),
                  Positioned(
                      left: 8,
                      bottom: MediaQuery.of(context).size.height * 0.001,
                      child: Image.asset(
                        "assets/images/boxFront.png",
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.94,
                        fit: BoxFit.fill,
                      )),
                ],
              );
            }),
            if (board.over )
              Positioned.fill(
                  child: Container(
                color: overlayColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      board.won ? 'Game Over!' : 'Game Over!',
                      style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          decoration: TextDecoration.none),
                    ),
                    ButtonWidget(
                      text: board.won ? 'Show Final Score' : 'Show Final Score',
                      onPressed: () {
                        FlameAudio.bgm.pause();
                        ref.read(boardManager.notifier).height = 5;
                        FlameAudio.audioCache.clearAll();

                        Get.off(() => GameOver(
                              score: score,
                            ));
                        ref.read(boardManager.notifier).newGame();
                      },
                    )
                  ],
                ),
              ))
          ],
        ),
      ),
    );
  }

}
