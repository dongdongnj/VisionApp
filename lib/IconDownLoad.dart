import 'package:fluent_ui/fluent_ui.dart';

class IconDownLoad extends StatefulWidget {
  final Widget icon;
  final String info;
  // final Icon hoverIcon;
  final Function()? onClick;

  IconDownLoad(this.icon, this.info, {this.onClick});

  @override
  _IconDownLoad createState() => _IconDownLoad();

}

class _IconDownLoad extends State<IconDownLoad> {
  bool isOnHover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.info,
      child: MouseRegion(
        onEnter: (event) {
          setState((){
            isOnHover = true;
          });
        },
        onExit: (event) {
          setState((){
            isOnHover = false;
          });
        },
        child: HoverButton(
          cursor: SystemMouseCursors.click,
          builder: (context, states) {
            return !isOnHover ? widget.icon : IconButton(
                icon: Icon(FluentIcons.cloud_download,size: 40,),
                onPressed: () {
                  if( widget.onClick != null ) widget.onClick!();
                }
            );
          },
        ),
      ),
    );

  }
}