class UsersController < ApplicationController
  def index
    @users = User.all.order({ :username => :asc })

    render({ :template => "users/index.html" })
  end

  def show
    the_username = params.fetch("the_username")

    @user = User.where({ :username => the_username }).at(0)

    if @user.private == true and @user.id != session.fetch(:user_id)
      redirect_to("/", { :notice => "You're not authorized for that." })
    else
      render({ :template => "users/show.html.erb" })
    end
  end

  def feed
    the_username = params.fetch("the_username")

    @user = User.where({ :username => the_username }).at(0)
    @Likedphotos = Like.where({ :Fan_id => @user.id })

    if @user.private == true and @user.id != session.fetch(:user_id)
      redirect_to("/", { :notice => "You're not authorized for that." })
    else
      render({ :template => "users/feed.html.erb" })
    end
  end

  def update
    the_id = params.fetch("the_user_id")
    user = User.where({ :id => the_id }).at(0)

    user.username = params.fetch("input_username")

    user.save

    redirect_to("/users/#{user.username}")
  end
end
