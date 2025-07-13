abstract class ApiServiceEvent{}

class ApiServiceLoadEvent extends ApiServiceEvent{
  ApiServiceLoadEvent(String myUrl);
}

  class ApiServiceLoadingEvent extends ApiServiceEvent{}


  class ApiServiceLoadedEvent extends ApiServiceEvent{}