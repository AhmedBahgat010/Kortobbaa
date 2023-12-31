import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortobaa_task/Features/Categories/view/widgets/ContinerCategories.dart';
import '../../../../Core/Utils/App Colors.dart';
import '../../../Core/Utils/Widgets/LoadingWidget/LoadingWidget.dart';
import '../../../Core/Utils/Widgets/MessageWidget/MessageWidget.dart';
import 'manger/categories_cubit.dart';
import 'manger/categories_state.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final categoriesData =
              context.read<CategoriesCubit>().categoriesResponse;

          return Scaffold(
            appBar: AppBar(
              title: const Text("التصنيفات"),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  ),
                )
              ],
            ),
            body: state is CategoriesLoading
                ? const LoadingWidget(
                    color: AppColors.primaryColor,
                  )
                : state is CategoriesError
                    ? MessageWidget(message: state.message.toString())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView(children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: ContinerCategories(
                                  name: categoriesData.results![index].name
                                      .toString(),
                                  imgpath: categoriesData
                                      .results![index].imageLink
                                      .toString(),
                                ),
                              );
                            },
                            itemCount: categoriesData!.count,
                          )
                        ]),
                      ),
          );
        },
      ),
    );
  }
}
