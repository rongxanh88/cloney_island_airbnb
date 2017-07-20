class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:edit, :update, :show, :destroy]

  def index
    @experiences = Experience.all
  end

  def show
    @experience
  end

  def new
    if current_user
      @experience = Experience.new
      @categories = ExperienceCategory.all
    else
      flash[:notice] = "You must have an account to Host an Experience."
      redirect_to login_path
    end
  end

  def create
    @experience = Experience.new(experience_params)
    current_user.roles << Role.find_by(name: "host") if current_user.host? == false
    if @experience.save
      flash[:success] = "Experience created successfully!"
      redirect_to experience_path(@experience)
    else
      flash[:validation] = "Experience didn't validate. Try again."
      redirect_to new_experience_path
    end

  end

  # def edit
  #   @experience
  # end

  def update
    @experience.update(experience_params)
    if @experience.save
      flash[:success] = 'Experience updated!'
      redirect_to experiences_path
    else
      flash[:failure] = "Failed. Try, try again."
      render :edit
    end
  end

  def destroy
    @experience.destroy
    flash[:success] = 'Experience Erased!'
    redirect_to experiences_path
  end

  private

    def experience_params
      params.require(:experience)
            .permit(
              :title, :duration, :tagline, :what, :where,
              :provisions, :notes, :group_size, :guest_requirements, :cancellation_policy_type, :user_id, :price, :host_description, :street_address, :city, :state, :zipcode
              )
    end

    def set_experience
      @experience = Experience.find(params[:id])
    end

end
