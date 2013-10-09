BookLety.factory "Session",['$location','$resource', ($location,$resource,$rootScope,$http) ->
  class Session
    constructor: (successCallback,errorCallback) ->
      @successCallback = successCallback
      @errorCallback   = errorCallback
      @service  = $resource '/login'

    create:(attrs) ->
      new @service(user: attrs).$save ((user) -> attrs.email = user.email attrs.password = user.password), @successCallback, @errorCallback

    @$destroy: ->
      $http.delete('/logout')


    authenticate: (email,password) ->
      found = _.findWhere $rootScope.users, {email: email, password: password}
      if found?
        true
      else
        false





]