import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/config/l10n/app_localizations.dart';
import 'package:footy_vision_frontend/shared/constants.dart';
import 'package:footy_vision_frontend/shared/styles.dart';
import 'package:footy_vision_frontend/shared/widgets/f_button.dart';

class ServicesPage extends StatefulWidget {
  final double? height;
  final ScrollController scrollController;
  const ServicesPage({super.key, this.height, required this.scrollController});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  double _scrollProgress = 0.0;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
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
              child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    final t = AppLocalizations.of(context)!;
    final double topPart = CurveTween(curve: const Interval(0.0, 0.6, curve: Curves.easeOut)).transform(_scrollProgress);

    //final double bottomPart = CurveTween(curve: const Interval(0.6, 1.0, curve: Curves.easeOut)).transform(_scrollProgress);

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitleText(title: t.ourServices.toUpperCase(), maxSize: 80.0, align: TextAlign.center, textColor: FColors.orange),
          const SizedBox(height: 20),
          Text(t.subOurServices, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal)),
          const SizedBox(height: 50),
          AnimatedLine(progress: topPart),
          const SizedBox(height: 50),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: packageTile(t.bronzePackage, t.bronzeSubtitle, [t.bronzeFeat1, t.bronzeFeat2, t.bronzeFeat3, t.bronzeFeat4, t.bronzeFeat5, t.bronzeFeat6])),
              Expanded(child: packageTile(t.silverPackage, t.silverSubtitle, [t.silverFeat1, t.silverFeat2, t.silverFeat3, t.silverFeat4, t.silverFeat5])),
              Expanded(child: packageTile(t.goldPackage, t.goldSubtitle, [t.goldFeat1, t.goldFeat2, t.goldFeat3, t.goldFeat4, t.goldFeat5, t.goldFeat6])),
              Expanded(
                child: packageTile(t.platinumPackage, t.platinumSubtitle, [t.platinumFeat1, t.platinumFeat2, t.platinumFeat3, t.platinumFeat4, t.platinumFeat5, t.platinumFeat6]),
              ),
            ],
          ),
          const SizedBox(height: 50),
          _buildTitleText(title: t.corporateEventsTitle.toUpperCase(), maxSize: 40.0, align: TextAlign.center, textColor: FColors.orange),
          const SizedBox(height: 20),
          Text(t.corporateEventsSub, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    final t = AppLocalizations.of(context)!;
    return Container(height: 500, color: Colors.white);
  }

  Widget _buildTitleText({String? title, double? maxSize, TextAlign? align, Color? textColor}) {
    return SizedBox(
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

  Widget packageTile(String title, String subtitle, List<String> features) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(minHeight: 520),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              color: FColors.blackSoft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align icon with top of text
                  children: [
                    Icon(Icons.check_circle, color: FColors.orange, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(feature, style: theme.textTheme.titleMedium)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(child: FButton(label: t.enquireNow)),
          ],
        ),
      ),
    );
  }
}
