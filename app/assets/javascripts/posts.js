var DB = DB || {};


DB.Post = (function($){

  var create = function(post){
    $(post).insertAfter( '#post-form' ).hide().slideDown();
  };

  return {
    create: create
  };

})($);