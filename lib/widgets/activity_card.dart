import 'package:flutter/material.dart';
import '../models/activity_item.dart';

/// STATIC / PRESENTATIONAL widget -> StatelessWidget.
///
/// This card never holds its own mutable state: it just renders whatever
/// ActivityItem it is given and reports taps via onTap. That's exactly
/// the kind of component that belongs as a StatelessWidget.
class ActivityCard extends StatelessWidget {
  final ActivityItem item;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Column + Expanded keep the content flexible so the card
          // never overflows on narrow phones or wide tablets.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: item.color.withValues(alpha: 0.15),
                child: Icon(item.icon, color: item.color),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  item.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
