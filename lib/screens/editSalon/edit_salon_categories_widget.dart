import 'package:cutfx_salon/bloc/editsalon/edit_salon_detail_screen_bloc.dart';
import 'package:cutfx_salon/model/cat/categories.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSalonCategoriesWidget extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;

  const EditSalonCategoriesWidget({
    Key? key,
    this.horizontalPadding,
    this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditSalonDetailBloc editSalonDetailBloc =
        context.read<EditSalonDetailBloc>();
    editSalonDetailBloc.fetchCategories();
    return BlocBuilder<EditSalonDetailBloc, EditSalonDetailState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: horizontalPadding ?? 15,
              ),
              child: Text(
                AppLocalizations.of(context)!.categoriesYouServe,
                style: kLightTextStyle,
              ),
            ),
            CategoriesGridWidget(
              horizontalPadding: horizontalPadding,
              verticalPadding: verticalPadding,
              editSalonDetailBloc: editSalonDetailBloc,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: horizontalPadding ?? 15,
              ),
              child: Text(
                AppLocalizations.of(context)!.gendersYouServe,
                style: kLightTextStyle,
              ),
            ),
            GenderSelectWidget(
              horizontalPadding: horizontalPadding,
              verticalPadding: verticalPadding,
              editSalonDetailBloc: editSalonDetailBloc,
            ),
          ],
        );
      },
    );
  }
}

class GenderSelectWidget extends StatefulWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final EditSalonDetailBloc? editSalonDetailBloc;

  const GenderSelectWidget({
    Key? key,
    this.horizontalPadding,
    this.verticalPadding,
    this.editSalonDetailBloc,
  }) : super(key: key);

  @override
  State<GenderSelectWidget> createState() => _GenderSelectWidgetState();
}

class _GenderSelectWidgetState extends State<GenderSelectWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSalonDetailBloc, EditSalonDetailState>(
      builder: (context, state) {
        if (selectedIndex == -1) {
          selectedIndex =
              widget.editSalonDetailBloc?.salon?.data?.genderServed?.toInt() ??
                  -1;
        }
        return Container(
          height: 50,
          padding:
              EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 15),
          child: Row(
            children: [
              Expanded(
                child: ItemGenderWidget(
                  title: AppLocalizations.of(context)!.male,
                  filterIsSelected: selectedIndex == 0,
                  onTap: () {
                    selectedIndex = 0;
                    widget.editSalonDetailBloc?.selectedIndex = selectedIndex;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ItemGenderWidget(
                  title: AppLocalizations.of(context)!.female,
                  filterIsSelected: selectedIndex == 1,
                  onTap: () {
                    selectedIndex = 1;
                    widget.editSalonDetailBloc?.selectedIndex = selectedIndex;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ItemGenderWidget(
                  title: AppLocalizations.of(context)!.unisex,
                  filterIsSelected: selectedIndex == 2,
                  onTap: () {
                    selectedIndex = 2;
                    widget.editSalonDetailBloc?.selectedIndex = selectedIndex;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CategoriesGridWidget extends StatefulWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final EditSalonDetailBloc editSalonDetailBloc;

  const CategoriesGridWidget({
    Key? key,
    this.horizontalPadding,
    this.verticalPadding,
    required this.editSalonDetailBloc,
  }) : super(key: key);

  @override
  State<CategoriesGridWidget> createState() => _CategoriesGridWidgetState();
}

class _CategoriesGridWidgetState extends State<CategoriesGridWidget> {
  List<String> selectedIndex = [];

  @override
  void initState() {
    selectedIndex = widget.editSalonDetailBloc.categoryIds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.editSalonDetailBloc.categories?.length ?? 0,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 15),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / .4,
      ),
      itemBuilder: (context, index) {
        CategoryData? categoryData =
            widget.editSalonDetailBloc.categories?[index];
        return ItemCategoryWidget(
          categoryData: categoryData,
          filterIsSelected:
              selectedIndex.contains(categoryData?.id?.toString()),
          onTap: () {
            if (selectedIndex.contains(categoryData?.id?.toString())) {
              selectedIndex.remove(categoryData?.id?.toString());
            } else {
              if (categoryData != null && categoryData.id != null) {
                selectedIndex.add(categoryData.id.toString());
              }
            }
            widget.editSalonDetailBloc.categoryIds = selectedIndex;
            setState(() {});
          },
        );
      },
    );
  }
}

class ItemCategoryWidget extends StatelessWidget {
  final CategoryData? categoryData;
  final bool filterIsSelected;
  final Function()? onTap;

  const ItemCategoryWidget({
    Key? key,
    required this.categoryData,
    required this.filterIsSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filterIsSelected ? ColorRes.lavender : ColorRes.smokeWhite,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color:
                filterIsSelected ? ColorRes.themeColor : ColorRes.transparent,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Text(
              categoryData?.title ?? '',
              overflow: TextOverflow.ellipsis,
              style: kSemiBoldTextStyle.copyWith(
                fontSize: 16,
                color:
                    filterIsSelected ? ColorRes.themeColor : ColorRes.empress,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemGenderWidget extends StatelessWidget {
  final String title;
  final bool filterIsSelected;
  final Function()? onTap;

  const ItemGenderWidget({
    Key? key,
    required this.title,
    required this.filterIsSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filterIsSelected ? ColorRes.lavender : ColorRes.smokeWhite,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color:
                filterIsSelected ? ColorRes.themeColor : ColorRes.transparent,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: Center(
          child: Text(
            title,
            style: kSemiBoldTextStyle.copyWith(
              fontSize: 16,
              color: filterIsSelected ? ColorRes.themeColor : ColorRes.empress,
            ),
          ),
        ),
      ),
    );
  }
}
