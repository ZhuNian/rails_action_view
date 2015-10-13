global = this

class Widget
  constructor: (@element) ->
    @element.data('widget', this)

  buildDom: ->
  enhancePage: ->
  initialize: ->

  findWidgets: (finder, selector) ->
    $(item).data('widget') for item in @element[finder].call(@element, selector)

  findWidget: (finder, selector) ->
    @element[finder].call(@element, selector).data('widget')

  findSubWidgets: (widgetName) ->
    @findWidgets('find', "[data-widget='#{widgetName}']")

  findSubWidget: (widgetName) ->
    @findWidget('find', "[data-widget='#{widgetName}']")

  findSiblingWidget: (widgetName) ->
    @findWidget('siblings', "[data-widget='#{widgetName}']")

  findParentWidget: (widgetName) ->
    @findWidget('parents', "[data-widget='#{widgetName}']")


this.Widget = Widget

ContainerMethods =
  widgets:
    {}

  register: (widget, name = null) ->
    name = widget.name unless name?
    Widget.widgets[name] = widget

  find: (name, includeGlobal = true) ->
    name = name.split('.') if name.constructor is String

    currentName = name.shift()
    if includeGlobal
      widget = this.widgets[currentName] ? global[currentName]
    else
      widget = this.widgets[currentName]

    return widget if name.length == 0

    return null unless widget?

    widget.find(name, false)

WidgetClassMethods =
  loadOnReady: ->
    $ ->
      Widget.buildWidgets()

  buildWidgets: (scope = null) ->
    unless scope?
      scope = $(document)
    else if scope instanceof String
      scope = $(scope)
    unless scope instanceof jQuery
      console.error "ERROR: Unknown Scope", scope

    widgets = []

    scope.find('[data-widget]').each ->
      $this = $(this)
      widgetName = $this.data('widget')

      unless widgetName?
        console.error "ERROR: Widget name is empty", $this
        return

      unless widgetName.constructor is String
#        console.warn 'WARNING: Widget is initialized', $this
        return

      widgetConstructor = Widget.find(widgetName)

      if widgetConstructor
        widgets.push new widgetConstructor($this)
      else
        console.error "ERROR: Unknown widget #{widgetName}", $this

    for widget in widgets
      widget.buildDom()

    for widget in widgets
      widget.enhancePage()

    for widget in widgets
      widget.initialize()

  enableContainer: (widget) ->
    $.extend widget, ContainerMethods

$.extend Widget, ContainerMethods, WidgetClassMethods

Widget.loadOnReady()
