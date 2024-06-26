import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tomatshake/Game/Model/board_adapter.dart';
import 'package:tomatshake/Game/gameOverScreen.dart';
import 'package:tomatshake/Game/gamePlay_screen.dart';
import 'package:tomatshake/Game/tomotoShake.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
 Flame.device.setPortrait();
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());
  runApp(ProviderScope(

    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tomato Shake',
      home: GameWidget(
        game: TomatoShake(),
        overlayBuilderMap: {
          'TomatoSwiper': (BuildContext context, TomatoShake game) {
            return const TomatoSwiper();
          }
        },
      ),

    ),
  ));
  WidgetsBinding.instance.addObserver(new _Handler());


}

class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlameAudio.bgm.resume(); // Audio player is a custom class with resume and pause static methods
    } else {
      FlameAudio.bgm.stop();
      FlameAudio.audioCache.clearAll();
    }
  }
}





