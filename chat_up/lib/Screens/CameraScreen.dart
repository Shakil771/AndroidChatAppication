import 'package:camera/camera.dart';
import 'package:chat_up/Screens/PictureViewScreen.dart';
import 'package:chat_up/Screens/VideoViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {

  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  Future<void>? cameraValue;
  bool isFlashOn = false;
  bool isRearCamera = true;
  bool isPhotoMode = true;
  bool isRecording= false;


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
    } catch (e) {
      Container();
    }
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

  void capturePhoto(BuildContext context) async {
    try {
      final XFile file = await _cameraController.takePicture();
      final path = join(
          (await getTemporaryDirectory()).path, "${DateTime.now()}.png");
      file.saveTo(path);
      Navigator.push(context, MaterialPageRoute(builder: (builder)=>PictureView(path: path)));
    } catch (e) {
      print("Error capturing photo: $e");
    }
  }

  void captureVideo(BuildContext context) async {
    try {
      if (isRecording) {
        setState(() => isRecording = false);
        final XFile file = await _cameraController.stopVideoRecording();
        final path = join(
            (await getTemporaryDirectory()).path, "${DateTime.now()}.mp4");
        await file.saveTo(path);  // Ensure file is saved
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => VideoView(path: path)),
          );
        }
      } else {
        await _cameraController.startVideoRecording();
        setState(() => isRecording = true);
      }
    } catch (e) {
      print("Error capturing video: $e");
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
              SizedBox(
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

                      onPressed: ()=> isPhotoMode? capturePhoto(context) : captureVideo(context),
                      icon: Icon(
                        isPhotoMode ? Icons.panorama_fish_eye : (isRecording ? Icons.stop_circle_outlined : Icons.play_circle_outlined),
                        color: Colors.white,
                        size: 70,
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
