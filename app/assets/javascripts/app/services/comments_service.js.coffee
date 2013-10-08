BookLety.factory 'Comment', ['$resource','$rootScope', ($resource,$rootScope) ->
  class Comment
    constructor: (successCallback, errorCallback) ->
      @service = $resource '/articles/:article_id/comments/:id', {article_id: '@article_id', id: '@id'}, {update: {method: 'PATCH'}}
      @errorCallback = errorCallback
      @successCallback = successCallback
      @service::save = ->
        if @id?
          @update()
        else
          @create()


    create: (article,attrs) ->
      new @service(comment: attrs).$save {article_id: article.id, id: attrs.id},@successCallback, @errorCallback

    delete: (comment) ->
      new @service().$delete {id:comment.id, article_id: comment.article_id}, @successCallback, @errorCallback

    #delete: (article,id) ->
    #  new @service().$delete {id:id, article_id: article.id}, @successCallback, @errorCallback


    update: (comment, attrs) ->
      new @service(comment: attrs).$update {article_id: comment.article.id, id:comment.id}, @successCallback, @errorCallback

    #update: (id,article, attrs) ->
    #  new @service(comment: attrs).$update {article_id: article.id, id:id}, @successCallback, @errorCallback


    get: (article,id) ->
      @service.get {article_id: article.id, id: id}, @successCallback, @errorCallback

    all:(article) ->
      @service.query {article_id: article.id}, @successCallback, @errorCallback


]

