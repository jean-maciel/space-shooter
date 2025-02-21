import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_project/main.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Bullet({super.position})
    : super(size: Vector2.all(16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;

    if (position.y < -height) removeFromParent();
  }
}
