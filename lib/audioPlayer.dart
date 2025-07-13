import 'dart:convert';

import 'package:just_audio/just_audio.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:naat_app/services.dart';

import 'AdManager.dart';

class ChewieAudioDemo extends StatefulWidget {
  var title;
  var Server;
  var count;
  var suras;

  ChewieAudioDemo(var title, var Server, var count, var suras) {
    this.title = title;
    this.Server = Server;
    this.count = count;
    this.suras = suras;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieAudioDemo> {
  String mp3Url = "";
  late TargetPlatform _platform;
  bool isplaying = false;
  bool isfirstTime = true;
  int clickItem =1;
  AudioPlayer? _player;
  String playingAudio = "Play Audio";
  @override
  void initState() {
    super.initState();

    isplaying = false;
  }
  @override
  void dispose() {
    _player!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List heading = [
      "الم",
      "سَيَقُولُ",
      "تِلْكَ الرُّسُلُ",
      "لَنْ تَنَالُوا",
      "وَالْمُحْصَنَاتُ",
      "لَا يُحِبُّ اللَّهُ",
      "وَإِذَا سَمِعُوا",
      "وَلَوْ أَنَّنَا",
      "قَالَ الْمَلَأُ",
      "وَاعْلَمُوا",
      "يَعْتَذِرُونَ",
      "وَمَا مِنْ دَابَّةٍ",
      "وَمَا أُبَرِّئُ",
      "رُبَمَا",
      "سُبْحَانَ الَّذِي",
      "قَالَ أَلَمْ",
      "اقْتَرَبَ",
      "قَدْ أَفْلَحَ",
      "وَقَالَ الَّذِينَ",
      "أَمَّنْ خَلَقَ",
      "اتْلُ مَا أُوحِيَ",
      "وَمَنْ يَقْنُتْ",
      "وَمَا لِيَ",
      "فَمَنْ أَظْلَمُ",
      "إِلَيْهِ يُرَدُّ",
      "حم",
      "قَالَ فَمَا خَطْبُكُمْ",
      "قَدْ سَمِعَ اللَّهُ",
      "تَبَارَكَ الَّذِي",
      "عَمَّ يَتَسَاءَلُونَ "
    ];
    List allSurahNames = [
      "الفاتحة",
      "البقرة",
      "آل عمران",
      "النساء",
      "المائدة",
      "الأنعام",
      "الأعراف",
      "الأنفال",
      "التوبة",
      "يونس",
      "هود",
      "يوسف",
      "الرعد",
      "ابراهيم",
      "الحجر",
      "النحل",
      "الإسراء",
      "الكهف",
      "مريم",
      "طه",
      "الأنبياء",
      "الحج",
      "المؤمنون",
      "النور",
      "الفرقان",
      "الشعراء",
      "النمل",
      "القصص",
      "العنكبوت",
      "الروم",
      "لقمان",
      "السجدة",
      "الأحزاب",
      "سبإ",
      "فاطر",
      "يس",
      "الصافات",
      "ص",
      "الزمر",
      "غافر",
      "فصلت",
      "الشورى",
      "الزخرف",
      "الدخان",
      "الجاثية",
      "الأحقاف",
      "محمد",
      "الفتح",
      "الحجرات",
      "ق",
      "الذاريات",
      "الطور",
      "النجم",
      "القمر",
      "الرحمن",
      "الواقعة",
      "الحديد",
      "المجادلة",
      "الحشر",
      "الممتحنة",
      "الصف",
      "الجمعة",
      "المنافقون",
      "التغابن",
      "الطلاق",
      "التحريم",
      "الملك",
      "القلم",
      "الحاقة",
      "المعارج",
      "نوح",
      "الجن",
      "المزمل",
      "المدثر",
      "القيامة",
      "الانسان",
      "المرسلات",
      "النبإ",
      "النازعات",
      "عبس",
      "التكوير",
      "الإنفطار",
      "المطففين",
      "الإنشقاق",
      "البروج",
      "الطارق",
      "الأعلى",
      "الغاشية",
      "الفجر",
      "البلد",
      "الشمس",
      "الليل",
      "الضحى",
      "الشرح",
      "التين",
      "العلق",
      "القدر",
      "البينة",
      "الزلزلة",
      "العاديات",
      "القارعة",
      "التكاثر",
      "العصر",
      "الهمزة",
      "الفيل",
      "قريش",
      "الماعون",
      "الكوثر",
      "الكافرون",
      "النصر",
      "المسد",
      "الإخلاص",
      "الفلق",
      "الناس"
    ];
    List surahsList = [];
    List surahsIndexesList = widget.suras
        .split(',') // split the text into an array
        .toList();
    for (int i = 0; i < surahsIndexesList.length; i++) {
      String mIndex = surahsIndexesList[i];
      var index = int.parse(mIndex);
      assert(index is int);
      index = index - 1;
      String surahName = allSurahNames[index];
      if (surahName != null && surahName.isNotEmpty) {
        surahsList.add(surahName);
      }
    }


    return   Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(child: Text(widget.title,style: GoogleFonts.arvo(textStyle: TextStyle(
          color: AdManager.getTextColor(),
          fontSize: 22.0,
        )),)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: surahsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      int currentSurah = index+1;
                      String surah = allSurahNames[index];
                      String mSurah = "سُورَة‎";

                      return Container(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                        child: Ink(
                          child: Card(
                            color: AdManager.getNeumorphicBackgroundColor(),
                            elevation: 18.0,
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  clickItem++ ;
                                  if(clickItem % 3==0){
                                    showAdmobFullScreenAds();
                                    isfirstTime=false;
                                  }
                                  String mIndex = surahsIndexesList[index];
                                  var indexs = int.parse(mIndex);
                                  assert(indexs is int);

                                  playingAudio = ""+ mSurah+' '+surahsList[index];
                                  setState(() {

                                    isplaying = false;
                                  });
                                  if(indexs<10){

                                    mp3Url = widget.Server+"/00"+surahsIndexesList[index]+".mp3";
                                    isplaying = true;
                                    if(_player!=null&&_player!.playerState.playing==true){
                                      _player!.stop();

                                    }
                                    playAudioJustPlayer(mp3Url);

                                    isplaying = true;


                                  }else if(indexs<100){

                                    mp3Url = widget.Server+"/0"+surahsIndexesList[index]+".mp3";
                                    isplaying = true;
                                    if(_player!=null&&_player!.playerState.playing==true){
                                      _player!.stop();

                                    }
                                    playAudioJustPlayer(mp3Url);

                                    isplaying = true;

                                  }else{

                                    mp3Url = widget.Server+"/"+surahsIndexesList[index]+".mp3";
                                    isplaying = true;
                                    if(_player!=null&&_player!.playerState.playing==true){
                                      _player!.stop();

                                    }
                                    playAudioJustPlayer(mp3Url);

                                    isplaying = true;

                                  }


                                },
                                contentPadding: EdgeInsets.all(15),
                                title: Center(
                                  child: Text(
                                    mSurah+' '+surahsList[index],
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.arvo(textStyle: TextStyle(
                                      color: AdManager.getTextColor(),
                                      fontSize: 23.0,
                                    )),
                                  ),
                                ),
                                /* subtitle: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 16.0,
                                        fontFamily: "Raleway"),
                                    maxLines: 2,),
                                ),*/
                                trailing:  Text(
                                  ".$currentSurah",
                                  style: GoogleFonts.arvo(textStyle: TextStyle(
                                    color: AdManager.getTextColor(),
                                    fontSize: 22.0,
                                  )),
                                ),
                                leading: Card(
                                  elevation: 18.0,
                                  color: AdManager.getNeumorphicBoxShadowColorLight(),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.ondemand_video,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: AdManager.getNeumorphicBoxShadowColorLight(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );


                    },
                  ),
                ),
              ),
            ),
          ),
          LoadAdmobBannerAds(),
          isplaying?
          Container(

            color: AdManager.getNeumorphicBackgroundColor(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:15.0),
                  child: StreamBuilder<SequenceState?>(
                    stream: _player!.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state?.sequence?.isEmpty ?? true) return SizedBox(height: 0,);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text( playingAudio ?? '',  textDirection: TextDirection.rtl,
                            style: GoogleFonts.arvo(
                                textStyle: TextStyle(
                                  color: AdManager.getTextColor(),
                                  fontSize: 18.0,
                                )),),
                        ],
                      );
                    },
                  ),
                ),
                StreamBuilder<Duration?>(
                  stream: _player!.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;
                    return StreamBuilder<PositionData>(
                      stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                          _player!.positionStream,
                          _player!.bufferedPositionStream,
                              (position, bufferedPosition) =>
                              PositionData(position, bufferedPosition)),
                      builder: (context, snapshot) {
                        final positionData = snapshot.data ??
                            PositionData(Duration.zero, Duration.zero);
                        var position = positionData.position ?? Duration.zero;
                        if (position > duration) {
                          position = duration;
                        }
                        var bufferedPosition =
                            positionData.bufferedPosition ?? Duration.zero;
                        if (bufferedPosition > duration) {
                          bufferedPosition = duration;
                        }
                        return SeekBar(
                          duration: duration,
                          position: position,
                          bufferedPosition: bufferedPosition,
                          onChangeEnd: (newPosition) {
                            _player!.seek(newPosition);
                          }, onChanged: (Duration value) {  },
                        );
                      },
                    );
                  },
                ),
                ControlButtons(_player!),
              ],
            ),
          ):Container(width: 0,height: 0,),



        ],
      ),
    ) ;
  }


  Future<void> playAudioJustPlayer(String mp3url) async {

    _player = AudioPlayer();
    var duration = await _player!.setUrl(mp3url);

    _player!.play();
  }
}

class ControlButtons extends StatelessWidget {
  late AudioPlayer player;

  ControlButtons(AudioPlayer player){
    this.player = player;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<LoopMode>(
            stream: player.loopModeStream,
            builder: (context, snapshot) {
              final loopMode = snapshot.data ?? LoopMode.off;
              const icons = [
                Icon(Icons.repeat, color: Colors.white),
                Icon(Icons.repeat, color: Colors.white),
                Icon(Icons.repeat_one, color: Colors.white),
              ];
              const cycleModes = [
                LoopMode.off,
                LoopMode.all,
                LoopMode.one,
              ];
              final index = cycleModes.indexOf(loopMode);
              return IconButton(
                icon: icons[index],
                onPressed: () {
                  player.setLoopMode(cycleModes[
                  (cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              _showSliderDialog(
                context: context,
                title: "Adjust volume",
                divisions: 10,
                min: 0.0,
                max: 1.0,
                stream: player.volumeStream,
                onChanged: player.setVolume,
              );
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) => IconButton(
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
              onPressed: player.hasPrevious ? player.seekToPrevious : null,
            ),
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  width: 34.0,
                  height: 34.0,
                  child: CircularProgressIndicator(),
                );
              } else if (playing != true) {
                return IconButton(
                  icon: Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 54.0,
                  onPressed: player.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: Icon(Icons.pause_circle_filled_rounded, color: Colors.white),
                  iconSize: 54.0,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.replay_circle_filled, color: Colors.white),
                  iconSize: 54.0,
                  onPressed: () => player.seek(Duration.zero,
                      index: player.effectiveIndices!.first),
                );
              }
            },
          ),
          StreamBuilder<SequenceState?>(
            stream: player.sequenceStateStream,
            builder: (context, snapshot) => IconButton(
              icon: Icon(Icons.skip_next, color: Colors.white),
              onPressed: player.hasNext ? player.seekToNext : null,
            ),
          ),
          StreamBuilder<double>(
            stream: player.speedStream,
            builder: (context, snapshot) => IconButton(
              icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                _showSliderDialog(
                  context: context,
                  title: "Adjust speed",
                  divisions: 10,
                  min: 0.5,
                  max: 1.5,
                  stream: player.speedStream,
                  onChanged: player.setSpeed,
                );
              },
            ),
          ),
          StreamBuilder<bool>(
            stream: player.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              final shuffleModeEnabled = snapshot.data ?? false;
              return IconButton(
                icon: shuffleModeEnabled
                    ? Icon(Icons.shuffle, color: Colors.white)
                    : Icon(Icons.shuffle, color: Colors.white),
                onPressed: () async {
                  final enable = !shuffleModeEnabled;
                  if (enable) {
                    await player.shuffle();
                  }
                  await player.setShuffleModeEnabled(enable);
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: TextStyle(color: Colors.white)),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

_showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required  ValueChanged<double> onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({required this.album, required this.title, required this.artwork});
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
