import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/di/select_delivery_date_screen_component.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/select_delivery_date_screen_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/delivery_date_list.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/time_interval_list.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Экран выбора времени доставки
class SelectDeliveryDateScreen
    extends MwwmWidget<SelectDeliveryDateScreenComponent> {
  SelectDeliveryDateScreen({Key key})
      : super(
          key: key,
          widgetStateBuilder: () => _SelectDeliveryDateScreenState(),
          widgetModelBuilder: createSelectDeliveryDateScreenWidgetModel,
          dependenciesBuilder: (context) =>
              SelectDeliveryDateScreenComponent(context),
        );
}

class _SelectDeliveryDateScreenState
    extends WidgetState<SelectDeliveryDateScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<SelectDeliveryDateScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: DefaultAppBar(
        onLeadingTap: wm.back,
        leadingIcon: Icons.arrow_back_ios,
        title: createOrderTitle,
      ),
      body: SafeArea(
        child: EntityStateBuilder<List<DeliveryDate>>(
          streamedState: wm.dateState,
          loadingChild: _LoadingState(),
          errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
          child: (_, listOfDate) {
            return StreamedStateBuilder<DeliveryDate>(
              streamedState: wm.selectedDeliveryDateState,
              builder: (_, selectedDate) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        createOrderDateTitle,
                        style: textMedium24,
                      ),
                      const SizedBox(height: 20),
                      DeliveryDateList(
                        listOfDates: listOfDate,
                        currentDate: selectedDate,
                        onDateTap: wm.selectDateAction,
                      ),
                      if (selectedDate != null &&
                          selectedDate.time != null &&
                          selectedDate.time.isNotEmpty) ...[
                        const SizedBox(height: 48),
                        Text(
                          createOrderTimeIntervalTitle,
                          style: textMedium24,
                        ),
                        const SizedBox(height: 24),
                        StreamedStateBuilder<DeliveryTimeInterval>(
                          streamedState: wm.selectedIntervalState,
                          builder: (_, selectedInterval) {
                            return IntervalsList(
                              date: selectedDate,
                              currentInterval: selectedInterval,
                              onIntervalTap: wm.selectIntervalAction,
                            );
                          },
                        ),
                      ],
                      const Spacer(),
                      AcceptButton(
                        text: createOrderBtnNextTitle,
                        padding: EdgeInsets.zero,
                        callback: wm.acceptDateAction,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            createOrderDateTitle,
            style: textMedium24,
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: SkeletonWidget(
                  isLoading: true,
                  height: 40,
                  radius: 8,
                  width: double.infinity,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: SkeletonWidget(
                  isLoading: true,
                  height: 40,
                  radius: 8,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          const Spacer(),
          const AcceptButton(
            isLoad: true,
            padding: EdgeInsets.zero,
            text: createOrderBtnNextTitle,
          ),
        ],
      ),
    );
  }
}
