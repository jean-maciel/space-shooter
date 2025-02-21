import 'dart:async';

import 'package:flame/components.dart';

import '../main.dart';
import 'Bullet.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  late final SpawnComponent _bulletSpawner;

  Player({super.position})
    : super(size: Vector2.all(86), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(48),
      ),
    );

    position = gameRef.size / 2;

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(position: position + Vector2(0, -height / 2));
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
