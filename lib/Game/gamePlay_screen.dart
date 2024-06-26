import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:tomatshake/Game/Model/board.dart';

class TomatoShake extends FlameGame with HasGameRef{
  late Layer bgColorLayer;
  late SpriteComponent dollarImg;
  late SpriteComponent jarImg;
  late SpriteComponent boxImg;
  late SpriteComponent boxImg2;
  late double boxX;
  late double boxY;
  Board? board;

  @override
  Future<void> onLoad() async {
    boxX  = gameRef.size.x * 0.020;
    boxY = gameRef.size.y * 0.30;
    // TODO: implement onLoad
    bgColorLayer = ColorLayer();
    dollarImg = SpriteComponent()
      ..sprite = await loadSprite(
        "dollar.png",
      )
      ..size = Vector2(gameRef.size.x * 0.125, gameRef.size.y * 0.039)
      ..position = Vector2(gameRef.size.x * 0.84, gameRef.size.y * 0.050);
    add(dollarImg);
    jarImg = SpriteComponent()
      ..sprite = await loadSprite(
        "jar.png",
      )
      ..size = Vector2(gameRef.size.x * 0.080, gameRef.size.y * 0.076)
      ..position = Vector2(gameRef.size.x * 0.094, gameRef.size.y * 0.033);
    add(jarImg);
    boxImg = SpriteComponent()
      ..sprite = await loadSprite(
        "bgBox.png",
      )
      ..size = Vector2(gameRef.size.x * 0.97, gameRef.size.y * 0.46)
      ..position = Vector2(boxX, boxY);
    add(boxImg);
    overlays.add("TomatoSwiper");
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    bgColorLayer.render(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) async {

    super.update(dt);
  }
}


class ColorLayer extends PreRenderedLayer {
  @override
  void drawLayer() {
    canvas.drawColor(const Color(0xff434343), BlendMode.screen);
  }
}
