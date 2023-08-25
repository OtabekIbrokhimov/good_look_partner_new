import 'package:cutfx_salon/bloc/faq/faqs_bloc.dart';
import 'package:cutfx_salon/model/faq/faqs.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqsBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.helpAndFAQ,
            ),
            TabBarOfHelpFaqWidget(
              onTabChange: (selectedIndex) {
                // context.read<FaqsBloc>().add(event)
              },
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: BlocBuilder<FaqsBloc, FaqsState>(
                  builder: (context, state) {
                    if (state is FaqsCatSelectedState) {
                      return state.faqs.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.faqs.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              itemBuilder: (context, index) {
                                FaqData faqData = state.faqs[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  color: ColorRes.smokeWhite,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        faqData.question ?? '',
                                        style: kSemiBoldTextStyle.copyWith(
                                          fontSize: 16,
                                          color: ColorRes.themeColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        faqData.answer ?? '',
                                        style: kLightWhiteTextStyle.copyWith(
                                          color: ColorRes.empress,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const DataNotFound();
                    }
                    return const LoadingData(
                      color: ColorRes.white,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarOfHelpFaqWidget extends StatefulWidget {
  final Function(int)? onTabChange;

  const TabBarOfHelpFaqWidget({
    Key? key,
    this.onTabChange,
  }) : super(key: key);

  @override
  State<TabBarOfHelpFaqWidget> createState() => _TabBarOfHelpFaqWidgetState();
}

class _TabBarOfHelpFaqWidgetState extends State<TabBarOfHelpFaqWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: ColorRes.white,
      child: BlocBuilder<FaqsBloc, FaqsState>(
        builder: (context, state) {
          Faqs? faqs = context.read<FaqsBloc>().faqCat;
          return ListView(
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(
              faqs?.data?.length ?? 0,
              (index) {
                Data? data = faqs?.data?[index];
                return CustomCircularInkWell(
                  onTap: () {
                    selectedIndex = index;
                    context
                        .read<FaqsBloc>()
                        .add(SelectFaqCategoryEvent(data?.id?.toInt() ?? 0));
                    widget.onTabChange?.call(selectedIndex);
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
                      right: index == (faqs?.data?.length ?? 1 - 1) ? 15 : 10,
                      left: index == 0 ? 15 : 0,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Center(
                      child: Text(
                        data?.title ?? '',
                        style: kSemiBoldTextStyle.copyWith(
                          fontSize: 16,
                          color: ColorRes.themeColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
