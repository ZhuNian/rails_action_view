class @Form extends Widget
  buildDom: ->
    @btn = @element.find('.btn')
    @form = @element.find('#form')
  initialize: ->
    @btn.click =>
      $.post('form'
        email_text:"btn worked"
        (data)=>
          debugger
          @form.html(data)
          Widget.buildWidgets(@form))
  enhancePage: ->

