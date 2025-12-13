import 'package:dailies_v2/ui/views/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventCarousel extends StatefulWidget {
  final List<Widget> pages;
  const EventCarousel({super.key, required this.pages});

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  late final PageController _pageController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.fromLTRB(4, 0, 4, 0),
            child: IndexedStack(
              index: _index,
              children: [
                _Header(
                  title: 'Today',
                  subtitle: DateFormat.yMMMMd().format(DateTime.now()),
                ),
                _Header(
                  title: 'Tomorrow',
                  subtitle: DateFormat.yMMMMd().format(
                    DateTime.now().add(const Duration(days: 1)),
                  ),
                ),
                _Header(
                  title: 'Week',
                  subtitle:
                      '${DateFormat.MMMM().format(DateTime.now())} '
                      '${DateFormat.d().format(DateTime.now())} - '
                      '${DateFormat.d().format(DateTime.now().add(const Duration(days: 7)))}, '
                      '${DateFormat.y().format(DateTime.now())}',
                ),
              ],
            ),
          ),

          SizedBox(
            height: 280,
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _index = i),
              children: widget.pages,
            ),
          ),

          SmoothPageIndicator(
            controller: _pageController,
            count: widget.pages.length,
            effect: WormEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title, style: textTheme.headlineLarge)),
        Text(subtitle),
      ],
    );
  }
}
