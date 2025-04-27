import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:storypad_layout_builder/views/layouts/show/local_widgets/grid_page.dart';
import 'package:storypad_layout_builder/views/layouts/show/story_page.dart';

class StoryPagesBuilder extends StatelessWidget {
  const StoryPagesBuilder({
    super.key,
    required this.pages,
    required this.layoutType,
    required this.header,
    required this.onChanged,
  });

  final Widget header;
  final StoryPagesLayoutType layoutType;
  final List<StoryPage> pages;
  final void Function(int pageIndex, StoryPage newPage) onChanged;

  @override
  Widget build(BuildContext context) {
    switch (layoutType) {
      case StoryPagesLayoutType.pages:
        return NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(child: header),
            ];
          },
          body: PageView.builder(
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Text(
                      page.title,
                      style: TextTheme.of(context).titleLarge,
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Text(
                      page.body,
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      case StoryPagesLayoutType.grid1:
        double mainAxisSpacing = 16.0;
        double crossAxisSpacing = 16.0;

        return NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(child: header),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(child: buildPage(0)),
              ),
            ];
          },
          body: pages.length - 1 <= 0
              ? SizedBox.shrink()
              : AlignedGridView.count(
                  padding: EdgeInsets.only(
                    top: mainAxisSpacing,
                    left: 16.0,
                    right: 16.0,
                  ),
                  crossAxisCount: 2,
                  itemCount: pages.length - 1,
                  mainAxisSpacing: mainAxisSpacing,
                  crossAxisSpacing: crossAxisSpacing,
                  itemBuilder: (context, index) {
                    return buildPage(index + 1);
                  },
                ),
        );
      case StoryPagesLayoutType.grid2:
        return PageView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final page = pages[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    page.title,
                    style: TextTheme.of(context).titleLarge,
                  ),
                  Text(
                    page.body,
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ],
              ),
            );
          },
        );
    }
  }

  Widget buildPage(int index) {
    return GridPage(
      page: pages[index],
      onChanged: (StoryPage newPage) => onChanged(index, newPage),
    );
  }
}
