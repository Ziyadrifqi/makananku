import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailVideo extends StatefulWidget {
  final String videoUrl;

  DetailVideo({required this.videoUrl});

  @override
  State<DetailVideo> createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  late VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _playerController.play());
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 70, 52),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Colors.white, // Warna putih untuk ikon
            ),
            SizedBox(width: 10),
            Text(
              'Resep Video',
              style: TextStyle(
                color: Colors.white, // Warna putih untuk teks
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            buildVideoPlayer(),
            buildPlayButton(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _playerController.value.isPlaying
                ? _playerController.pause()
                : _playerController.play();
          });
        },
        child: Icon(
          _playerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  Widget buildVideoPlayer() {
    return _playerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _playerController.value.aspectRatio,
            child: VideoPlayer(_playerController),
          )
        : CircularProgressIndicator(); // Show a loading indicator while the video is initializing
  }

  Widget buildPlayButton() {
    return _playerController.value.isPlaying
        ? Container() // Empty container when video is playing
        : Center(
            child: Container(
              color: Colors.black26,
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 80,
              ),
            ),
          ); // Show play button overlay when video is paused
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(
      _playerController,
      allowScrubbing: true,
      padding: EdgeInsets.all(8.0),
    );
  }
}
