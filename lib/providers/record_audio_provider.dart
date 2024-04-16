import 'dart:core';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:record_with_play/services/permission_management.dart';
import 'package:record_with_play/services/storage_management.dart';
import 'package:record_with_play/services/toast_services.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../screens/display_prediction.dart';
import 'dart:async';

class RecordAudioProvider extends ChangeNotifier {
  final _record = AudioRecorder();
  bool _isRecording = false;
  String _afterRecordingFilePath = '';
  String? _audioFilePath;
  bool get isRecording => _isRecording;
  String get recordedFilePath => _afterRecordingFilePath;
  String? _predictionResult;
  String? get predictionResult => _predictionResult;
  bool _forceStop = false; // Flag to track forced stop

  clearOldData() {
    _afterRecordingFilePath = '';
    _predictionResult = null;
    notifyListeners();
  }

  recordVoice() async {
    print('Recording voice...');
    final _isPermitted = (await PermissionManagement.recordingPermission()) &&
        (await PermissionManagement.storagePermission());

    if (!_isPermitted) return;

    if (!(await _record.hasPermission())) return;

    final _voiceDirPath = await StorageManagement.getAudioDir;
    final _voiceFilePath = StorageManagement.createRecordAudioPath(
        dirPath: _voiceDirPath, fileName: 'audio_message');

    await _record.start(const RecordConfig(), path: _voiceFilePath);
    _isRecording = true;
    _forceStop = false; // Reset the flag
    notifyListeners();

    showToast('Recording Started');

    // Automatically stop recording after 7 seconds
    Timer(Duration(seconds: 7), () async {
      if (_isRecording && !_forceStop) {
        // Check if not already stopped forcefully
        await stopRecording();
      }
    });
  }

  stopRecording() async {
    if (await _record.isRecording()) {
      _audioFilePath = await _record.stop();
      showToast('Recording Stopped');
    }

    print('Audio file path: $_audioFilePath');

    _isRecording = false;

    if (_audioFilePath != null) {
      sendAudioForPrediction();
    }

    _afterRecordingFilePath = _audioFilePath ?? '';
    notifyListeners();
  }

  Future<String> getCsrfToken() async {
    var dioInstance = Dio();
    var response = await dioInstance.get(
        'https://jellyfish-app-jzksx.ondigitalocean.app/'); // Your Django domain
    // var response = await dioInstance.get('http://10.0.2.2:8000/'); // Your Django domain

    // Assuming your CSRF cookie is named 'csrftoken'
    // print(response.headers.value('Set-Cookie'));  // Is it null?
    print("Response: {$response}");
    String csrfToken =
        response.headers.value('Set-Cookie')!.split(';')[0].split('=')[1];
    // print(csrfToken.split(';')[0]); // Is something wrong with the split?
    print("After stripping: {$csrfToken}");
    return csrfToken;
  }

  Future<void> sendAudioForPrediction() async {
    // ... (Get CSRF token if not already fetched) ...
    // String csrfToken = await getCsrfToken(); // Fetch CSRF token if needed
    // print("Fetched CSRF Token: $csrfToken");
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(_audioFilePath!,
          filename: 'recorded_audio.wav')
    });

    var dioInstance = Dio();
    // dioInstance.options.headers['X-CSRFToken'] = csrfToken; // Set the header
    // print("Dio Headers: ${dioInstance.options.headers}"); // Inspect these

    var response = await dioInstance
        .post('http://64.227.140.90/api/flutter-upload/', data: formData);
    // var response = await dioInstance.post('http://10.0.2.2:8000/api/flutter-upload/', data: formData);
    // Handle prediction label from response.data
    if (response.statusCode == 200) {
      var isBaby = response.data['prediction'];
      if (isBaby == 'NotBC_training') {
        print("________");
        print("It's not a baby!");
        print("________");
        _predictionResult = 'Not a cry!';
      } else {
        _predictionResult = isBaby;
      }

      notifyListeners(); // Notify UI to rebuild
    } else {
      print("Error: ${response.statusMessage}");
    }
  }
}
