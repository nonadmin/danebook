class CommentMailer < ApplicationMailer
  default from: "noreply@test.nightiron.com"


  def new_comment(comment)
    @comment = comment
    mail(to: comment.commentable.author.email, subject: "New Comment on Danebook!")
  end
end
