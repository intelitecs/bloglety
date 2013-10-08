


BookLety.factory 'Article', ['$resource',($resource) ->
  class Article
    constructor:(successCallback,errorCallback) ->
      @service = $resource '/articles/:id',{id: '@id'},{update: {method: 'PATCH'}}
      @errorCallback = errorCallback
      @successCallback = successCallback
      @service::save = ->
        if @id?
          @update()
        else
          @create()


    create: (attrs) ->
      new @service(article: attrs).$save ((article) -> attrs.id = article.id),@successCallback, @errorCallback
      #attrs

    delete: (article) ->
      new @service().$delete {id: article.id}, @successCallback,@errorCallback

    update: (article,attrs) ->
      new @service(article: attrs).$update {id: article.id}, @successCallback, @errorCallback


    get: (id) ->
      @service.get {id: id},@successCallback, @errorCallback

    all: ->
      @service.query(@successCallback,@errorCallback)


]


