import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/experience_model.dart';
import 'package:psp_developer/src/repositories/experiences_repository.dart';
import 'package:tuple/tuple.dart';

class ExperiencesBloc with Validators {
  final _experienceRepository = ExperienceRepository();

  Future<Tuple2<int, ExperienceModel>> getExperience() async =>
      await _experienceRepository.getExperiences();

  Future<bool> haveExperience() async {
    bool haveExperiences;

    final experienceWithStatusCode =
        await _experienceRepository.getExperiences();

    if (experienceWithStatusCode.item1 == 404) {
      haveExperiences = false;
    } else if (experienceWithStatusCode.item1 == 200) {
      haveExperiences = true;
    }

    return haveExperiences;
  }

  Future<int> insertExperience(ExperienceModel experience) async {
    final result = await _experienceRepository.insertExperience(experience);
    final statusCode = result.item1;

    return statusCode;
  }

  Future<int> updateExperience(ExperienceModel experience) async {
    final statusCode = await _experienceRepository.updateExperience(experience);

    return statusCode;
  }
}
