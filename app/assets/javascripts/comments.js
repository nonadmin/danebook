var DB = DB || {};


DB.Comment = (function($){

  var create = function(comment, parentID, parentType){
    var parent = "[data-id='" + parentID + "'][data-type='" + parentType + "']";
    var lastComment = $(parent + " .comment").last();
    var commentForm = $(parent + " [data-type='comment-form']");

    // handle case of no comments, so no last comment, basically
    // just adding an <hr>
    
    if ( lastComment.length ){
      $(comment).insertAfter( lastComment ).hide().slideDown();
    } else {
      $("<hr>" + comment).insertBefore( commentForm ).hide().slideDown();
    }

    commentForm.find('textarea').val("");
  };

  return {
    create: create
  };

})($);