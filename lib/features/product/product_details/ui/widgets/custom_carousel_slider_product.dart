import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/features/home/data/model/product_model.dart';
import 'package:lamsa/features/product/product_details/ui/widgets/full_screen_image_viewer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSliderProductDetails extends StatefulWidget {
  final List<String> imageUrls;
  final String productId;
  final bool autoPlay;
  final double aspectRatio;
  final bool showThumbnails;
  final bool showZoomOption;
  final bool showFavoriteOption;
  final bool showShareOption;
  final bool showVideoIndicator;
  final Color activeIndicatorColor;
  final Color indicatorColor;
  final Color appBarIconsColor;
  final Color appBarBackgroundColor;
  final ProductModel product;

  const CustomCarouselSliderProductDetails({
    super.key,
    required this.imageUrls,
    required this.productId,
    this.autoPlay = false,
    this.aspectRatio = 1.0,
    this.showThumbnails = true,
    this.showZoomOption = true,
    this.showFavoriteOption = true,
    this.showShareOption = true,
    this.showVideoIndicator = false,
    this.activeIndicatorColor = Colors.red,
    this.indicatorColor = Colors.white,
    this.appBarIconsColor = Colors.white,
    this.appBarBackgroundColor = Colors.black54,
    required this.product,
  });

  @override
  State<CustomCarouselSliderProductDetails> createState() =>
      _CustomCarouselSliderProductDetailsState();
}

class _CustomCarouselSliderProductDetailsState
    extends State<CustomCarouselSliderProductDetails> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  bool _isFavorite = false;
  bool _showAppBar = true;
  bool _showThumbnails = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    // TODO: Implement actual favorite logic
  }

  void _shareProduct() {
    // TODO: Implement share functionality
  }

  void _toggleUIElements() {
    setState(() {
      _showAppBar = !_showAppBar;
      _showThumbnails = !_showThumbnails;
    });
  }

  void _openFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => FullScreenImageViewer(
              imageUrls: widget.imageUrls,
              initialIndex: _currentIndex,
              productId: widget.productId,
              isFavorite: _isFavorite,
              onFavoriteToggle: _toggleFavorite,
              appBarIconsColor: widget.appBarIconsColor,
              appBarBackgroundColor: widget.appBarBackgroundColor,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _toggleUIElements,
          onDoubleTap: widget.showZoomOption ? _openFullScreen : null,
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.imageUrls.length,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width / widget.aspectRatio,
              viewportFraction: 1.0,
              autoPlay: widget.autoPlay && widget.imageUrls.length > 1,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Hero(
                tag: 'product_image_${widget.productId}_$index',
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrls[index],
                  fit: BoxFit.contain,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildErrorWidget(),
                ),
              );
            },
          ),
        ),

        // App Bar
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
                if (widget.showShareOption)
                  IconButton(
                    icon: Icon(Icons.share, color: widget.appBarIconsColor),
                    onPressed: _shareProduct,
                  ),
                if (widget.showFavoriteOption)
                  IconButton(
                    icon: Icon(
                      widget.product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          widget.product.isFavorite
                              ? Colors.red
                              : widget.appBarIconsColor,
                    ),
                    onPressed: _toggleFavorite,
                  ),
              ],
            ),
          ),

        // Bottom Indicators
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: _showThumbnails ? 100.h : 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: widget.imageUrls.length,
                effect: ScrollingDotsEffect(
                  activeDotColor: widget.activeIndicatorColor,
                  dotColor: widget.indicatorColor.withOpacity(0.5),
                  dotHeight: 8.h,
                  dotWidth: 8.h,
                  activeDotScale: 1.4,
                  spacing: 4.w,
                ),
              ),
            ),
          ),

        // Thumbnails
        if (widget.showThumbnails &&
            _showThumbnails &&
            widget.imageUrls.isNotEmpty)
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(index),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              _currentIndex == index
                                  ? widget.activeIndicatorColor
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrls[index],
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => _buildThumbnailPlaceholder(),
                          errorWidget:
                              (context, url, error) =>
                                  _buildThumbnailErrorWidget(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        // Video & Zoom Indicators
        Positioned(
          bottom: _showThumbnails ? 150.h : 90.h,
          right: 20.w,
          child: Column(
            children: [
              // if (widget.showVideoIndicator)
              //   Container(
              //     padding: EdgeInsets.all(6.w),
              //     decoration: BoxDecoration(
              //       color: Colors.black.withOpacity(0.6),
              //       borderRadius: BorderRadius.circular(20.r),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(Icons.play_arrow, color: Colors.red, size: 16.w),
              //         SizedBox(width: 4.w),
              //         Text(
              //           'VIDEO',
              //           style: TextStyle(
              //             color: Colors.red,
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              if (widget.showZoomOption)
                GestureDetector(
                  onTap: _openFullScreen,
                  child: Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.zoom_in, color: Colors.white, size: 16.w),
                        SizedBox(width: 4.w),
                        Text(
                          'ZOOM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: widget.activeIndicatorColor,
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
      ),
    );
  }

  Widget _buildThumbnailPlaceholder() {
    return Container(color: Colors.grey[200], width: 50.w, height: 50.h);
  }

  Widget _buildThumbnailErrorWidget() {
    return Container(
      color: Colors.grey[200],
      width: 50.w,
      height: 50.h,
      child: Icon(Icons.broken_image, size: 20.w, color: Colors.grey),
    );
  }
}
