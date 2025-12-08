import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_depi_final_project/core/errors/api_exception.dart';
import 'package:news_depi_final_project/generated/l10n.dart';

abstract class IGeminiRemoteDataSource {
  Future<String> generateText(String prompt);
}

class GeminiRemoteDataSourceImpl implements IGeminiRemoteDataSource {
  final Gemini _gemini;

  GeminiRemoteDataSourceImpl(this._gemini);

  @override
  Future<String> generateText(String prompt) async {
    try {
      final response = await _gemini.text(prompt);

      final text = response?.output;

      if (text != null && text.isNotEmpty) {
        return text;
      } else {
        throw ServerException(message: S.current.geminiEmptyResponse);
      }
    } catch (e) {
      throw ServerException(message: S.current.geminiApiError(e.toString()));
    }
  }
}
