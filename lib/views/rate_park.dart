import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parks_bark/app/global_styles.dart';
import 'package:parks_bark/app/strings.dart';
import 'package:parks_bark/app/text_styles.dart';
import 'package:parks_bark/models/current_park.dart';
import 'package:parks_bark/models/park.dart';
import 'package:parks_bark/models/park_image.dart';
import 'package:parks_bark/models/park_rating.dart';
import 'package:parks_bark/services/rated_parks_service.dart';
import 'package:parks_bark/views/Home.dart';
import 'package:parks_bark/views/rating_submitted.dart';
import 'package:parks_bark/molecules/rating_group.dart';
import 'package:parks_bark/molecules/rating_heading.dart';
import 'package:parks_bark/app/color_sets.dart';
import 'package:provider/provider.dart';

class RateParkPage extends StatefulWidget {
  RateParkPage({ Key? key }) : super(key: key);

  final String exampleText = 'This is some example text';

  @override
  _RateParkPageState createState() => _RateParkPageState();
}

class _RateParkPageState extends State<RateParkPage> {
  int _cleanlinessRating = 0;
  int _noiseRating = 0;
  int _sizeRating = 0;
  int _locationRating = 0;
  int _activityEquipmentRating = 0;

  @override
  void dispose () {
    super.dispose();
  }

  @override
  void initState () {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var parkImage = context.watch<ParkImage>().currentImage;
    final parkImageFile = context.watch<ParkImage>().currentImageAsFile;
    var currentPark = context.watch<CurrentPark>().currentPark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.ratePark),
        elevation: AppStyles.appBarElevation,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Consumer<CurrentPark>(
              //   builder: (context, park, child) => RatingHeading(
              //     name: park.currentPark?.id ?? '',
              //     addressLine1: park.currentPark?.description ?? '',
              //     addressLine2: park.currentPark?.description ?? '',
              //   ),
              // ),
              RatingHeading(
                  name: currentPark?.name ?? '',
                  addressLine1: currentPark?.description ?? '',
                  addressLine2: '',
                ),
              RatingGroup(
                title: AppStrings.cleanliness,
                currentRating: _cleanlinessRating,
                onPressedHandler: _updateCleanlinessRating
              ),
              RatingGroup(
                title: AppStrings.noise,
                currentRating: _noiseRating,
                onPressedHandler: _updateNoiseRating
              ),
              RatingGroup(
                title: AppStrings.size,
                currentRating: _sizeRating,
                onPressedHandler: _updateSizeRating
              ),
              RatingGroup(
                title: AppStrings.location,
                currentRating: _locationRating,
                onPressedHandler: _updateLocationRating
              ),
              RatingGroup(
                title: AppStrings.activityEquipment,
                currentRating: _activityEquipmentRating,
                onPressedHandler: _updateActivityEquipmentRating
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: parkImage != null
                  ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: parkImageFile != null,
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  margin: EdgeInsets.only(right: 16.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(parkImageFile!),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                              ),
                              Container(
                                width: 200.0,
                                child:  Text(
                                  parkImage.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel),
                                color: Colors.red,
                                iconSize: 36.0,
                                onPressed: () {
                                  context.read<ParkImage>().unsetImage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                  : TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith((states) => BrandColors.brandAccent),
                      alignment: Alignment.center,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.upload),
                            const Text(
                              AppStrings.uploadPhoto,
                              style: AppTextStyles.buttonText,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      // if (parkImage != null) {
                      //   context.read<ParkImage>().unsetImage();
                      //   return;
                      // }
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return _UploadPhotoDialog();
                        },
                      );
                    },
                  ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.red.shade400,
                      ),
                      const Text(AppStrings.cancel),
                    ],
                  ),
                  onPressed: _cancelRating,
                ),
              ),
              Container(
                color: Colors.grey.shade300,
                width: 2,
              ),
              Expanded(
                child: TextButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green.shade700,
                      ),
                      Text(AppStrings.submit),
                    ],
                  ),
                  onPressed: () {
                    if (currentPark?.id != null && currentPark?.name != null && currentPark?.description != null) {
                      _submitRating(Park(
                        id: currentPark!.id,
                        name: currentPark.name,
                        description: currentPark.description,
                        rating: ParkRating(
                          cleanliness: _cleanlinessRating,
                          noise: _noiseRating,
                          location: _locationRating,
                          size: _sizeRating,
                          activityEquipment: _activityEquipmentRating,
                          notes: '',
                        )
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateCleanlinessRating (int value) {
    setState(() {
      _cleanlinessRating = value;
    });
  }

  void _updateNoiseRating (int value) {
    setState(() {
      _noiseRating = value;
    });
  }

  void _updateSizeRating (int value) {
    setState(() {
      _sizeRating = value;
    });
  }

  void _updateLocationRating (int value) {
    setState(() {
      _locationRating = value;
    });
  }

  void _updateActivityEquipmentRating (int value) {
    setState(() {
      _activityEquipmentRating = value;
    });
  }

  void _cancelRating () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  void _submitRating (Park park) async {
    _showLoader();
    final response = await RatedParksService().submitRating(park);
    _hideLoader();
    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RatingSubmittedPage(
            parkName: park.name,
            ratings: [
              park.rating?.cleanliness ?? 0,
              park.rating?.noise ?? 0,
              park.rating?.size ?? 0,
              park.rating?.location ?? 0,
              park.rating?.activityEquipment ?? 0,
            ],
          )
        ),
      );
    } else {
      throw Exception('Failed to create rating.');
    }
  }

  void _showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: BrandColors.brandAccent,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: const Text(
                      AppStrings.submitting,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void _hideLoader() {
    Navigator.pop(context);
  }
}

class _UploadPhotoDialog extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  _UploadPhotoDialog({ Key? key }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith<Size?>((states) => Size(150, 48)),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => BrandColors.brandPrimary),
                  foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.black87),
                ),
                child: const Text(
                  AppStrings.uploadPhoto,
                  style: AppTextStyles.buttonText,
                ),
                onPressed: () async {
                  var img = await _picker.pickImage(source: ImageSource.gallery);
                  if (img != null) {
                    context.read<ParkImage>().setImage(img);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith<Size?>((states) => Size(150, 48)),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => BrandColors.brandPrimary),
                  foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.black87),
                ),
                child: const Text(
                  AppStrings.takePhoto,
                  style: AppTextStyles.buttonText,
                ),
                onPressed: () async {
                  var img = await _picker.pickImage(source: ImageSource.camera);
                  if (img != null) {
                    context.read<ParkImage>().setImage(img);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
