// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// // -------------------------
// Multiple File Upload
// -------------------------
//
function MultiSelector(list_target, max) {
  this.list_target = list_target;this.count = 0;this.id = 0;if( max ){this.max = max;} else {this.max = -1;};this.addElement = function( element ){if( element.tagName == 'INPUT' && element.type == 'file' ){element.name = 'attachment[file_' + (this.id++) + ']';element.multi_selector = this;element.onchange = function(){var new_element = document.createElement( 'input' );new_element.type = 'file';this.parentNode.insertBefore( new_element, this );this.multi_selector.addElement( new_element );this.multi_selector.addListRow( this );this.style.position = 'absolute';this.style.left = '-1000px';};if( this.max != -1 && this.count >= this.max ){element.disabled = true;};this.count++;this.current_element = element;} else {alert( 'Error: not a file input element' );};};this.addListRow = function( element ){var new_row = document.createElement('li');var new_row_button = document.createElement( 'a' );new_row_button.title = 'Remove This Image';new_row_button.href = '#';new_row_button.innerHTML = 'Remove';new_row.element = element;new_row_button.onclick= function(){this.parentNode.element.parentNode.removeChild( this.parentNode.element );this.parentNode.parentNode.removeChild( this.parentNode );this.parentNode.element.multi_selector.count--;this.parentNode.element.multi_selector.current_element.disabled = false;return false;};new_row.innerHTML = element.value.split('/')[element.value.split('/').length - 1];new_row.appendChild( new_row_button );this.list_target.appendChild( new_row );};
}

/***
 * Excerpted from "Advanced Rails Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
***/

var LoginCheck = Class.create({
  initialize: function(cookie_name) {    
    var cookie_value = get_cookie(cookie_name);
    if (!cookie_value) {      
      $('login').update("<a href=\"/login\">Log In</a>");
    } else {
      $('login').update("Welcome, " + cookie_value.escapeHTML() + "!" + 
                        " (<a href=\"/logout\">Log Out</a>)");
    }
  }
});

function get_cookie(name) {
  var value = null;
  document.cookie.split('; ').each(function(cookie) {
    var name_value = cookie.split('=');
    if (name_value[0] == name) {
      value = name_value[1];
    }
  });
  return value;
}


