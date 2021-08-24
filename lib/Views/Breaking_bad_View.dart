import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/Model/api_model.dart';
import 'package:demo/bloc/BB_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BBScreen extends StatefulWidget {
  @override
  _BBScreenState createState() => _BBScreenState();
}

class _BBScreenState extends State<BBScreen> {
  TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _breakingBBLoc = BreakingBadBloc();

  @override
  void initState() {
    super.initState();
    _breakingBBLoc.bBEventSink.add(Doing.FETCH);
    searchFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _breakingBBLoc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF090F13),
          automaticallyImplyLeading: false,
          title: Text('Breaking Bad', style: kTextStyle.copyWith(fontSize: 16)),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        backgroundColor: Color(0xFF262D34),
        body: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF090F13),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
                          child: TextFormField(
                              controller: searchFieldController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Search for classes...',
                                labelStyle: kTextStyle,
                                hintText: 'Search by name, location etc...',
                                hintStyle: kTextStyle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF262D34),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF262D34),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: Color(0xFF95A1AC),
                                ),
                              ),
                              style: kTextStyle),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [Text('Workout Categories', style: kTextStyle)],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 1, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF090F13),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF262D34),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.self_improvement_outlined,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text('Yoga', style: kTextStyle),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [Text('Characters', style: kTextStyle)],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder<List<BreakingBadModel>>(
                      stream: _breakingBBLoc.charactersStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            snapshot.error ?? 'error',
                            style: TextStyle(color: Colors.white),
                          ));
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFF090F13),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${snapshot.data[index].img}'),
                                      fit: BoxFit.fitWidth),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF090F13),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 0, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${snapshot.data[index].name}',
                                                        style: kTextStyle),
                                                    Text(
                                                        '${snapshot.data[index].nickname}',
                                                        style: kTextStyle)
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      print(
                                                          'Button-Reserve pressed ...');
                                                    },
                                                    icon: Icon(
                                                      Icons.add_rounded,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 0,
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const kTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
