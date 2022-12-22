import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final bool isOnSearch;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;
  final Function(String) onCountChangedt;

  Navbar(
      {@required this.onCountChangedt,
      this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = MaterialColors.myprimary,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState(onCountChanged: (String val) {
        onCountChangedt(val);
      });

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  final Function(String) onCountChanged;
  _NavbarState({@required this.onCountChanged});

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.length == 0 ? false : true);

    return Container(
        height: widget.searchBar
            ? (!categories
                ? (tagsExist ? 211.0 : 153.0)
                : (tagsExist ? 262.0 : 153.0))
            : (!categories
                ? (tagsExist ? 132.0 : 102.0)
                : (tagsExist ? 200.0 : 150.0)),
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == Colors.white
                                        ? Colors.black
                                        : Colors.white)
                                    : Colors.white,
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(widget.title,
                              style: TextStyle(
                                  color: !widget.transparent
                                      ? (widget.bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white)
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0)),
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.searchBar)
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 4, left: 15, right: 15),
                      child: TextFormField(
                          autofocus: false,
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 12.0),
                                child: GestureDetector(
                                  child: Icon(Icons.search,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  onTap: () {
                                    onCountChanged(passwordController.text);
                                  },
                                )),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Que buscas? (Ej: Carton, vidrio...)",
                            labelStyle:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ))),
                SizedBox(
                  height: tagsExist ? 0 : 10,
                ),
              ],
            ),
          ),
        ));
  }
}
