import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final Widget? loadingWidget;
  final Color? loadingColor;

  const LoadingButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.loadingColor,
    this.decoration,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  late BoxDecoration decoration;
  late Widget loadingWidget;
  late Color textDefaultColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buildDecoration();
    buildLoadingWidget();
  }

  void buildDecoration() {
    final bgColor = widget.backgroundColor ?? Theme.of(context).primaryColor;

    textDefaultColor = widget.loadingColor ?? Theme.of(context).primaryColor;

    decoration = widget.decoration ??
        BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        );
  }

  void buildLoadingWidget() {
    loadingWidget = widget.loadingWidget ??
        SizedBox(
          key: Key('loadingWidget'),
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(textDefaultColor),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    buildDecoration();
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: Center(
        child: AnimatedContainer(
          child: widget.isLoading ? loadingWidget : widget.child,
          padding: widget.isLoading ? EdgeInsets.all(10) : null,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: widget.isLoading
              ? decoration.copyWith(borderRadius: BorderRadius.circular(100))
              : decoration,

        ),
      ),
    );
  }
}
