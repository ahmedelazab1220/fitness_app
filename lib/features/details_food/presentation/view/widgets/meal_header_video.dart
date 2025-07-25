import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MealHeaderVideo extends StatefulWidget {
  final String videoUrl;
  final String fallbackImage;

  const MealHeaderVideo({
    super.key,
    required this.videoUrl,
    required this.fallbackImage,
  });

  @override
  State<MealHeaderVideo> createState() => _MealHeaderVideoState();
}

class _MealHeaderVideoState extends State<MealHeaderVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVideoAvailable =
        widget.videoUrl.isNotEmpty && _controller.value.isInitialized;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: isVideoAvailable
              ? _controller.value.aspectRatio
              : 16 / 9,
          child: isVideoAvailable
              ? VideoPlayer(_controller)
              : Image.network(
                  widget.fallbackImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.black12,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: SafeArea(
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
