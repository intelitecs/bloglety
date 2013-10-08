@SessionsController = ($scope,$rootScope,$routeParams) ->
  $scope.current_user = {}

  $scope.current_user ||= _.findWhere($rootScope.users,{id: sessionStorage.get('user_id')})

  $scope.is_user_the_current_user = (user) ->
    $scope.current_user == user

  #$scope.sign_in = (user) ->


  #$scope.create = ->


