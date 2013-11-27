jQuery(document).ready ->
  jQuery("#weixin_web_bill_type_select").bind 'change', ->
    # console.log($(this).data())
    d = jQuery(this).data()
    console.log(d)
    item = jQuery(d.itemTarget)
    console.log(item)
    # console.log(this.value)
    if this.value == '' 
      item.html("")
    else
      jQuery.get '/weixin_web/bills/get_items', {bill_type_id: this.value, weixin_id: d.weixinId, signature: d.signature}, (data) ->        
        options = "<option value=''></option>"
        for d in data
          options += "<option value='" + (d.id || d._id.$oid) + "'>" + d.name + "</option>"
        item.html(options)

  jQuery('a.ajax-remove-tr').bind 'ajax:success', (event,data)->
    id = jQuery(this).data('removeId')
    jQuery("#"+id).remove()
