import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Заглушка карточки завершенного заказа
class CompletedOrderLoader extends StatelessWidget {
  const CompletedOrderLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SkeletonWidget(
                width: 120,
                height: 12,
                radius: 16,
                isLoading: true,
              ),
              SkeletonWidget(
                width: 120,
                height: 12,
                radius: 16,
                isLoading: true,
              ),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: List.generate(
              9,
              (index) {
                if (index.isEven || index == 0) {
                  return const Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SkeletonWidget(
                        height: double.infinity,
                        width: double.infinity,
                        radius: 8,
                        isLoading: true,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(width: 8);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
