import 'package:flutter/material.dart';

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const SlideMenu({super.key,
    required this.child, required this.menuItems
  });

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static final Map<GlobalKey, _SlideMenuState> _openMenus = {};
  final GlobalKey _key = GlobalKey();

  @override
  initState() {
    super.initState();
    _controller = AnimationController(  vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    _openMenus.remove(_key);
    super.dispose();
  }


  void _handleDragEnd() {
      _openMenus[_key] = this;
      _closeOtherMenus();
  }

  void _closeOtherMenus() {
    try {
      final keysList = _openMenus.keys.toList();
      for (var entry in keysList) {
        if (entry != _key) {
          _openMenus[entry]?._controller.reverse();
          _openMenus.remove(entry);
        }
      }

    } catch (e) {
      debugPrint("error in SlideMenuWidget when closeOtherMenus");
    }
  }

  void _checkControllerValue (){
    try {
      if(_controller.value<10){
        _openMenus.remove(_key);
      }
    } catch (e) {
      debugPrint("error in SlidMenuWidget when Check Controller value:$e");
    }
  }


  @override
  Widget build(BuildContext context) {
    ///Here the end field will determine the size of buttons which will appear after sliding
    ///If you need to appear them at the beginning, you need to change to "+" Offset coordinates (0.2, 0.0)
    final animation =
    Tween(begin: const Offset(0.0, 0.0),
        end: const Offset(-0.2, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
        key: _key,
        onHorizontalDragUpdate: (data) {
          /// we can access context.size here
          setState(() {
            ///Here we set value of Animation controller depending on our finger move in horizontal axis
            //If you want to slide to the right, change "-" to "+"
            _controller.value -= (data.primaryDelta! / (context.size!.width*0.2));
          });
        },
        onHorizontalDragEnd: (data) {
          _handleDragEnd();
          ///To change slide direction, change to data.primaryVelocity! < -1500
          if (data.primaryVelocity! > 1500) {
            _controller.animateTo(.0); ///close menu on fast swipe in the right direction
          }
          else if (_controller.value >= .5 || data.primaryVelocity! < -1500){
            _controller.animateTo(1.0); /// fully open if dragged a lot to left or on fast swipe to left
          }
          else {
            /// close if none of above
            _controller.animateTo(.0);
            _checkControllerValue();
          }
        },
        child: LayoutBuilder(builder: (context, constraint) {
          return Stack(
            children: [
              SlideTransition(
                position: animation,
                child: widget.child,
              ),

              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    ///To change slide direction to right, replace the right parameter with left:
                    return Positioned(
                      right: (_openMenus.keys.toList().contains(_key))? 0 :((constraint.maxWidth)-MediaQuery.sizeOf(context).width)/100,
                      top: .0,
                      bottom: .0,
                      width: constraint.maxWidth * animation.value.dx * -1,
                      child: Row(
                        children: widget.menuItems.map((child) {
                          return Expanded(
                            child: child,
                          );
                        }).toList(),
                      ),
                    );
                  })
            ],
          );
        })
    );
  }
}