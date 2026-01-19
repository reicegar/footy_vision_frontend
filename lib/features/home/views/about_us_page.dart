import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AboutUsPage extends StatefulWidget {
  final double? height;
  final ScrollController scrollController;

  const AboutUsPage({super.key, this.height, required this.scrollController});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  double _scrollProgress = 0.0;
  late YoutubePlayerController _videoController;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);

    _videoController = YoutubePlayerController.fromVideoId(videoId: 'opt3YZN0GTo', params: const YoutubePlayerParams(showControls: true, mute: false));
  }

  void _handleScroll() {
    if (!mounted) return;
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero).dy;
      final screenHeight = MediaQuery.of(context).size.height;

      // 1. Calculate the current progress based on screen position
      // This starts at 0.0 (off-screen) and reaches 1.0 (centered)
      double currentCalculation = (1.0 - (position / (screenHeight * 0.5))).clamp(0.0, 1.0);

      // 2. STICKY LOGIC:
      // If we have already reached full visibility (1.0) and the user is scrolling
      // further down (position is getting smaller/negative), we LOCK it at 1.0.
      if (position < (screenHeight * 0.2) && _scrollProgress >= 0.95) {
        if (_scrollProgress != 1.0) {
          setState(() => _scrollProgress = 1.0);
        }
        return; // Stop updating further
      }

      // 3. RESET LOGIC:
      // If the user scrolls back up near the top (Home area), reset to allow animation again.
      if (position > screenHeight * 0.8) {
        setState(() => _scrollProgress = 0.0);
        return;
      }

      // Normal animation update
      if (_scrollProgress != currentCalculation) {
        setState(() => _scrollProgress = currentCalculation);
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    _videoController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Distance elements travel from the outside
    const double travelDistance = 400.0;

    return Container(
      height: widget.height,
      width: double.infinity,
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 850; // Increased threshold for better transition

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: isMobile ? _buildMobileLayout(travelDistance) : _buildDesktopLayout(travelDistance),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(double travel) {
    return Center(
      // Center the tight group
      child: Row(
        mainAxisSize: MainAxisSize.min, // THIS IS KEY: Don't let the row expand
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT SIDE: OUR VISION
          // We use a fixed width or a flexible with a smaller constraint
          _animatedElement(
            offset: Offset(-travel * (1 - _scrollProgress), 0),
            child: Container(
              width: 400, // Control exactly how wide the text area is
              child: _buildVisionText(130, TextAlign.center),
            ),
          ),

          const SizedBox(width: 40), // The exact gap you want
          // RIGHT SIDE: YouTube
          _animatedElement(
            offset: Offset(travel * (1 - _scrollProgress), 0),
            child: Container(
              width: 600, // Control exactly how wide the video is
              child: _buildVideoPlayer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(double travel) {
    return SingleChildScrollView(
      // Added to ensure internal constraints don't break
      physics: const NeverScrollableScrollPhysics(), // Let the main controller handle it
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text coming from TOP
          _animatedElement(
            offset: Offset(0, -travel * (1 - _scrollProgress)),
            child: Padding(padding: const EdgeInsets.only(bottom: 20), child: _buildVisionText(80, TextAlign.center)),
          ),

          const SizedBox(height: 20),

          // Video coming from BOTTOM
          _animatedElement(offset: Offset(0, travel * (1 - _scrollProgress)), child: _buildVideoPlayer()),
        ],
      ),
    );
  }

  Widget _animatedElement({required Offset offset, required Widget child}) {
    return Opacity(
      opacity: _scrollProgress,
      child: Transform.translate(offset: offset, child: child),
    );
  }

  Widget _buildVisionText(double maxSize, TextAlign align) {
    return SizedBox(
      // Ensure it has a defined area to fill
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: align == TextAlign.left ? Alignment.centerLeft : Alignment.center,
        child: Text(
          'OUR\nVISION',
          textAlign: align,
          style: TextStyle(
            color: FColors.black,
            fontSize: maxSize, // 130
            fontWeight: FontWeight.bold,
            height: 0.9,
            // letterSpacing: -4,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the width is narrow (Mobile), we don't let the video hit the edges
        bool isNarrow = constraints.maxWidth < 600;
        double horizontalPadding = isNarrow ? 30.0 : 0.0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: YoutubePlayer(controller: _videoController, aspectRatio: 16 / 9),
            ),
          ),
        );
      },
    );
  }
}
