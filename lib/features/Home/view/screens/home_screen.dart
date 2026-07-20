import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/Home/view/widgets/image_item_widget.dart';
import 'package:news_app/features/Home/view_model/home_cubit.dart';
import 'package:news_app/features/Home/view_model/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..intent(FetchNewsIntent(id: '1')),

      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 12, 24),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 8, 46, 94),
          title: Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state) {
              case HomeInitial():
                return SizedBox.shrink();

              case HomeLoading():
                return Center(child: CircularProgressIndicator());

              case HomeSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ImageItemWidget(
                      image: state.articles[index].urlToImage ?? dummyImage,
                      title: state.articles[index].title ?? '',
                      onTap: () {},
                    );
                  },
                  itemCount: state.articles.length,
                );

              case HomeError():
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
