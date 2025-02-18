import 'dart:typed_data';

import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/widgets/CustomIconButton.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (currentPage == lastPage) return;
    fetchAllImage();
  }

  fetchAllImage() async {
    lastPage = currentPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );
    List<AssetEntity> photos =
        await albums[0].getAssetListPaged(
            page: currentPage,
            size: 24
        );

    List<Widget> temp = [];
    for (var asset in photos) {
      temp.add(FutureBuilder(
        future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () => Navigator.pop(context, snapshot.data),
                borderRadius: BorderRadius.circular(5),
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF8696A0).withValues(alpha: 128),
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(snapshot.data as Uint8List),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ));
    }
    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: CustomIconButton(
            icon: Icons.arrow_back, onPressed: () => Navigator.pop(context)),
        title: Text(
          "ChatUp",
          style: TextStyle(
            color: context.theme?.authAppBarTextColor,
          ),
        ),
        actions: [CustomIconButton(icon: Icons.more_vert, onPressed: () {})],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          handleScrollEvent(scroll);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.builder(
              itemCount: imageList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) {
                return imageList[index];
              }),
        ),
      ),
    );
  }
}
