import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String productId;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final Color appBarIconsColor;
  final Color appBarBackgroundColor;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.productId,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.appBarIconsColor,
    required this.appBarBackgroundColor,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showAppBar = !_showAppBar;
              });
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 4,
                  child: Hero(
                    tag: 'product_image_${widget.productId}_$index',
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrls[index],
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (_showAppBar)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: widget.appBarBackgroundColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: widget.appBarIconsColor),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          widget.isFavorite
                              ? Colors.red
                              : widget.appBarIconsColor,
                    ),
                    onPressed: widget.onFavoriteToggle,
                  ),
                ],
              ),
            ),

          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: 30.h,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: widget.imageUrls.length,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.white.withOpacity(0.5),
                    dotHeight: 8.h,
                    dotWidth: 8.h,
                    spacing: 4.w,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
