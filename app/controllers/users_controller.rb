class UsersController < ApplicationController
  def initialize
    @title = 'ユーザ登録'
  end
  
  # render new.rhtml
  def new
    unless params[:tenji_user].blank?
      @tenji_user = TenjiUser.new(params[:tenji_user])
    end
  end
  
  #
  def confirm
    @tenji_user = TenjiUser.new(params[:tenji_user])
    unless @tenji_user.valid?
      respond_to do |format|
        format.html{
          render :action => 'new'
        }
      end
    end
  end

  def create
    @tenji_user = TenjiUser.new(params[:tenji_user])
    current_user.tenji_user = @tenji_user

    if current_user.save
      
    end
  end

end
