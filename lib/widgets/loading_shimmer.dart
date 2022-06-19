import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Shimmer.fromColors(
            child: Container(
              color: Colors.grey,
            ),
            baseColor: Colors.transparent,
            highlightColor: Colors.grey[300]!,
            enabled: true,
            direction: ShimmerDirection.ttb,
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}
