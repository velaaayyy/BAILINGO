import 'package:flutter/material.dart';

void main() {
  runApp(const BailingoApp());
}

class BailingoApp extends StatelessWidget {
  const BailingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF174C3C);

    return MaterialApp(
      title: 'BAILINGO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF9EE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: const Color(0xFFFFC857),
          surface: const Color(0xFFFFF9EE),
        ),
        fontFamily: 'Avenir',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 850),
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _rise = Tween<Offset>(
    begin: const Offset(0, 0.08),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.height < 720;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _rise,
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      _BrandArtwork(compact: compact),
                      SizedBox(height: compact ? 25 : 34),
                      const Text(
                        'BAILINGO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF174C3C),
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          height: 1,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'A little language, a lot more world.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF68736B),
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(flex: 2),
                      const _DailyPracticeNote(),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF174C3C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Get started'),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded, size: 19),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF174C3C),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Text('I already have an account'),
                      ),
                      SizedBox(height: compact ? 14 : 26),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandArtwork extends StatelessWidget {
  const _BrandArtwork({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final artSize = compact ? 220.0 : 270.0;

    return SizedBox(
      width: artSize,
      height: artSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: artSize * 0.78,
            height: artSize * 0.78,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE6A8),
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: 8,
            top: artSize * 0.24,
            child: const _WordBubble(
              text: 'hola!',
              color: Color(0xFFE96D52),
              rotation: -0.12,
            ),
          ),
          Positioned(
            right: 2,
            top: artSize * 0.31,
            child: const _WordBubble(
              text: 'ciao',
              color: Color(0xFF5C9E79),
              rotation: 0.1,
            ),
          ),
          Container(
            width: artSize * 0.46,
            height: artSize * 0.46,
            decoration: BoxDecoration(
              color: const Color(0xFF174C3C),
              borderRadius: BorderRadius.circular(34),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x30174C3C),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(
              Icons.forum_rounded,
              color: Color(0xFFFFD166),
              size: 58,
            ),
          ),
          Positioned(
            right: artSize * 0.23,
            bottom: artSize * 0.14,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFE96D52),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          Positioned(
            left: artSize * 0.21,
            bottom: artSize * 0.16,
            child: const Icon(Icons.circle, color: Color(0xFF5C9E79), size: 13),
          ),
        ],
      ),
    );
  }
}

class _WordBubble extends StatelessWidget {
  const _WordBubble({
    required this.text,
    required this.color,
    required this.rotation,
  });

  final String text;
  final Color color;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1D174C3C),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _DailyPracticeNote extends StatelessWidget {
  const _DailyPracticeNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFE4F0E6),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.bolt_rounded,
            color: Color(0xFF397A5C),
            size: 21,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Just 5 minutes a day',
          style: TextStyle(
            color: Color(0xFF526159),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
