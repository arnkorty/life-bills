# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$(".bill-type").bind 'click',->
		self = $(this)
		billType = self.data("billType")
		$(".bill-type").removeClass("active")
		self.addClass("active")
		$(".bill-form").hide()
		$("#"+billType + "-form").show()

