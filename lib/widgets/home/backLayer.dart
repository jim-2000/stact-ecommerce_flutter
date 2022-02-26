import 'package:flutter/material.dart';

class BackLayer extends StatelessWidget {
  const BackLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _rotatedLayer(
          angel: -0.5,
          left: -20,
          top: -150,
        ),
        _rotatedLayer(
          angel: 0.5,
          right: -20,
          top: -150,
        ),
        _rotatedLayer(
          angel: 0.5,
          left: 20,
          bottom: -150,
        ),
        _rotatedLayer(
          angel: -0.5,
          right: 20,
          bottom: -150,
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.network(
                        "https://avatars.githubusercontent.com/u/64397792?s=400&u=b893043c1c3b0a6ef368d9c9e4ee71dda86159c6&v=4"),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                _backLayerBtn(
                  icon: Icons.home,
                  title: "Home",
                  onPressed: () {},
                ),
                _backLayerBtn(
                  icon: Icons.rss_feed,
                  title: "Feed",
                  onPressed: () {},
                ),
                _backLayerBtn(
                  icon: Icons.search,
                  title: "Search",
                  onPressed: () {},
                ),
                _backLayerBtn(
                  icon: Icons.shopping_bag,
                  title: "Cart",
                  onPressed: () {},
                ),
                _backLayerBtn(
                  icon: Icons.upload,
                  title: "Upload Product",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _rotatedLayer extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double angel;

  const _rotatedLayer({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.angel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: angel,
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _backLayerBtn extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  const _backLayerBtn({
    required this.icon,
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
