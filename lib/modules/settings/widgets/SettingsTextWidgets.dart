import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/modules/settings/widgets/CustomSliders.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsDropdownTile extends StatefulWidget {
  SettingsDropdownTile(
      {this.lis, this.defaultValue, this.onChange, this.leading, this.text,this.SPkey});
  var text;
  var leading;
  var lis;
  var defaultValue;
  var SPkey;
  var onChange;
  @override
  _SettingsDropdownTileState createState() => _SettingsDropdownTileState();
}

class _SettingsDropdownTileState extends State<SettingsDropdownTile> {

  var value;
  @override
  void initState() {
    // TODO: implement initState
    value =widget.defaultValue;
    getValue();
    super.initState();
  }

  getValue() async {
    if(widget.SPkey==null) {
      return;
    }
    var res = await SettingsHandler.getSettingValue(widget.SPkey);
    setState(() {
      value = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    DropdownMenuItem CustomDropDownItem(text, value) {
      return DropdownMenuItem(
        child: Text(
          text,
        ),
        value: value,
      );
    }

    dynamic getKeyFromValue(var val){
      for (var e in widget.lis.entries){
        if(e.value==val) {
          return e.key;
        }
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        widget.leading??Container(),
        Text(widget.text),
        Spacer(),
        DropdownButton(
          value: widget.lis[value],
          items: <DropdownMenuItem<dynamic>>[
            for (MapEntry e in widget.lis.entries)
              CustomDropDownItem(e.key, e.value)
          ],
          onChanged: (value) {
            if(widget.SPkey!=null) {
              SettingsHandler.setSettingValue(widget.SPkey, getKeyFromValue(value));
            }
            this.value = getKeyFromValue(value);
            if(widget.onChange!=null) {
              widget.onChange(value);
            }
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SettingsSwitchTile extends StatefulWidget {
  SettingsSwitchTile({this.text, this.defaultValue, this.onChange, this.leading,this.SPkey});
  var leading;
  var text;
  var defaultValue;
  var SPkey;
  var onChange;
  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {

  var value;

  @override
  void initState() {
    // TODO: implement initState
    value = widget.defaultValue;
    getValues();
    super.initState();
  }

  getValues() async{
    if(widget.SPkey==null) {
      return;
    }
    var res = await SettingsHandler.getSettingValue(widget.SPkey);
    setState(() {
      value = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        widget.leading??Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(widget.text),
        ),
        Spacer(),
        Switch(
          value: value,
          onChanged: (value) {
            if(widget.SPkey!=null) {
              SettingsHandler.setSettingValue(widget.SPkey, value);
            }
            if(widget.onChange!=null) {
              widget.onChange(value);
            }
            setState(() {
              this.value = value;
            });
          },
    )
    ],
    );
    }

}

// ignore: must_be_immutable
class SettingsSectionHeading extends StatefulWidget {
  SettingsSectionHeading({this.text});
  var text;
  @override
  _SettingsSectionHeadingState createState() => _SettingsSectionHeadingState();
}

class _SettingsSectionHeadingState extends State<SettingsSectionHeading> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromARGB(255, 102, 253, 218)
              : Color.fromARGB(255, 35, 150, 239)),
    );
  }
}

// ignore: must_be_immutable
class SettingsText extends StatelessWidget {
  SettingsText({this.text});
  var text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingsTextButton extends StatelessWidget {
  SettingsTextButton({this.text, this.onTap, this.subtitle});
  var subtitle;
  var text;
  var onTap;
  @override
  Widget build(BuildContext context) {
    print(subtitle);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        onTap: () {
          if(onTap!=null) {
            onTap();
          }
        },
        child: ListTile(
          title: Text(text),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}

class SettingsSliderRow extends StatefulWidget {
  final title;
  final trailing;
  final defaultValue;
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final divisions;
  final isRectangular;
  final getTexValue;
  final valueChangeCallback;
  final SPkey;
  SettingsSliderRow({this.trailing,
    this.title,
    this.defaultValue = 0.0,
    this.sliderHeight = 48,
    this.max = 10,
    this.min = 0,
    this.divisions,
    this.isRectangular = false,
    this.getTexValue,
    this.valueChangeCallback,
    this.fullWidth = true,
    this.SPkey});

  @override
  _SettingsSliderRowState createState() => _SettingsSliderRowState();
}

class _SettingsSliderRowState extends State<SettingsSliderRow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: widget.trailing,
              title: Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 8),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomSliders(
                sliderHeight: widget.sliderHeight,
                fullWidth: widget.fullWidth,
                divisions: widget.divisions,
                isRectangular: widget.isRectangular,
                max: widget.max,
                min: widget.min,
                defaultValue: widget.defaultValue,
                valueChangeCallback: widget.valueChangeCallback,
                getTexValue: widget.getTexValue,
                SPkey: widget.key
              ),
            ),
          ],
        ),
      ),
    );
  }
}
