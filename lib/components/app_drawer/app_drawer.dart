import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/components/app_drawer/drawer_nav_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    final List<DrawerNavItem> _drawerItems = [
      DrawerNavItem(
        icon: MdiIcons.calendarClock,
        title: 'Agendamentos',
        routeName: AppRoutes.HOME,
        isSelected: currentRoute == AppRoutes.HOME,
      ),
      DrawerNavItem(
        icon: MdiIcons.calendarPlus,
        title: 'Novo Agendamento',
        routeName: AppRoutes.SCHEDULING_FORM,
        isSelected: currentRoute == AppRoutes.SCHEDULING_FORM,
      ),
    ];

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'MUNDO PET',
              style: TextStyle(
                color: AppColors.contentPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(''),
            currentAccountPicture: SvgPicture.asset(
              'assets/icons/pet_world_icon.svg',
            ),
            decoration: const BoxDecoration(
              color: AppColors.backgroundSecondary,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _drawerItems.length,
            itemBuilder: (ctx, i) {
              return _buildDrawerItem(
                ctx,
                icon: _drawerItems[i].icon,
                title: _drawerItems[i].title,
                routeName: _drawerItems[i].routeName,
                isSelected: _drawerItems[i].isSelected,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String routeName,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon,
          color: isSelected
              ? AppColors.contentPrimary
              : AppColors.contentSecondary),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? AppColors.contentPrimary
              : AppColors.contentSecondary,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.backgroundBrand,
      onTap: () {
        Navigator.pop(context); // Fecha o Drawer
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
    );
  }
}
