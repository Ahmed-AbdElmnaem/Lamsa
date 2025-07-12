import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollAwareNavScaffold extends StatefulWidget {
  const ScrollAwareNavScaffold({
    super.key,
    required this.pages,
    required this.destinations,
    required this.navColor,
    this.labelColor = Colors.white,
    this.barHeight = 56,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : assert(
         pages.length == destinations.length,
         'pages & destinations must have the same length',
       );

  final List<Widget> pages;
  final List<NavigationDestination> destinations;
  final Color navColor;
  final Color labelColor;
  final double barHeight;
  final Duration animationDuration;

  @override
  State<ScrollAwareNavScaffold> createState() => _ScrollAwareNavScaffoldState();
}

class _ScrollAwareNavScaffoldState extends State<ScrollAwareNavScaffold>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _hideController;
  int _currentIndex = 0;
  double _lastScrollPosition = 0;
  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _hideController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: 1.0, // Start with visible bar
    );
    _applySystemUi(visible: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _hideController.dispose();
    super.dispose();
  }

  void _applySystemUi({required bool visible}) {
    final isLight = widget.navColor.computeLuminance() > 0.5;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: widget.navColor,
        systemNavigationBarColor: widget.navColor,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.axis == Axis.vertical) {
        final currentPosition = notification.metrics.pixels;
        _isScrollingDown = currentPosition > _lastScrollPosition;
        _lastScrollPosition = currentPosition;

        if (notification.scrollDelta!.abs() > 5) {
          _handleScrollDirection(_isScrollingDown);
        }
      }
    }
    return false;
  }

  void _handleScrollDirection(bool isScrollingDown) {
    if (isScrollingDown) {
      if (_hideController.value != 0.0) {
        _hideController.animateTo(0.0);
      }
    } else {
      if (_hideController.value != 1.0) {
        _hideController.animateTo(1.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: widget.navColor,
      body: Stack(
        children: [
          // Main content
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
                _hideController.animateTo(
                  1.0,
                ); // Ensure bar is visible on page change
              },
              itemCount: widget.pages.length,
              itemBuilder: (_, index) {
                return NotificationListener<ScrollNotification>(
                  onNotification: _handleScrollNotification,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: statusBarHeight,
                      bottom: bottomPadding,
                    ),
                    child: widget.pages[index],
                  ),
                );
              },
            ),
          ),

          // Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _hideController,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    (1 - _hideController.value) *
                        (widget.barHeight + bottomPadding),
                  ),
                  child: Material(
                    color: widget.navColor,
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        height: widget.barHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            widget.destinations.length,
                            (index) => _NavBarItem(
                              destination: widget.destinations[index],
                              isSelected: _currentIndex == index,
                              labelColor: widget.labelColor,
                              onTap: () {
                                if (_currentIndex != index) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                                _hideController.animateTo(
                                  1.0,
                                ); // Show bar on tap
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.destination,
    required this.isSelected,
    required this.labelColor,
    required this.onTap,
  });

  final NavigationDestination destination;
  final bool isSelected;
  final Color labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(
                color: isSelected ? labelColor : Colors.grey,
                size: 24,
              ),
              child: destination.icon,
            ),
            const SizedBox(height: 4),
            Text(
              destination.label,
              style: TextStyle(
                color: isSelected ? labelColor : Colors.grey,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
