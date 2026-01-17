import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/colors.dart';
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

    _videoController = YoutubePlayerController.fromVideoId(
      videoId: 'opt3YZN0GTo', // REPLACE WITH YOUR VIDEO ID
      params: const YoutubePlayerParams(showControls: true, mute: false),
    );
  }

  void _handleScroll() {
    if (!mounted) return;
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero).dy;
      final screenHeight = MediaQuery.of(context).size.height;

      // Animation starts when the widget is 70% from the top
      double progress = (1.0 - (position / (screenHeight * 0.7))).clamp(0.0, 1.0);

      if (_scrollProgress != progress) {
        setState(() => _scrollProgress = progress);
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
    return Container(
      height: widget.height,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        // Center everything to bring them together
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200), // Limits the total width
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Keeps them tight in the middle
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT SIDE: OUR VISION
              Flexible(
                // Use Flexible instead of Expanded to prevent stretching
                flex: 2,
                child: Opacity(
                  opacity: _scrollProgress,
                  child: Transform.translate(
                    offset: Offset(-400 * (1 - _scrollProgress), 0), // Reduced travel distance
                    child: Text(
                      'OUR\nVISION',
                      textAlign: TextAlign.left,

                      style: TextStyle(color: FColors.black, fontSize: 130, fontWeight: FontWeight.bold, height: 0.85, letterSpacing: -2),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 50), // This is the ONLY gap between them
              // RIGHT SIDE: YouTube Embed
              Flexible(
                flex: 3,
                child: Opacity(
                  opacity: _scrollProgress,
                  child: Transform.translate(
                    offset: Offset(400 * (1 - _scrollProgress), 0), // Reduced travel distance
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: YoutubePlayer(controller: _videoController, aspectRatio: 16 / 9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
