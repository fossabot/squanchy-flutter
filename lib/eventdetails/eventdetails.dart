import 'package:SquanchyFlutter/utils/flexible_app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class EventDetailsPage extends StatefulWidget {
  EventDetailsPage({Key key}) : super(key: key);

  @override
  _EventDetailsPageState createState() => new _EventDetailsPageState(kEvent);
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  _EventDetailsPageState(this.event);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Event event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var titleTextStyle = theme.textTheme.display1.copyWith(
        color: Colors.white,
        fontSize: 24.0,
        fontFamily: "League Spartan",
        fontWeight: FontWeight.w700);

    var titleWidget = new Padding(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Text(event.title, style: titleTextStyle));

    var appBarBottom = new Padding(
        padding: new EdgeInsets.fromLTRB(72.0, 8.0, 8.0, 8.0),
        child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: new List.from(
                speakersChildrenFor(theme, event.speakers))
              ..add(titleWidget),
            crossAxisAlignment: CrossAxisAlignment.start));

    var appBar = new AppBar(
        leading: new BackButton(),
        actions: [
          new IconButton(
              icon: const Icon(Icons.search), onPressed: _handleSearchPress)
        ],
        bottom: new FlexibleAppBarBottomWidget
            .fromContext(context, appBarBottom)
    );

    return new Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        );
  }

  List<Widget> speakersChildrenFor(ThemeData theme, List<Speaker> speakers) {
    var speakerTextStyle = theme.textTheme.title.copyWith(
        color: Colors.white,
        fontSize: 14.0,
        height: 1.714285714,
        fontFamily: "League Spartan",
        fontWeight: FontWeight.w700);

    var speakerNames = speakers.map((speaker) => speaker.fullName).join(", ");

    var speakerNamesWidget = new Text(speakerNames, style: speakerTextStyle);

    return <Widget>[
      new Row(
          children: speakers
              .map((speaker) =>
          new CircleAvatar(
              backgroundImage: new NetworkImage(speaker.avatarUrl),
              radius: 20.0))
              .map((widget) =>
          new Padding(
              padding: new EdgeInsets.only(right: 8.0), child: widget))
              .toList()),
      new Padding(
          padding: new EdgeInsets.only(top: 8.0), child: speakerNamesWidget),
    ];
  }

  _handleSearchPress() {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text("¯\\_(ツ)_/¯")));
  }
}
