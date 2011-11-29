class PeopleController < ApplicationController
  skip_before_filter :login_required, :only => 'show'
  layout 'admin'

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to(people_path(@institution), :notice => 'Person was successfully created.')
    else
      flash[:error] = "There was an error creating the person"
      render :action => "new"
    end
  end

  def update
    @person = Person.find(params[:id])

    if @person.update_attributes(params[:person])
      redirect_to(people_path(@institution), :notice => 'Person was successfully updated.')
    else
      flash[:error] = "There was an error updating the person"
      render :action => "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    redirect_to(people_path(@institution))
  end
end
