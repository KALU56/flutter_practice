// lib/widgets/display_panel.dart

import 'package:flutter/material.dart';
import '../app_config/app_constants.dart';

class DisplayPanel extends StatelessWidget {
  final String output;
  final String input;

  const DisplayPanel({
    super.key,
    required this.output,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
   
          if (input.isNotEmpty && input != output)
            Text(
              input,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).textTheme.displayMedium?.color?.withOpacity(0.6) ?? Colors.grey,
                fontSize: AppConstants.displayFontSizeSmall,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        
          Text(
            output,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: output.length > 10 ? AppConstants.displayFontSizeSmall : AppConstants.displayFontSizeLarge,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}