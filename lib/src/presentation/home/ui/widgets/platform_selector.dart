import 'package:dak_solutions_common/dak_solutions_common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/app/app.dart';

import '../../../presentation.dart';
import '../../data/notifier/main_home_notifier.dart';

class PlatformSelector extends ConsumerWidget {
  const PlatformSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainHomeProvider);
    final notifier = ref.read(mainHomeProvider.notifier);
    if (state.availablePlatforms.isEmpty) return Text('No Devices Detected'.i18n);
    // Check if the selectedPlatform is null or not in the availablePlatforms list
    final selectedPlatform = state.availablePlatforms.contains(state.selectedPlatform)
        ? state.selectedPlatform
        : null;
    return RoundedDottedDropdownButton<String>(
      hint: Text('Select Platform'.i18n),
      value: selectedPlatform, // Set the currently selected value
      items: state.availablePlatforms.map((platform) {
        return DropdownMenuItem<String>(
          value: platform, // Set the value to the individual platform
          child: Text(platform),
        );
      }).toList(),
      onChanged: (selectedPlatform) {
        notifier.selectPlatform(selectedPlatform!);
      },
    );
  }
}
