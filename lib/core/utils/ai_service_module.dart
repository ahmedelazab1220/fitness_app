import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import 'constants.dart';
import 'datasource_excution/api_constants.dart';

@module
abstract class AiModelModule {
  @singleton
  GenerativeModel provideGenerativeModel() => GenerativeModel(
    model: Constants.aiModelVersion,
    apiKey: ApiConstants.aiModelApiKey,
  );
}
