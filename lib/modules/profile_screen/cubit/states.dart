abstract class UpdateProfileStates{}

class UpdateProfileInitialState extends UpdateProfileStates{}

class UpdateProfileLoadingState extends UpdateProfileStates{}

class UpdateProfileSuccessState extends UpdateProfileStates{}

class UpdateProfileErrorState extends UpdateProfileStates{}

class GetUserInformationLoadingState extends UpdateProfileStates{}

class GetUserInformationSuccessState extends UpdateProfileStates{}

class GetUserInformationErrorState extends UpdateProfileStates{}

class ChangingBegins extends UpdateProfileStates{}

class ChangingEnds extends UpdateProfileStates{}

class ChangeText extends UpdateProfileStates{}
class ChangedText extends UpdateProfileStates{}