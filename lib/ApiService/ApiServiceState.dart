abstract class ApiServiceState{

}

class ApiServiceInitialState extends ApiServiceState{}

class ApiServiceLoadingState extends ApiServiceState{}

class ApiServiceLoadedState extends ApiServiceState{
  ApiServiceLoadedState(String body){
    this.jsonBody = body;
  }
  late String jsonBody;
}