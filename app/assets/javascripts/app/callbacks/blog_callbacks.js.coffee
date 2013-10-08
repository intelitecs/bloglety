@Callbacks = ($scope) ->

  $scope.getAllCommentsSuccessCallback = (response) ->
    $scope.comments = response
    console.log("Fetched all comments successffully!")
    console.log("comments : #{$scope.comments}")

  $scope.getOneCommentSuccessCallback = (response) ->
    $scope.comment = null
    $scope.comment = response
    console.log("Fetched one comment successffully!")
    console.log("comment: #{$scope.comment}")



  $scope.getAllSuccessCallback = (response) ->
    $scope.articles = response
    console.log("Fetched all articles successffully!")
    console.log("articles : #{$scope.articles}")

  $scope.getOneSuccessCallback = (response) ->
    $scope.article = null
    $scope.article = response
    console.log("Fetched one article successffully!")
    console.log("article: #{$scope.article}")
    console.log("#{$scope.article.id} #{$scope.article.title}  #{$scope.article.description}")




  $scope.createSuccessCallback = (response) ->
    console.log("article created successfully")
    article = {id: response.id, title: response.title, description: response.description, created_at: response.created_at, updated_at: response.updated_at}
    $scope.article = article
    $scope.articles.unshift($scope.article)
    $scope.article_title =""
    $scope.article_description=""
    $scope.article_image=""
    $location.path("/")


  $scope.updateSuccessCallback = (response) ->
    console.log($scope.message)
    $location.path('/articles')

  $scope.deleteSuccessCallback = (response) ->
    console.log("article deleted sucessfully")
    $scope.setNextArticle()


  $scope.createErrorCallback = (errors) ->
    if errors
      console.log("server responded with status: #{errors.status}")
      title_errors          =  errors.data.title
      description_errors    =  errors.data.description
      image_errors          =  errors.data.image
      $scope.errors = {title_errors: title_errors,description_errors:description_errors,image_errors:image_errors}


  $scope.errorCallback = (errors) ->
    if errors?
      console.log("server responded with status: #{errors.status}")
      console.log($scope.errors)
