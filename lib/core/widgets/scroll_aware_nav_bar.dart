import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollAwareScaffold extends StatefulWidget {
  const ScrollAwareScaffold({
    super.key,
    required this.pages,
    required this.destinations,
    required this.navColor,
    this.labelColor = Colors.white,
    this.navMargin = const EdgeInsets.only(bottom: 16),
    this.navWidthFactor = 0.85,
    this.navHeight = 60,
    this.innerPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    this.idleDuration = const Duration(milliseconds: 1500),
  });

  final List<Widget> pages;
  final List<NavigationDestination> destinations;
  final Color navColor;
  final Color labelColor;
  final EdgeInsets navMargin;
  final double navWidthFactor;
  final double navHeight;
  final EdgeInsets innerPadding;

  /// كم من الوقت ينتظر قبل ما يُظهر الـ NavBar بعد التوقف عن السكروول.
  final Duration idleDuration;

  @override
  State<ScrollAwareScaffold> createState() => _ScrollAwareScaffoldState();
}

class _ScrollAwareScaffoldState extends State<ScrollAwareScaffold> {
  final PageController _page = PageController();
  final ScrollController _scroll = ScrollController();
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(true);
  Timer? _idleTimer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_handleScroll);
  }

  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(widget.idleDuration, () {
      if (!_visible.value) _visible.value = true;
    });
  }

  void _handleScroll() {
    final dir = _scroll.position.userScrollDirection;

    // Hide immediately while scrolling down.
    if (dir == ScrollDirection.reverse && _visible.value) {
      _visible.value = false;
    }

    // whenever scrolling (any direction) restart idle timer.
    _resetIdleTimer();

    // لو وصل لأعلى الليست أخليه يظهر فورى.
    if (_scroll.position.pixels <= 0 && !_visible.value) {
      _visible.value = true;
      _idleTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_handleScroll)
      ..dispose();
    _page.dispose();
    _visible.dispose();
    _idleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final maxW =
        widget.navWidthFactor <= 1
            ? screenW * widget.navWidthFactor
            : widget.navWidthFactor;
    final radius = widget.navHeight / 2;

    WidgetStateProperty<TextStyle?> labelStyle(Color c) =>
        WidgetStateProperty.resolveWith(
          (_) => TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w500),
        );

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView.builder(
            controller: _page,
            onPageChanged: (i) => setState(() => _index = i),
            itemCount: widget.pages.length,
            itemBuilder:
                (_, i) => PrimaryScrollController(
                  controller: _scroll,
                  child: widget.pages[i],
                ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _visible,
            builder:
                (_, show, child) => AnimatedSlide(
                  duration: const Duration(milliseconds: 280),
                  offset: show ? Offset.zero : const Offset(0, 1.5),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 280),
                    opacity: show ? 1 : 0,
                    curve: Curves.easeInOut,
                    child: child,
                  ),
                ),
            child: SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: widget.navMargin,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: _GlassBar(
                      color: widget.navColor,
                      radius: radius,
                      innerPadding: widget.innerPadding,
                      child: NavigationBarTheme(
                        data: NavigationBarThemeData(
                          labelTextStyle: labelStyle(widget.labelColor),
                          iconTheme: WidgetStateProperty.all(
                            IconThemeData(color: widget.labelColor),
                          ),
                        ),
                        child: NavigationBar(
                          height: widget.navHeight,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          indicatorColor: widget.navColor.withOpacity(0.5),
                          labelBehavior:
                              NavigationDestinationLabelBehavior.alwaysShow,
                          destinations: widget.destinations,
                          selectedIndex: _index,
                          onDestinationSelected: (i) {
                            setState(() => _index = i);
                            _page.jumpToPage(i);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassBar extends StatelessWidget {
  const _GlassBar({
    required this.color,
    required this.child,
    required this.radius,
    required this.innerPadding,
  });

  final Color color;
  final Widget child;
  final double radius;
  final EdgeInsets innerPadding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.55), color.withOpacity(0.35)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(padding: innerPadding, child: child),
        ),
      ),
    );
  }
}
