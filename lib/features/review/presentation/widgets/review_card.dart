
import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/circle_icon_button.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
    
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                CircleIconButton(icon: Icons.person, onTap: () {}),
                const SizedBox(width: 12,),
                Text('Rokaya Raka',
                style: TextStyle(fontSize: 16,fontWeight: .bold),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Text(''' The shoe is cushioned in a way that makes me want to do all my long runs in them. It doesn’t drag as some cushioned shoes do, but feels responsive,” she said.''',
             style: TextStyle(fontSize: 14,color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
