
import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';

class Heart extends SpriteComponent with HasGameRef<BinaryMemoryGame>{
  @override
  Future<void>? onLoad() async{
    sprite = Sprite(await gameRef.images.load('heart.png'));
    size = Vector2(16,16);
    return super.onLoad();
  }
}