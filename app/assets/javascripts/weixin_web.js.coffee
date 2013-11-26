jQuery(document).ready ->
  jQuery("#weixin_web_bill_type_select").bind 'change', ->
    # console.log($(this).data())
    d = jQuery(this).data()
    item = jQuery(d.itemTarget)
    if this.value == 0 
      item.html("")
    else
      jQuery.get '/weixin_web/bills/get_items', {bill_type_id: this.value, weixin_id: d.weixinId, signation: d.signation}, 'json', (data) ->
        options = "<option value=''></option>"
        for d in data
          options += "<option value='" + d.id + "'>" + d.name + "</option>"
        item.html(options)

  jQuery('a.ajax-remove-tr').bind 'ajax:success', (event,data)->
    id = jQuery(this).data('removeId')
    jQuery("#"+id).remove()