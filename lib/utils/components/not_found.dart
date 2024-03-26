import 'package:anime/utils/extentions.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/images/noData.png",
          height: 200,
          width: 200,
        ),
        Text("No Data Found", style: context.textTheme.headlineSmall),
      ]),
    );
  }
}
