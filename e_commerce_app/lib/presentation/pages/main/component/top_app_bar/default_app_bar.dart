import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/custom/custom_theme.dart';
import '../../cubit/bottom_nav_cubit.dart';
import '../../cubit/mall_type_cubit.dart';

class DefaultAppBar extends StatelessWidget {
  final BottomNav bottomNav;

  const DefaultAppBar(this.bottomNav, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: (state.isMarket)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          child: AppBar(
            title: Text(
              bottomNav.toName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: state.isMarket
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.contentPrimary,
                  ),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leadingWidth: 86,
          ),
        );
      },
    );
  }
}
