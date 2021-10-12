import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:korek/providers/users_provider.dart';
import 'package:korek/subjects.dart';
import 'package:korek/widgets/subject_item.dart';
import 'package:korek/widgets/teahcer_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Future<void> fetchUsers() async => await Provider.of<UsersProvider>(context,listen: false).fetchUsers();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      material: ((_, __) => MaterialScaffoldData(
          drawer: const Drawer(
            child: Text("IMO ESSA"),
          ),
          widgetKey: _scaffoldKey)),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async => await fetchUsers(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () =>
                                _scaffoldKey.currentState!.openDrawer(),
                            icon: const Icon(
                              Icons.menu_rounded,
                              size: 40,
                            ),
                            iconSize: 40,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Image.network(
                                "https://cdn.iconscout.com/icon/free/png-256/avatar-373-456325.png"),
                          )
                        ],
                      ),
                      const SizedBox(height:24,),
                      Text(
                        "Korek.",
                        style: platformThemeData(
                          context,
                          material: (data) => data.textTheme.headline2,
                          cupertino: (data) => data.textTheme.actionTextStyle,
                        ),
                      ),
                      Text(
                        "Study new things with the best teachers",
                        style: platformThemeData(
                          context,
                          material: (data) => data.textTheme.headline6,
                          cupertino: (data) =>
                              data.textTheme.navActionTextStyle,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xff888888)),
                                hintText: 'Search',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                            style: TextStyle(fontSize: 15),
                          )),
                          const SizedBox(width: 12),
                          GestureDetector(child: const Icon(Icons.filter_list))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) => SubjectItem(
                          subject: EnumToString.convertToString(subjectsList[i],
                              camelCase: true),
                          index: i),
                      itemCount: subjectsList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                AnimatedList(
                  key: _listKey,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int i, animation) =>
                      SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0),
                            ),
                          ),
                          child: const TeacherItem()),
                  initialItemCount: 10,
                  shrinkWrap: true,
                ),
                // TextButton(onPressed: () async {
                //   var url = Uri.parse('http://192.168.1.129:8080/users');
                //   var response = await http.get(url);
                //   print('Response status: ${response.statusCode}');
                //   print('Response body: ${response.body}');
                // }, child: Text("ESSA"),
                //
                // )
                ElevatedButton(
                    onPressed: () {
                      _listKey.currentState!
                          .removeItem(3, (context, index) => TeacherItem());
                    },
                    child: Text("ESSA"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
