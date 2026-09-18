import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity_item.dart';
import '../providers/app_state_provider.dart';
import '../widgets/activity_card.dart';

/// The Home Dashboard is itself a StatefulWidget only because it needs
/// initState-level setup in a bigger app; here it's kept Stateless-like
/// in spirit (no local mutable UI state) but we use StatelessWidget
/// directly since nothing local ever changes on this screen -- every
/// piece of dynamic info (profile name, theme) comes from the provider.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  List<ActivityItem> _activities(BuildContext context) => [
        const ActivityItem(
          title: 'Activity 1',
          subtitle: 'Widgets & Layout basics',
          icon: Icons.widgets_outlined,
          routeName: '/activity-one',
          color: Colors.indigo,
        ),
        const ActivityItem(
          title: 'Activity 2',
          subtitle: 'Forms & user input',
          icon: Icons.edit_note_outlined,
          routeName: '/activity-two',
          color: Colors.teal,
        ),
        const ActivityItem(
          title: 'Network Monitor',
          subtitle: 'Wi-Fi / Cellular handover',
          icon: Icons.wifi_tethering,
          routeName: '/network-monitor',
          color: Colors.blueAccent,
        ),
        const ActivityItem(
          title: 'Settings',
          subtitle: 'Theme & profile',
          icon: Icons.settings_outlined,
          routeName: '/settings',
          color: Colors.deepOrange,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // context.watch<AppStateProvider>() subscribes this widget to the
    // provider: whenever notifyListeners() fires (e.g. theme toggled
    // or profile name changed on the Settings screen), THIS build()
    // method re-runs automatically and the UI updates instantly --
    // this is the "global state management" requirement in action.
    final appState = context.watch<AppStateProvider>();
    final activities = _activities(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(appState.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => context.read<AppStateProvider>().toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, ${appState.profileName}!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Activities completed: ${appState.activitiesCompleted}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              const Text('Choose an activity to open:'),
              const SizedBox(height: 12),
              // RESPONSIVE LAYOUT: LayoutBuilder inspects the available
              // width and picks the number of grid columns accordingly,
              // so this same screen adapts from a narrow phone up to a
              // tablet/desktop window without ever overflowing.
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width >= 900
                        ? 4
                        : width >= 600
                            ? 3
                            : 2;
                    return GridView.builder(
                      itemCount: activities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final item = activities[index];
                        return ActivityCard(
                          item: item,
                          onTap: () => Navigator.of(context).pushNamed(item.routeName),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
