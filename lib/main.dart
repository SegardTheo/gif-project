import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gif/services/navigation_service.dart';
import 'api/api.dart';
import 'services/simple_animations_package.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gyffi",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
        ),

        fontFamily: 'Hind',

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        )
      ),
      home: const Scaffold(
        body: ParticleBackgroundPage(),
      ),
    );
  }
}

class ParticleBackgroundPage extends StatelessWidget {
  const ParticleBackgroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        const Positioned.fill(child: AnimatedBackground()),
        const Positioned.fill(child: Particles(30)),
        Positioned.fill(child: CenteredText()),
      ],
    );
  }
}

/// Créée les particules en arrière plan
class Particles extends StatefulWidget {
  final int numberOfParticles;

  const Particles(this.numberOfParticles, {key}) : super(key: key);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: const Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    for (var particle in particles) {
      particle.maintainRestart(time);
    }
  }
}

class ParticleModel {
  late Animatable tween;
  late double size;
  late AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 3000 + random.nextInt(6000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    for (var particle in particles) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
      Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Créée le fondu de couleur sur le background
class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(
          const Duration(seconds: 3),
          ColorTween(
              begin: const Color(0xff8a113a), end: Colors.lightBlue.shade900)),
      Track("color2").add(const Duration(seconds: 3),
          ColorTween(begin: const Color(0xff440216), end: Colors.greenAccent))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, dynamic animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}

/// Affiche le texte et le bouton au centre de l'écran
class CenteredText extends StatelessWidget {
  CenteredText({
    Key? key,
  }) : super(key: key);

  final Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: const Text("Gyffi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 75, color: Colors.white)),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.image,
            color: Colors.white,
            size: 45,
          ),
          label: const Text('GO',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          onPressed: () {
            NavigationService.navigateToHomePage(context, api);
          },
          style: ElevatedButton.styleFrom(
            padding:  const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
            shadowColor: Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        )
      ]
    );
  }
}