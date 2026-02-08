import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/config/l10n/app_localizations.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:footy_vision_frontend/shared/styles.dart';
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
  bool _isVideoActive = false;

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
          bool isMobile = constraints.maxWidth < 850;

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
    final t = AppLocalizations.of(context)!;
    final double topPart = CurveTween(curve: const Interval(0.0, 0.6, curve: Curves.easeOut)).transform(_scrollProgress);

    final double bottomPart = CurveTween(curve: const Interval(0.6, 1.0, curve: Curves.easeOut)).transform(_scrollProgress);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // THIS IS KEY: Don't let the row expand
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT SIDE: OUR VISION
              // We use a fixed width or a flexible with a smaller constraint
              _animatedOpacityElement(
                progress: topPart,
                offset: Offset(-travel * (1 - topPart), 0),
                child: SizedBox(
                  width: 400, // Control exactly how wide the text area is
                  child: _buildTitleText(title: t.ourVision('n').toUpperCase(), maxSize: 130, align: TextAlign.center, textColor: FColors.blackSoft),
                ),
              ),

              const SizedBox(width: 40), // The exact gap you want
              // RIGHT SIDE: YouTube
              _animatedOpacityElement(
                progress: topPart,
                offset: Offset(travel * (1 - topPart), 0),
                child: SizedBox(
                  width: 600, // Control exactly how wide the video is
                  child: _buildVideoPlayer(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          AnimatedLine(progress: bottomPart),
          const SizedBox(height: 50),
          _animatedOpacityElement(
            progress: bottomPart,
            offset: Offset(0, -travel * (1 - bottomPart)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTitleText(title: t.getInTouch.toUpperCase(), maxSize: 80, align: TextAlign.center, textColor: FColors.orange),
            ),
          ),
          const SizedBox(height: 40),
          _animatedOpacityElement(progress: bottomPart, offset: Offset(0, -travel * (1 - bottomPart)), child: _buildGetInTouch()),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(double travel) {
    final t = AppLocalizations.of(context)!;
    final double topPart = CurveTween(curve: const Interval(0.0, 0.6, curve: Curves.easeOut)).transform(_scrollProgress);

    final double bottomPart = CurveTween(curve: const Interval(0.6, 1.0, curve: Curves.easeOut)).transform(_scrollProgress);

    return SingleChildScrollView(
      // Added to ensure internal constraints don't break
      //physics: const NeverScrollableScrollPhysics(), // Let the main controller handle it
      child: Column(
        children: [
          // Text coming from TOP
          _animatedOpacityElement(
            progress: topPart,
            offset: Offset(0, -travel * (1 - topPart)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTitleText(title: t.ourVision('other').toUpperCase(), align: TextAlign.center, textColor: FColors.blackSoft),
            ),
          ),
          _animatedOpacityElement(progress: topPart, offset: Offset(0, travel * (1 - topPart)), child: _buildVideoPlayer()),
          const SizedBox(height: 20),
          AnimatedLine(progress: topPart),
          const SizedBox(height: 20),
          _animatedOpacityElement(
            progress: bottomPart,
            offset: Offset(0, -travel * (1 - bottomPart)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTitleText(title: t.getInTouch.toUpperCase(), align: TextAlign.center, textColor: FColors.orange),
            ),
          ),
          _animatedOpacityElement(progress: bottomPart, offset: Offset(0, -travel * (1 - bottomPart)), child: _buildGetInTouch()),
        ],
      ),
    );
  }

  Widget _animatedOpacityElement({required double progress, required Offset offset, required Widget child}) {
    return Opacity(
      opacity: progress,
      child: Transform.translate(offset: offset, child: child),
    );
  }

  Widget _buildTitleText({String? title, double? maxSize, TextAlign? align, Color? textColor}) {
    return SizedBox(
      // Ensure it has a defined area to fill
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: align == TextAlign.left ? Alignment.centerLeft : Alignment.center,
        child: Text(
          title ?? 'TITLE',
          textAlign: align,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: textColor, fontSize: maxSize),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the width is narrow (Mobile), we don't let the video hit the edges
        bool isNarrow = constraints.maxWidth < 850;
        double horizontalPadding = isNarrow ? 30.0 : 0.0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: YoutubePlayer(controller: _videoController, aspectRatio: 16 / 9),
                ),
              ),
              if (!_isVideoActive)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVideoActive = true; // Unlock video controls on tap
                      });
                    },
                    // By not handling onVerticalDrag, the scroll continues to bubble up to your Page
                    child: Container(color: Colors.transparent),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGetInTouch() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 850;
        final t = AppLocalizations.of(context)!;
        final tiles = [
          FeatureTile(isMobile: isMobile, icon: Icons.video_camera_front_outlined, title: t.smartAICoverage, subtitle: t.subSmartAICoverage),
          FeatureTile(isMobile: isMobile, icon: Icons.movie_edit, title: t.multiAnglePerspective, subtitle: t.subMultiAnglePerspective),
          FeatureTile(isMobile: isMobile, icon: Icons.photo_camera_back_outlined, title: t.customHighlights, subtitle: t.subCustomHighligths),
          FeatureTile(isMobile: isMobile, icon: Icons.monitor, title: t.onDemandAccess, subtitle: t.subOnDemandAccess),
        ];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: isMobile
              ? tiles.map((tile) => Padding(padding: const EdgeInsets.only(bottom: 20), child: tile)).toList()
              : [
                  Row(
                    children: [
                      Expanded(child: tiles[0]),
                      Expanded(child: tiles[1]),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(child: tiles[2]),
                      Expanded(child: tiles[3]),
                    ],
                  ),
                ],
        );
      },
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isMobile;

  const FeatureTile({super.key, required this.icon, required this.title, required this.subtitle, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      isThreeLine: true,
      leading: Icon(icon, color: FColors.orange, size: isMobile ? 60 : 120),
      title: Text(
        title,
        style: isMobile ? theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold) : theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle, softWrap: true, style: isMobile ? theme.textTheme.bodyLarge : theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
    );
  }
}
