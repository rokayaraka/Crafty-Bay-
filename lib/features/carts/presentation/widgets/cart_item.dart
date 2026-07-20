import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
                    
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.dummyPng, width: 100),
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            children: [
              Row(
                spacing: 50,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                  
                    children: [
                      Text('Title of Product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w700,
                        
                      ),
                      ),
                      Row(
                     
                        children: [
                          Text('Color: Red'),
                          SizedBox(width: 10),
                          Text('Size: XL'),
                        ],
                      ),
                    ],
                  ),
    
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              ),
    
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    '${Constants.takaSign} 100',
                    style: TextStyle(
                      fontWeight: .w700,
                      color: AppColors.themeColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 70),
                  SizedBox(
                    width: 100,
                    // child: IncDecButton(
                    //   maxcount: 20,
                    //   mincount: 1,
                    //   initialValue: 1,
                    //   onChange: (int value) {
                    //     print(value);
                    //   },
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
