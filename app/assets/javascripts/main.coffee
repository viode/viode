$ ->
  $(document).on 'click', '#question-shortlink', ->
    @select()

  searchForm = ->
    $('.js-search-form').submit ->
      $searchQuery = $(@).find('input[type="search"]').val()
      if $searchQuery.trim().length <= 1 then false else true
  searchForm()
