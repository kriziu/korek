import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korek/helpers/subjects.dart';
import 'package:korek/models/filters.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/providers/users_provider.dart';
import 'package:korek/screens/profile_screen.dart';
import 'package:korek/widgets/home_drawer.dart';
import 'package:korek/widgets/subject_item.dart';
import 'package:korek/widgets/teahcer_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchUsers() async {
    try {
      await Provider.of<UsersProvider>(context, listen: false).fetchUsers();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
    }
  }

  final Filters _filters = Filters();
  List<User> teachers = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void sortTeachers() {
    switch (_filters.sortType.sort) {
      case Sort.rating:
        teachers.sort((a, b) => a.firstName.compareTo(b.firstName));
        break;
      case Sort.lowPrice:
        teachers.sort((a, b) => b.price.compareTo(a.price));
        break;
      case Sort.nameAZ:
        teachers.sort((a, b) => a.firstName.compareTo(b.firstName));
        break;
      case Sort.nameZA:
        teachers.sort((a, b) => b.firstName.compareTo(a.firstName));
        break;
      case Sort.highPrice:
        teachers.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
  }

  void chooseSubject(Subjects subject) {
    setState(() {
      if (_filters.subjects.contains(subject)) {
        _filters.subjects.remove(subject);
      } else {
        _filters.subjects.add(subject);
      }
    });
  }

  void filterTeachers(List<User> allTeachers) {
    if (_filters.searchStr != null) {
      teachers = allTeachers
          .where((teacher) =>
              teacher.firstName
                  .toLowerCase()
                  .contains(_filters.searchStr!.toLowerCase()) ||
              teacher.lastName
                  .toLowerCase()
                  .contains(_filters.searchStr!.toLowerCase()))
          .toList();
    }

    if (_filters.subjects.isNotEmpty) {
      List<User> helperTeachers = [];
      teachers.forEach((teacher) {
        teacher.subjects.forEach((subject) {
          if (_filters.subjects.contains(subject) &&
              !helperTeachers.contains(teacher)) {
            helperTeachers.add(teacher);
          }
        });
      });
      teachers.clear();
      teachers.addAll(helperTeachers);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTeachers = Provider.of<UsersProvider>(context).teachers;
    teachers = allTeachers;
    sortTeachers();
    filterTeachers(allTeachers);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
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
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                            icon: const Icon(
                              Icons.menu_rounded,
                              size: 40,
                            ),
                            iconSize: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(platformPageRoute(
                                  context: context,
                                  builder: (context) => ProfileScreen()));
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              child: Hero(
                                tag: "profileimg",
                                child: SvgPicture.asset(
                                  "assets/${user!.avatarId}.svg",
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
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
                          Expanded(
                              child: TextField(
                            controller: _controller,
                            onChanged: (str) {
                              setState(() {
                                if (str.isEmpty) {
                                  _filters.searchStr = null;
                                  return;
                                }
                                _filters.searchStr = str;
                              });
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      _controller.clear();
                                      _filters.searchStr = "";
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      color: Color(0xff888888)),
                                ),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xff888888)),
                                hintText: 'Search',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                            style: const TextStyle(fontSize: 15),
                          )),
                          const SizedBox(width: 12),
                          PopupMenuButton<SortType>(
                            tooltip: "Sort by",
                            onSelected: (SortType sortType) {
                              setState(() {
                                _filters.sortType = sortType;
                              });
                            },
                            itemBuilder: (context) => SortType.sortMethods
                                .map((sortType) => PopupMenuItem(
                                    child: Text(
                                      sortType.name,
                                      style: TextStyle(
                                          color: _filters.sortType.name ==
                                                  sortType.name
                                              ? Theme.of(context).primaryColor
                                              : Colors.black,
                                          fontWeight: _filters.sortType.name ==
                                                  sortType.name
                                              ? FontWeight.w600
                                              : FontWeight.w400),
                                    ),
                                    value: sortType))
                                .toList(),
                            child: const Icon(Icons.filter_list),
                          )
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
                          subject: subjectsList[i],
                          index: i,
                          chooseSubject: chooseSubject,
                          isChosen: _filters.subjects.contains(
                            subjectsList[i],
                          )),
                      itemCount: subjectsList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                teachers.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) =>
                            TeacherItem(teachers[i], i),
                        itemCount: teachers.length,
                        shrinkWrap: true,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 36),
                        child: Center(
                            child: Column(
                          children: const [
                            Text(
                              "No teachers found!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(height: 8),
                            Icon(Icons.mood_bad_rounded, size: 48)
                          ],
                        )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
