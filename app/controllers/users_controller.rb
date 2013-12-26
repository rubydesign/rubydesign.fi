# encoding : utf-8
class UsersController < BeautifulController

  before_filter :load_user, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:user] ||= (User.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:user)
    do_sort_and_paginate(:user)
    
    @q = User.search(
      params[:q]
    )

    @user_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @user_scope_for_scope = @user_scope.dup
    
    unless params[:scope].blank?
      @user_scope = @user_scope.send(params[:scope])
    end
    
    @users = @user_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @user_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << User.attribute_names
          @user_scope.to_a.each{ |o|
            csv << User.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @user }
    end
  end

  def edit
    
  end

  def create
    @user = User.create(params_for_model)

    respond_to do |format|
      if @user.save
        format.html {
          redirect_to user_path(@user), :flash => { :notice => t(:create_success, :model => "user") }
        }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @user.update_attributes(params_for_model)
        format.html { redirect_to user_path(@user), :flash => { :notice => t(:update_success, :model => "user") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @users = []    
    
    User.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:user)

        @users = User.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @users = User.find(params[:ids].to_a)
      end

      @users.each{ |user|
        if not User.columns_hash[attr_or_method].nil? and
               User.columns_hash[attr_or_method].type == :boolean then
         user.update_attribute(attr_or_method, boolean(value))
         user.save
        else
          case attr_or_method
          # Set here your own batch processing
          # user.save
          when "destroy" then
            user.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = User
    foreignkey = :user_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_user
    @user = User.find(params[:id])
  end

  def params_for_model
    params.require(:user).permit(User.permitted_attributes)
  end
end

