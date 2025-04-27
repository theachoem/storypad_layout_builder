enum StoryPagesLayoutType {
  pages,
  grid1,
  grid2,
}

class Sticker {
  final double rotationDegree;
  final String imageKey;
  final int width;
  final int height;

  Sticker({
    required this.rotationDegree,
    required this.imageKey,
    required this.width,
    required this.height,
  });
}

class StoryPage {
  final String title;
  final String body;

  final Sticker? topLeftSticker;
  final Sticker? topRightSticker;
  final Sticker? bottomLeftSticker;
  final Sticker? bottomRightSticker;

  StoryPage({
    required this.title,
    required this.body,
    required this.topLeftSticker,
    required this.topRightSticker,
    required this.bottomLeftSticker,
    required this.bottomRightSticker,
  });

  StoryPage copyWithTopLeftSticker(Sticker? topLeftSticker) {
    return StoryPage(
      title: title,
      body: body,
      topLeftSticker: topLeftSticker,
      topRightSticker: topRightSticker,
      bottomLeftSticker: bottomLeftSticker,
      bottomRightSticker: bottomRightSticker,
    );
  }

  StoryPage copyWithTopRightSticker(Sticker? topRightSticker) {
    return StoryPage(
      title: title,
      body: body,
      topLeftSticker: topLeftSticker,
      topRightSticker: topRightSticker,
      bottomLeftSticker: bottomLeftSticker,
      bottomRightSticker: bottomRightSticker,
    );
  }

  StoryPage copyWithBottomLeftSticker(Sticker? bottomLeftSticker) {
    return StoryPage(
      title: title,
      body: body,
      topLeftSticker: topLeftSticker,
      topRightSticker: topRightSticker,
      bottomLeftSticker: bottomLeftSticker,
      bottomRightSticker: bottomRightSticker,
    );
  }

  StoryPage copyWithBottomRightSticker(Sticker? bottomRightSticker) {
    return StoryPage(
      title: title,
      body: body,
      topLeftSticker: topLeftSticker,
      topRightSticker: topRightSticker,
      bottomLeftSticker: bottomLeftSticker,
      bottomRightSticker: bottomRightSticker,
    );
  }
}
