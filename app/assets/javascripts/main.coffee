$ ->
  $(document).on 'click', '#question-shortlink', ->
    @select()

  initPlugins = ->
    $('.js-timeago').timeago();

  initPlugins()

  searchInputExpand = ->
    $searchInput = $('#js-search-input-header')

    $searchInput.on 'focus', ->
      $(@).animate { width: '200%' }, 300

    $searchInput.on 'blur', ->
      if $(@).val().trim() == ''
        $(@).animate { width: '100%' }, 300
        $(@).val ''

  searchInputExpand()

  searchForm = ->
    $('.js-search-form').submit ->
      $searchQuery = $(@).find('input[type="search"]').val()
      if $searchQuery.trim().length <= 1 then false else true

  searchForm()
