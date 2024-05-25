// import 'package:flutter/material.dart';
// import 'package:sahha_app/Models/Variables.dart';

// class SuggestionDrawer extends StatelessWidget {
//   final List<dynamic> suggestions;
//   final Function(dynamic) onSuggestionTapped;

//   SuggestionDrawer({
//     required this.suggestions,
//     required this.onSuggestionTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return suggestions.isNotEmpty
//         ? ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: 150, // Max height for approximately 3 items
//             ),
//             child: ListView.builder(
//               itemCount: suggestions.length,
//               itemBuilder: (context, index) {
//                 dynamic suggestion = suggestions[index];
//                 if (suggestion is String) {
//                   return ListTile(
//                     title: Text(
//                       suggestion,
//                       style: SihhaFont.copyWith(),
//                     ),
//                     onTap: () => onSuggestionTapped(suggestion),
//                   );
//                 } else if (suggestion is Map<String, dynamic>) {
//                   return ListTile(
//                     title: Text(
//                       suggestion['name'],
//                       style: SihhaFont.copyWith(),
//                     ),
//                     subtitle: Text(
//                       suggestion['address'] ?? '',
//                       style: SihhaFont.copyWith(),
//                     ),
//                     onTap: () => onSuggestionTapped(suggestion),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           )
//         : Container();
//   }
// }
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class SuggestionDrawer extends StatelessWidget {
  final List<dynamic> suggestions;
  final Function(dynamic) onSuggestionTapped;

  SuggestionDrawer({
    required this.suggestions,
    required this.onSuggestionTapped,
  });

  @override
  Widget build(BuildContext context) {
    return suggestions.isNotEmpty
        ? ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200, // Set a maximum height for the SuggestionDrawer
            ),
            child: ListView.builder(
              shrinkWrap:
                  true, // Add this line to prevent the ListView from expanding beyond its constraints
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                dynamic suggestion = suggestions[index];
                if (suggestion is String) {
                  return ListTile(
                    title: Text(
                      suggestion,
                      style: SihhaFont.copyWith(),
                    ),
                    onTap: () => onSuggestionTapped(suggestion),
                  );
                } else if (suggestion is Map<String, dynamic>) {
                  return ListTile(
                    title: Text(
                      suggestion['name'],
                      style: SihhaFont.copyWith(),
                    ),
                    subtitle: Text(
                      suggestion['address'] ?? '',
                      style: SihhaFont.copyWith(),
                    ),
                    onTap: () => onSuggestionTapped(suggestion),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        : Container();
  }
}
