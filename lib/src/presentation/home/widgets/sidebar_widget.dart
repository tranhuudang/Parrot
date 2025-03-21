import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:parrot/src/app/app.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../presentation.dart';

class SidebarWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const SidebarWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int selectedItemIndex = -1;
  final scrollController = ScrollController();

  void onItemTap(int index) {
    setState(() {
      selectedItemIndex = index; // Update the selected item index
      widget.onDestinationSelected(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedItemIndex = widget.selectedIndex;
    return Container(
      width: 180,
      color: context.theme.scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            children: [
              5.height,
              _buildSidebarItem(
                  icon: FluentIcons.home_12_regular,
                  label: 'Dashboard'.i18n,
                  selectedIcon: FluentIcons.home_12_filled,
                  index: 0),
              const Divider(
                thickness: .3,
              ),
              _buildSidebarItem(
                  icon: FluentIcons.drawer_arrow_download_20_regular,
                  label: 'Flutter SDKs',
                  selectedIcon: FluentIcons.drawer_arrow_download_24_filled,
                  index: 5),
              const Divider(
                thickness: .3,
              ),
              // _buildSidebarItem(
              //     icon: FluentIcons.bug_16_regular,
              //     label: 'Troubleshooting'.i18n,
              //     selectedIcon: FluentIcons.bug_16_filled,
              //     index: 6),
              const Spacer(),
              if (isProVersion) ...[
                const Divider(
                  thickness: .3,
                  height: 0,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  color: context.theme.scaffoldBackgroundColor,
                  child: _buildSidebarItem(
                    icon: FluentIcons.notebook_16_regular,
                    selectedIcon: FluentIcons.notebook_16_filled,
                    label: 'Dev Notes'.i18n,
                    index: 1,
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
      {required IconData icon,
      IconData? selectedIcon,
      required String label,
      required int index}) {
    return InkWell(
      onTap: () => onItemTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
              // Highlight the selected item
              color: selectedItemIndex == index
                  ? context.theme.colorScheme.secondaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                  selectedItemIndex == index && selectedIcon != null
                      ? selectedIcon
                      : icon,
                  color: selectedItemIndex == index
                      ? context.theme.colorScheme.onSecondaryContainer
                      : context.theme.colorScheme.onSurface,
                  size: 20),
              14.width,
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.theme.textTheme.titleSmall?.copyWith(
                      color: selectedItemIndex == index
                          ? context.theme.colorScheme.onSecondaryContainer
                          : context.theme.colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
