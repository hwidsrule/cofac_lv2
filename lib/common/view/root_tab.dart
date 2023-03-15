import 'package:flutter/material.dart';
import 'package:my_delivery/common/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefalutLayout(
      child: Center(
        child: Text('RootTab'),
      ),
    );
  }
}
