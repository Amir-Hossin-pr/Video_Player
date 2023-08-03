import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:onlinevideo/pages/widgets/button.dart';
import 'package:onlinevideo/pages/widgets/input.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //? Controllers
  final _url = TextEditingController();
  late VideoPlayerController _videController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //? Variables
  bool showVideo = false;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Vide Player'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              InputOutline(
                controller: _url,
                hint: 'Video Url',
                lable: 'Url',
                maxLines: 1,
                isRequired: true,
                errorText: 'Please input url',
              ),
              const SizedBox(height: 10),
              Button(
                onPressed: _playPause,
                borderRadius: 15,
                lable: 'Play',
                color: Colors.lightBlue,
                icon: const Icon(Icons.play_arrow),
              ),
              const SizedBox(height: 10),
              (downloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()),
              (showVideo
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: VideoPlayer(
                          _videController,
                        ),
                      ),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  void _playPause() async {
    if (formKey.currentState!.validate()) {
      downloading = true;
      setState(() {});

      // final tempDir = await getTemporaryDirectory();
      // final file = await File('${tempDir.path}/temp.mp4').create();

      // final dio = Dio();
      // await dio.download(_url.text, file.path);

      _videController = VideoPlayerController.networkUrl(
        Uri.parse(_url.text),
      );

      await _videController.initialize();
      _videController.addListener(_checkVideo);

      downloading = false;
      if (_videController.value.isPlaying) {
        await _videController.pause();
        showVideo = false;
      } else {
        _videController.play();
        showVideo = true;
      }
      setState(() {});
    }
  }

  void _checkVideo() async {
    if (_videController.value.position == _videController.value.duration) {
      await _videController.pause();
      showVideo = false;
      setState(() {});
    }
  }
}
