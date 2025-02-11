import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {

  const CameraScreen();
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  Future<void>? cameraValue;
  bool isFlashOn = false;
  bool isRearCamera = true;
  bool isPhotoMode = true;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          isRearCamera ? cameras[0] : cameras[1],
          isRearCamera ? ResolutionPreset.ultraHigh : ResolutionPreset.high,
        );
        cameraValue = _cameraController.initialize();
        if (mounted) {
          setState(() {});
        }
      } else {}
    } catch (e) {}
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    _cameraController.setFlashMode(
      isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  void switchCamera() {
    setState(() {
      isRearCamera = !isRearCamera;
      isFlashOn = false;
    });
    initializeCamera();
  }

  void capturePhoto() async {
    try {
      final XFile file = await _cameraController!.takePicture();
      final path = join(
          (await getTemporaryDirectory()).path, "${DateTime.now()}.png");
      file.saveTo(path);
      print("Photo captured");
    } catch (e) {
      print("Error capturing photo: $e");
    }
  }
  void captureVideo() async {
    if (_cameraController.value.isRecordingVideo) {
    } else {
      await _cameraController.startVideoRecording();
    }
  }

  void toggleMode() {
    setState(() {
      isPhotoMode = !isPhotoMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 70,
                child: FutureBuilder(
                  future: cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_cameraController);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        size: 30,
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: toggleFlash,
                    ),
                    IconButton(
                      onPressed: capturePhoto,
                      icon: const Icon(
                        Icons.panorama_fish_eye,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        size: 30,
                        Icons.flip_camera_ios,
                        color: Colors.white,
                      ),
                      onPressed: switchCamera,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera,
                    color: isPhotoMode ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    if (!isPhotoMode) toggleMode();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.videocam,
                    color: !isPhotoMode ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    if (isPhotoMode) toggleMode();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
