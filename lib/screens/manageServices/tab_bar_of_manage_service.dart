import 'package:cutfx_salon/bloc/manageservices/manage_service_bloc.dart';
import 'package:cutfx_salon/model/cat/categories.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarOfManageServiceWidget extends StatefulWidget {
  final Function(int)? onTabChange;

  const TabBarOfManageServiceWidget({
    Key? key,
    this.onTabChange,
  }) : super(key: key);

  @override
  State<TabBarOfManageServiceWidget> createState() =>
      _TabBarOfManageServiceWidgetState();
}

class _TabBarOfManageServiceWidgetState
    extends State<TabBarOfManageServiceWidget> {
  int selectedIndex = 0;
  List<CategoryData?>? categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageServiceBloc, ManageServiceState>(
      builder: (context, state) {
        ManageServiceBloc manageServiceBloc = context.read<ManageServiceBloc>();
        categories = [];
        categories?.add(CategoryData());
        categories?.addAll(manageServiceBloc.categories?.data ?? []);
        return Container(
          height: 55,
          color: ColorRes.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(
              categories?.length ?? 0,
              (index) {
                return CustomCircularInkWell(
                  onTap: () {
                    selectedIndex = index;
                    widget.onTabChange?.call(selectedIndex);
                    manageServiceBloc
                        .onTapCategory(categories?[index]?.id ?? -1);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? ColorRes.themeColor10
                          : ColorRes.smokeWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        color: index == selectedIndex
                            ? ColorRes.themeColor
                            : ColorRes.transparent,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    margin: EdgeInsets.only(
                      right: categories != null &&
                              index == (categories!.length - 1)
                          ? 15
                          : 10,
                      left: index == 0 ? 15 : 0,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Center(
                      child: Text(
                        categories?[index]?.title ?? 'All',
                        style: kSemiBoldTextStyle.copyWith(
                          fontSize: 14,
                          color: index == selectedIndex
                              ? ColorRes.themeColor
                              : ColorRes.empress,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
