(function() {
  jQuery(document).ready(function() {
    var get_object;
    jQuery(".modal-list").delegate('a', 'click', function() {
      var data, div, self;
      self = jQuery(this);
      data = self.data();
      div = self.parents('.modal-list');
      div.find(".form-control.display").text(data.name);
      return div.find('input').val(data.id);
    });
    jQuery(".master-form").bind('ajax:success', function(event, data) {
      var html, self, ul;
      this.reset();
      self = jQuery(this);
      self.parents('.modal').modal('hide');
      console.log(self.data());
      ul = jQuery(self.data().selectTarget);
      html = '<option value="' + data.real_id + '">' + data.name + '</a></option>';
      console.log(ul);
      ul.prepend(html);
      return ul.chosen('destroy').chosen();
    });
    jQuery('.new-bill-form').bind('ajax:success', function(event, data) {
      return window.location.reload();
    });
    jQuery('form').bind('ajax:error', function(event, request, settings) {});
    jQuery('a.ajax-remove-tr').bind('ajax:success', function(event, data) {
      var id;
      id = jQuery(this).data('removeId');
      return jQuery("#" + id).remove();
    });
    jQuery('a.ajax-edit-tr').bind('ajax:success', function(event, data) {
      var modal;
      modal = jQuery('#edit-bill-modal');
      modal.html(data);
      modal.find('.modal').modal('show');
      modal.find('.modal').find('select').chosen();
      return modal.find('.modal').find(".chosen-container").css('width', '100%');
    });
    get_object = function(data, str) {
      var node, self, _i, _len, _ref;
      self = data;
      _ref = str.split('.');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        console.log("*******************************************");
        console.log(self);
        self = self[node];
      }
      return self;
    };
    jQuery('#edit-bill-modal').delegate('form', 'ajax:success', function(event, data) {
      var id, node, td, tds, tr, _i, _len;
      id = data.real_id;
      tr = jQuery("#" + id);
      tr.parent().find('tr').removeClass('success');
      tds = tr.find("td");
      console.log(data);
      console.log(id);
      console.log(tds);
      for (_i = 0, _len = tds.length; _i < _len; _i++) {
        td = tds[_i];
        node = jQuery(td).attr("field");
        if (node) {
          console.log(get_object(data, node));
          console.log(jQuery(td));
          jQuery(td).html(get_object(data, node));
        }
      }
      tr.addClass('success');
      return jQuery('#edit-bill-modal').find('.modal').modal('hide');
    });
    jQuery(".chosen").chosen();
    return jQuery(".chosen-container").css('width', '100%');
  });

}).call(this);
