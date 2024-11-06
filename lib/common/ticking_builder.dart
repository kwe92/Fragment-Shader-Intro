import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickingBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, double time) builder;

  const TickingBuilder({super.key, required this.builder});

  static TickingBuilderState? of(BuildContext context) => context.findAncestorStateOfType<TickingBuilderState>();

  @override
  State<TickingBuilder> createState() => TickingBuilderState();
}

class TickingBuilderState extends State<TickingBuilder> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  double _time = 0.0;

  @override
  void initState() {
    super.initState();

    // start shader animation
    ticker = createTicker(_handleTick)..start();

    // stops the shader animation after two seconds
    Future.delayed(const Duration(seconds: 10)).whenComplete(() {
      debugPrint('stopping shader animation...');
      ticker.stop();
      debugPrint(' shader animation stopped.');
    });
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void _handleTick(Duration elapsed) {
    setState(() => _time = elapsed.inMilliseconds.toDouble() / 1000.0);
  }

  @override
  Widget build(BuildContext context) => widget.builder.call(context, _time);
}
