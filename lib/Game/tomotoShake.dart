import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:tomatshake/Game/Component/tomatoBoard.dart';
import 'package:tomatshake/Game/Model/tile.dart';

import 'managers/tomatoBoardManager.dart';

const alarmAudioPath = "assets/audio/bg_soung.mp3";

class TomatoSwiper extends ConsumerStatefulWidget {
  const TomatoSwiper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<TomatoSwiper>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref.read(boardManager.notifier).merge();
        _scaleController.forward(from: 0.0);
      }
    });

  late final CurvedAnimation _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (ref.read(boardManager.notifier).endRound()) {
          _moveController.forward(from: 0.0);
        }
      }
    });


  late final CurvedAnimation _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );
  static AudioCache player = AudioCache();
  bool _visible = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(seconds: 5), () {
      if (this.mounted) {
        setState(() {
          _visible = false;
                         });
      }

    });

    super.initState();
  }

  // var jarHeight = 0;
  Tile? tile;

  @override
  Widget build(BuildContext context) {
    var score = ref.watch(boardManager.select((board) => board.score));
    var jarHeight = ref
        .read(boardManager.notifier)
        .height;

    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (ref.read(boardManager.notifier).onKey(event)) {
          _moveController.forward(from: 0.0);
        }
      },
      child: SwipeDetector(
        onSwipe: (direction, offset) {
          if (ref.read(boardManager.notifier).move(direction)) {
            _moveController.forward(from: 0.0);
          }
        },
        child: Stack(
          children: [
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.893,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.095,
              child: Container(
                height: ref
                    .read(boardManager.notifier)
                    .height
                    .toDouble() < 50 ? ref
                    .read(boardManager.notifier)
                    .height
                    .toDouble() : 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.077,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),

              ),
            ),
            Positioned(
              top: 0,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.55, top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.054),
                        child: Text("$score", style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                            color: Colors.green,
                            decoration: TextDecoration.none),),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.185,),
                      Stack(
                        children: [
                          TomatoBoardWidget(
                              moveAnimation: _moveAnimation,
                              scaleAnimation: _scaleAnimation),
                                           ],

                      )
                    ],
                  ),

                  (ref
                      .read(boardManager.notifier)
                      .height == 10 )|| ref
                      .read(boardManager.notifier)
                      .height == 15 || ref
                      .read(boardManager.notifier)
                      .height == 20 ?
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _visible,
                    child: Image.asset("assets/images/paste.png"),
                  )
                      :
                  const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      ref.read(boardManager.notifier).save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}


