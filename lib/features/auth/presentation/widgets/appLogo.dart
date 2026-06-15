import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/asset_paths.dart';

class appLogo extends StatelessWidget {
  const appLogo({
    super.key,
    this.width=130,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetPaths.logoSvg,width: width,);
  }
}