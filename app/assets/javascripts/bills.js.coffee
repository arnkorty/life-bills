# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$(".modal-list").delegate 'a', 'click',->
		self = $(this)
		data = self.data()
		div  = self.parents('.modal-list')		
		div.find(".form-control.display").text(data.name)
		div.find('input').val(data.id)
	$(".master-form").bind 'ajax:success', (event,data)->
		# console.log(data)
		this.reset()
		self = $(this)		
		self.parents('.modal').modal('hide')
		console.log(self.data())
		ul  = $(self.data().selectTarget)				
		html = '<option value="' + data.real_id + '">' + data.name + '</a></option>'
		console.log(ul)
		ul.prepend(html)
		ul.chosen('destroy').chosen()
		# console.log(self)
		# console.log(self.data())
	$('.new-bill-form').bind 'ajax:success', (event,data)->
		window.location.reload()
		console.log(data)
	$('form').bind 'ajax:error', (event,request,settings) ->
		console.log(event)
		console.log(request.responseJSON)
		console.log(settings)
	$('a.ajax-remove-tr').bind 'ajax:success', (event,data)->		
		id = $(this).data('removeId')			
		$("#"+id).remove()
	$('a.ajax-edit-tr').bind 'ajax:success', (event,data) ->
		modal = $('#edit-bill-modal')
		modal.html(data)
		modal.modal('show')

	$(".chosen").chosen()
	$(".chosen-container").css('width','100%')
