import 'dart:io';

import 'package:alpha_mobile/core/location_provider.dart';
import 'package:alpha_mobile/model/boar_report.dart';
import 'package:alpha_mobile/model/boar_type.dart';
import 'package:alpha_mobile/ui/basic_modal_sheet.dart';
import 'package:alpha_mobile/ui/map/map_view_mini.dart';
import 'package:alpha_mobile/ui/modal_sheet_header.dart';
import 'package:alpha_mobile/ui/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BoarReportScreen extends StatefulWidget {
  final BoarType chosenBoarType;
  BoarReportScreen({Key key, @required this.chosenBoarType}) : super(key: key);

  @override
  _BoarReportScreenState createState() => _BoarReportScreenState();
}

class _BoarReportScreenState extends State<BoarReportScreen> {
  final _formKey = GlobalKey<FormState>();
  BoarReport _report;
  LocationProvider _locationProvider;
  LatLng _currentLocation;
  ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationProvider();
    _picker = ImagePicker();
    _report = BoarReport();
    _report.boarType = widget.chosenBoarType;
    _getLocation();
  }

  void _getLocation() async {
    var locationData = await _locationProvider.getCurrentLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Report details'),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  
                }
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locationSection(),
                      _boarTypeSection(),
                      _pictureSection(),
                      _descriptionSection()
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      )),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Container(
      child: Text(title, style: Theme.of(context).textTheme.headline5),
    );
  }

  Widget _sectionCard(List<Widget> children, {bool horizontal = false}) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(15),
            child: horizontal
                ? Row(
                    children: children,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween)
                : Column(children: children)));
  }

  Widget _locationSection() {
    return _sectionCard([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _sectionHeader(context, 'Location'),
          RaisedButton(
            child: Text('refresh'),
            onPressed: () => _getLocation(),
          )
        ],
      ),
      Container(height: 10),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
            height: 200,
            width: double.infinity,
            child: _currentLocation != null
                ? MapViewMini(desiredLocation: _currentLocation)
                : Container()),
      ),
      Container(height: 15),
      _currentLocation != null
          ? Text(
              'Coordinates: ${_currentLocation.latitude}, ${_currentLocation.longitude}')
          : Container()
    ]);
  }

  Widget _boarTypeSection() {
    return _sectionCard([
      _sectionHeader(context, 'Boar type'),
      Container(
        width: 120,
        child: DropdownButton(
          isExpanded: true,
          value: _report.boarType,
          onChanged: (value) {
            setState(() => _report.boarType = value);
          },
          items: BoarType.values
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().replaceAll('BoarType.', ''))))
              .toList(),
        ),
      )
    ], horizontal: true);
  }

  Widget _pictureSection() {
    return _sectionCard([
      _sectionHeader(context, 'Picture'),
      Container(height: 20),
      Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[700],
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showImagePicker(context),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _report.imageFile != null
                  ? Image.file(_report.imageFile, fit: BoxFit.fitWidth)
                  : Container(
                      width: double.infinity,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[300],
                      ),
                    )),
        ),
      )
    ]);
  }

  Widget _descriptionSection() {
    return _sectionCard([
      _sectionHeader(context, 'Description'),
      TextFormField(
        maxLines: null, // default is 1, this enables multiline
        decoration: InputDecoration(
            hintText: 'Describe the encounter...'),
        onChanged: (value) async {
          _report.description = value;
        },
      )
    ]);
  }

  Widget _imagePickerModal() {
    return BasicModalSheet(
      header: ModalSheetHeader(
        icon: Icons.image,
        text: 'Choose the image source.',
      ),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SquareButton(
            icon: Icons.camera,
            title: 'Camera',
            onTap: () {
              _picFromCamera();
              Navigator.of(context).pop();
            },
          ),
          SquareButton(
            icon: Icons.image_search,
            title: 'Gallery',
            onTap: () {
              _picFromGallery();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context, builder: (context) => _imagePickerModal());
  }

  void _picFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _report.imageFile = File(pickedFile.path);
      }
    });
  }

  void _picFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _report.imageFile = File(pickedFile.path);
      }
    });
  }
}
