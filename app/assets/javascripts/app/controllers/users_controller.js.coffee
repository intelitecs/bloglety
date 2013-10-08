@UsersController = ($scope,$location,$routeParams,$http,User,$rootScope) ->
    $scope.searching = true
    $scope.message = "Here is the UsersController"
    $scope.errors = null
    $scope.click_count = 0

    #Getting all the user stored in the rootScope
    $scope.users = $rootScope.users
    $scope.user = {}
    $scope.dones = {}




    $scope.getAllSucessCallback = (response) ->
      $scope.users = response
      console.log("get all success reponse : #{response}")


    $scope.getOneSucessCallback = (response) ->
        $scope.user = response
        console.log("user for get's response is: #{$scope.user.username}  #{$scope.user.email}")

    $scope.createSuccessCallback = (response) ->
      console.log("user created successfully!")
      user = {id: response.id, username:response.username,email:response.email,comments:response.comments,created_at:response.created_at, updated_at:response.updated_at}
      $scope.user = user
      $scope.users.unshift(user)
      $scope.username = ""
      $scope.email = ""
      $scope.password = ""
      $scope.password_confirmation = ""
      $location.path("/")  #we can change the url with sucess message page, like welcome page

    $scope.updateSuccessCallback = (response) ->
      console.log("update success response: #{response}")


    $scope.deleteSuccessCallback = (response) ->
      console.log("delete success response: #{response}")
      $scope.message = "compte supprimé avec succès!"



    $scope.createErrorCallback = (errors) ->
      if errors
        console.log(errors)
        console.log("server responded with status: #{errors.status}")
        username_errors =  errors.data.username
        email_errors    =  errors.data.email
        password_errors =  errors.data.password
        password_confirmation_errors = errors.data.password_confirmation
        $scope.errors = {username_errors: errors.data.username,email_errors:email_errors,password_errors:password_errors, password_confirmation_errors: password_confirmation_errors}

        if username_errors
          console.log("There are #{username_errors.length} errors on username attribute")
          for k,v of username_errors
            if k != "length"
              console.log("\t"+v)

        if email_errors
          console.log("There are #{email_errors.length} errors on email attribute")
          for k,v of email_errors
            if k != "length"
              console.log("\t"+v)

        if password_errors
          console.log("There are #{password_errors.length} errors on password attribute")
          for k,v of password_errors
            if k != "length"
              console.log("\t"+v)

        if password_confirmation_errors
          console.log("There are #{password_confirmation_errors.length} errors on password confirmation attribute")
          for k,v of password_confirmation_errors
            if k != "length"
              console.log("\t"+v)




    $scope.errorCallback = (errors) ->
      if errors
        console.log(errors)



    $scope.initialize = (successCallback,errorCallback) ->
      if((angular.isFunction(successCallback) ) and (angular.isFunction(errorCallback)))
        @userService = new User(successCallback,errorCallback)
      #$scope.users = @userService.all()

    #GET a user by its id
    $scope.get = (id) ->
      $scope.initialize($scope.getOneSucessCallback,$scope.errorCallback)
      @userService.get(id)


    #create a new user
    $scope.addUser = ->
      $scope.initialize($scope.createSuccessCallback,$scope.createErrorCallback)
      @userService.create({username: $scope.username, email: $scope.email, password: $scope.password, password_confirmation: $scope.password_confirmation})



    $scope.deleteUser = (user) ->
      $scope.initialize($scope.deleteSuccessCallback,$scope.errorCallback)
      @userService.delete(user)
      $scope.users.splice($scope.users.indexOf(user),1)


    $scope.updateUser = (user,data) ->
      $scope.initialize($scope.updateSuccessCallback,$scope.errorCallback)
      @userService.update(user,data)
      $scope.message = "compte #{user.username} modifié avec succès!"


    $scope.updateUserForId = (id,data) ->
      user = _.findWhere $scope.users,{id: id}
      $scope.user = user
      $scope.updateUser(user,data)

    #$scope.updateUserForId(10,{username:'jean-charles',email:'charlies@yahoo.fr',password: 'jeancharles', password_confirmation:'jeancharles'})

    $scope.getDone = ->
      $scope.dones = _.filter $scope.users, (user) ->
        user.done

    $scope.new = ->
      $location.path('/users/new')


    $scope.deleteSelectedUsers = ->
      confirmation_message = null;
      if($scope.dones.length == 1)
        confirmation_message = "Êtes-vous sure supprimer le compte #{$scope.dones[0].username} ?"
      else
        confirmation_message = "Etes vous sure de supprimer les #{$scope.dones.length} comptes sélectionnés?"
      unless !confirm(confirmation_message)
        for index,user of $scope.dones
          $scope.deleteUser(user)
        $scope.message =  "selection supprimée avec succès"
      else
        for index, user of $scope.dones
          user.done = false  #deselect all the selected users

    $scope.displaySignUpForm = ->
      $("span.tooltip").hide()
      $location.path("/users/new")


    $scope.show_user = (user) ->
      $scope.click_count += 1
      if $scope.click_count%2 == 0 or user.done
        $rootScope.table_row_user = null
      else
        $rootScope.table_row_user = user



      #$location.path("/users/#{user.id}")

    #$(document).click ->
    #  $('div.user_infos').hide()











