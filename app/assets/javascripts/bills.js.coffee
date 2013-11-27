# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# window.Object.prototype.get = (str) ->
# 	self = this
# 	for node in str.split('.')
# 		self = self[node]
# 	self

jQuery(document).ready ->

  jQuery('[data-behaviour~=datepicker]').datepicker({language:'zh-CN',format:'yyyy-mm-dd'})
	jQuery(".modal-list").delegate 'a', 'click', ->
		self = jQuery(this)
		data = self.data()
		div  = self.parents('.modal-list')		
		div.find(".form-control.display").text(data.name)
		div.find('input').val(data.id)
	jQuery(".master-form").bind 'ajax:success', (event,data)->
		# console.log(data)
		this.reset()
		self = jQuery(this)		
		self.parents('.modal').modal('hide')
		ul  = jQuery(self.data().selectTarget)				
		html = '<option value="' + data.real_id + '">' + data.name + '</a></option>'
		# console.log(ul)
		ul.prepend(html)
		ul.chosen('destroy').chosen()
		# console.log(self)
		# console.log(self.data())
	jQuery('.new-bill-form').bind 'ajax:success', (event,data)->
    alert('添加成功')
    window.location.reload()
		# console.log(data)
	jQuery('form').bind 'ajax:error', (event,request,settings) ->
		str = "请检查数据，分类，账户，成员，金额，时间必填"
		alert(str)
	jQuery('a.ajax-remove-tr').bind 'ajax:success', (event,data)->		
		id = jQuery(this).data('removeId')
		jQuery("#"+id).remove()
	jQuery('a.ajax-edit-tr').bind 'ajax:success', (event,data) ->
		modal = jQuery('#edit-bill-modal')
		# console.log(data)
		modal.html(data)
		modal.find('.modal').modal('show')
		modal.find('.modal').find('select').chosen()
		modal.find('.modal').find(".chosen-container").css('width','100%')
	
	get_object = (data,str) ->
		self = data

		for node in str.split('.')
			# console.log("*******************************************")
			# console.log(self)
			# self ||= {}			
			self = self[node]
		self

	jQuery('#edit-bill-modal').delegate 'form', 'ajax:success', (event,data) ->
		id = data.real_id
		tr = jQuery("#"+ id)

		alert(tr)
		tr.parent().find('tr').removeClass('success')
		tds = tr.find("td")		
		for td in tds
			node = jQuery(td).attr("field")
			if node					
				jQuery(td).html(get_object(data, node)) 
		tr.addClass('success')
		jQuery('#edit-bill-modal').find('.modal').modal('hide')



	jQuery(".chosen").chosen()
	jQuery(".chosen-container").css('width','100%')
