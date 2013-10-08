BookLety.factory "Session",['$location','$resource', ($location,$resource ) ->
  class Session
    constructor: (successCallback,errorCallback) ->
      @successCallback = successCallback
      @errorCallback   = errorCallback
      @service  = $resource '/login'

    create:(attrs) ->
      new @service(user: attrs).$save ((user) -> attrs.id = user.id), @successCallback, @errorCallback


]