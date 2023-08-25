import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  const VideoPreviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController videoPlayerController;
  String videoUrl = Get.arguments;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.network('${ConstRes.itemBaseUrl}$videoUrl')
          ..initialize().then((_) {
            videoPlayerController.play();
            setState(() {});
          });
    super.initState();
  }

  void onPlayPauseTap() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) == '00') {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController))
                  : Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    decoration: const BoxDecoration(
                      color: ColorRes.themeColor5,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorRes.white,
                      size: 18,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onPlayPauseTap,
                  splashColor: ColorRes.transparent,
                  highlightColor: ColorRes.transparent,
                  child: Container(
                    height: Get.height / 1.5,
                    alignment: Alignment.center,
                    child: ValueListenableBuilder(
                      valueListenable: videoPlayerController,
                      builder: (context, value, child) => AnimatedOpacity(
                        opacity: videoPlayerController.value.isPlaying == true
                            ? 0.0
                            : 1.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        child: Icon(
                          videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: ColorRes.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ValueListenableBuilder(
                    valueListenable: videoPlayerController,
                    builder: (context, value, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${printDuration(videoPlayerController.value.position)} / ${printDuration(videoPlayerController.value.duration)}',
                          style: kSemiBoldWhiteTextStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        VideoProgressIndicator(
                          videoPlayerController,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                              backgroundColor: ColorRes.white,
                              playedColor: ColorRes.themeColor),
                          padding: const EdgeInsets.only(bottom: 15, top: 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
