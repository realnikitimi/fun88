import 'dart:async';
import 'dart:math' show min;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun88/blocs/carousel_bloc.dart';

class ImageCarousel extends StatefulWidget {
  final double height;
  final List<String> initialImageList;
  final bool showThreeItems;
  final double viewportFraction;
  final Duration autoScrollInterval;

  const ImageCarousel({
    super.key,
    required this.height,
    required this.initialImageList,
    this.showThreeItems = false,
    this.viewportFraction = 0.8,
    this.autoScrollInterval = const Duration(seconds: 3),
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.showThreeItems ? 0.33 : 1,
      initialPage: _currentPage,
    );

    // Load initial images
    context.read<CarouselBloc>().add(
      LoadCarouselImages(initialImageList: widget.initialImageList),
    );
  }

  void _startAutoScroll(List<String> images) {
    _timer?.cancel();

    if (images.length > 1) {
      _timer = Timer.periodic(widget.autoScrollInterval, (timer) {
        if (!mounted) return;

        final nextPage = _pageController.page!.round() + 1;
        if (nextPage >= _effectiveImages(images).length - 1) {
          // If we're near the end, animate to the "real" first item
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }

  List<String> _effectiveImages(List<String> images) {
    if (images.isEmpty) return [];
    return [
      images.last, // Add last item at beginning
      ...images, // Original items
      images.first, // Add first item at end
    ];
  }

  // Add this method to handle page changes
  void _handlePageChange(int page, List<String> images) {
    if (!mounted) return;

    setState(() {
      _currentPage = page;
    });

    // If we're at the fake first item (which is actually last item), jump to real last item
    if (page == 0) {
      _pageController.jumpToPage(images.length);
    }
    // If we're at the fake last item (which is actually first item), jump to real first item
    else if (page == images.length + 1) {
      _pageController.jumpToPage(1);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarouselBloc, CarouselState>(
      listener: (context, state) {
        if (state is CarouselLoaded && state.images.isNotEmpty) {
          _startAutoScroll(state.images);
        }
      },
      builder: (context, state) {
        if (state is CarouselInitial) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CarouselLoaded) {
          if (state.images.isEmpty) {
            return SizedBox(
              height: widget.height,
              child: const Center(child: Text('No images available')),
            );
          }

          return _buildCarousel(state.images);
        }

        return SizedBox(
          height: widget.height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildCarousel(List<String> images) {
    final effectiveImages = _effectiveImages(images);
    final screenWidth = MediaQuery.of(context).size.width;

    return NotificationListener<ScrollNotification>(
      child: SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _pageController,
          itemCount: effectiveImages.length,
          onPageChanged: (page) => _handlePageChange(page, images),
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double value = 1.0;
                if (_pageController.position.haveDimensions) {
                  value = _pageController.page! - index;
                  value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                }

                return SizedBox(
                  height: Curves.easeOut.transform(value) * widget.height,
                  width: Curves.easeOut.transform(value) * 200,
                  child: child,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.showThreeItems ? 4 : 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: _buildImage(effectiveImages[index]),
                  ),
                ),
              ),
            );
          },
          // ... rest of your PageView implementation
        ),
      ),
    );
  }
}
