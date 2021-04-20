import 'package:flutter/material.dart';

/// Each [NumberCol] has the numbers 0-9 stacked inside of a [SingleChildScrollView]
/// via a [ScrollController] the position will be animated to the requested number
class NumberCol extends StatefulWidget {
  /// The number the col should animate to
  final int? animateTo;

  /// The [TextStyle] of the number
  final TextStyle textStyle;
  // The [Duration] the animation will take to slide the number into place
  final Duration duration;
  // The curve that is used during the animation
  final Curve curve;

  /// Whether the widget should play the animation when the number was updated.
  final bool animateOnUpdate;

  NumberCol({
    required this.animateTo,
    required this.textStyle,
    required this.duration,
    required this.curve,
    this.animateOnUpdate = false,
  }) : assert(animateTo == null || (animateTo >= 0 && animateTo < 10));

  @override
  _NumberColState createState() => _NumberColState();
}

class _NumberColState extends State<NumberCol>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;

  double _elementSize = 0.0;

  @override
  void initState() {
    _scrollController = new ScrollController();

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      measure();
      animate();
    });
  }

  void measure() {
    _elementSize = _scrollController!.position.maxScrollExtent / 11;
    setState(() {});
  }

  void animate() {
    // index 0 is space, otherwise number - 1
    final elementIndex = widget.animateTo != null ? (widget.animateTo! + 1) : 0;
    _scrollController!.animateTo(_elementSize * elementIndex,
        duration: widget.duration, curve: widget.curve);
  }

  @override
  void didUpdateWidget(covariant NumberCol oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animateOnUpdate && widget.animateTo != oldWidget.animateTo) {
      animate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _elementSize),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Text(' ', style: widget.textStyle),
              for (var i = 0; i < 10; i++)
                Text(i.toString(), style: widget.textStyle)
            ],
          ),
        ),
      ),
    );
  }
}
