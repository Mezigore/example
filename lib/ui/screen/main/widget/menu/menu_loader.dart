import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/card.dart';

/// Виджет меню для состояния загрузки.
class MenuLoader extends StatelessWidget {
  const MenuLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 62.0,
            child: Row(
              children: const [
                _HeadBar(
                  flex: 15,
                  height: 40,
                  isLoading: true,
                ),
                SizedBox(width: 16.0),
                _HeadBar(isLoading: true),
                SizedBox(width: 16.0),
                _HeadBar(isLoading: true),
                SizedBox(width: 16.0),
                _HeadBar(isLoading: true),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: const [
                _CardHolder(isLoading: true),
                SizedBox(height: 20.0),
                _CardHolder(isLoading: true),
                SizedBox(height: 20.0),
                _CardHolder(isLoading: true),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeadBar extends StatelessWidget {
  const _HeadBar({
    Key key,
    this.isLoading = false,
    this.flex = 10,
    this.height = 14,
  }) : super(key: key);

  final bool isLoading;
  final int flex;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SkeletonWidget(
        isLoading: isLoading,
        height: height,
      ),
    );
  }
}

class _CardHolder extends StatelessWidget {
  const _CardHolder({
    Key key,
    this.isLoading = false,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CardWidget(
        child: SizedBox(
          height: 392.0,
          child: Column(
            children: [
              SkeletonWidget(
                isLoading: isLoading,
                height: 222.0,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 21.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SkeletonWidget(
                            height: 12,
                            width: double.infinity,
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: SkeletonWidget(
                                  height: 12,
                                  isLoading: isLoading,
                                ),
                              ),
                              const SizedBox(
                                width: 57.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SkeletonWidget(
                            height: 24,
                            width: 24,
                            radius: 12,
                            isLoading: isLoading,
                          ),
                          const SizedBox(width: 8.0),
                          SkeletonWidget(
                            isLoading: isLoading,
                            width: 48,
                            height: 12,
                          ),
                          const SizedBox(width: 24.0),
                          SkeletonWidget(
                            height: 24,
                            width: 24,
                            radius: 12,
                            isLoading: isLoading,
                          ),
                          const SizedBox(width: 8.0),
                          SkeletonWidget(
                            isLoading: isLoading,
                            width: 48,
                            height: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SkeletonWidget(
                                isLoading: isLoading,
                                height: 16.0,
                                width: 64.0,
                                radius: 16.0,
                              ),
                              const SizedBox(height: 6.0),
                              SkeletonWidget(
                                isLoading: isLoading,
                                height: 12.0,
                                width: 64.0,
                                radius: 16.0,
                              ),
                            ],
                          ),
                          SkeletonWidget(
                            isLoading: isLoading,
                            height: 40.0,
                            width: 40.0,
                            radius: 12.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
