import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:path_provider/path_provider.dart";
// import "package:mime/mime.dart";

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

typedef OnPickImageCallback = void Function(
  double? maxWidt,
  double? maxHeight,
  int? quality,
);

class _TestPageState extends State<TestPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  List<XFile>? _mediaFileList;
  dynamic _pickImageError;
  String? _retrieveDataError;

  void _setImageFileLisetFormFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMedia = false,
  }) async {
    if (context.mounted) {
      if (isMedia) {
        await _displayPickImageDialog(
          context,
          false,
          (
            double? maxWidth,
            double? maxHeight,
            int? quality,
          ) async {
            try {
              final List<XFile> pickedFileList = <XFile>[];
              final XFile? media = await _picker.pickMedia(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                imageQuality: quality,
              );
              if (media != null) {
                pickedFileList.add(media);
                setState(() {
                  _mediaFileList = pickedFileList;
                });
              }
            } catch (e) {
              setState(() {
                _pickImageError = e;
              });
            }
          },
        );
      } else {
        // saveImage(source);
        await _displayPickImageDialog(
          context,
          false,
          (
            double? maxWidth,
            double? maxHeight,
            int? quality,
          ) async {
            // saveImage(source);
            try {
              final XFile? pickedFile = await _picker.pickImage(
                source: source,
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                imageQuality: quality,
              );
              saveImage(pickedFile);
              setState(() {
                _setImageFileLisetFormFile(pickedFile);
                saveImage(pickedFile);
              });
            } catch (e) {
              setState(() {
                _pickImageError = e;
              });
            }
          },
        );
      }
    }
  }

  Future<void> _displayPickImageDialog(
    BuildContext context,
    bool isMulti,
    OnPickImageCallback onPick,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add optional parameters"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: maxWidthController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "Enter maxWidth if desired",
                ),
              ),
              TextField(
                controller: maxHeightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "Enter maxHeight if desired",
                ),
              ),
              TextField(
                controller: qualityController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "Enter quality if desired",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("PICK"),
              onPressed: () {
                final double? width = maxWidthController.text.isNotEmpty
                    ? double.parse(maxWidthController.text)
                    : null;
                final double? height = maxHeightController.text.isNotEmpty
                    ? double.parse(maxHeightController.text)
                    : null;
                final int? quality = qualityController.text.isNotEmpty
                    ? int.parse(qualityController.text)
                    : null;

                onPick(
                  width,
                  height,
                  quality,
                );
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> saveImage(XFile? pickedFile) async {
    final dir = await getApplicationDocumentsDirectory();
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await file.copy("${dir.path}/image.png");
      if (kDebugMode) {
        print("directory path : ${dir.path}/image.png");
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileLisetFormFile(response.file);
        } else {
          _mediaFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFileList != null) {
      return Semantics(
        label: "image_picker_example_picked_images",
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (context, index) {
            return Image.file(
              File(_mediaFileList![index].path),
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text("This image type is not supported"),
                );
              },
            );
          },
          itemCount: _mediaFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        "Pick image error: $_pickImageError",
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        "You have not yet picker an image.",
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image picker test"),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: retrieveLostData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Text(
                  "You have not yet picked an image",
                  textAlign: TextAlign.center,
                );
              case ConnectionState.done:
                return _previewImage();
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return Text(
                    "Pick image error : ${snapshot.error}",
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const Text(
                    "You have not yet picked an image",
                    textAlign: TextAlign.center,
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "image",
            tooltip: "Pick Image from gallery",
            onPressed: () {
              _onImageButtonPressed(ImageSource.gallery,
                  context: context, isMedia: false);
            },
            child: const Icon(Icons.photo),
          ),
          if (_picker.supportsImageSource(ImageSource.camera))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                heroTag: "photo",
                tooltip: "Take a Photo",
                onPressed: () {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
        ],
      ),
    );
  }
}