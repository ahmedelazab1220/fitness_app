import 'package:flutter/material.dart';

import '../../../../core/utils/shared_widgets/blured_container.dart';
import 'excercise_item.dart';

class Excercises extends StatelessWidget {
  final list;
  const Excercises({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: BluredContainer(
        child: ListView.builder(
          itemCount: list?.length ?? 0,
          itemBuilder: (ctx, idx) {
            final ex = list![idx];
            return ExcerciseItem(ex: ex);
          },
        ),
      ),
    );
  }
}
