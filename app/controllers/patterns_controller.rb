class PatternsController < ApplicationController

  def new
    @pattern = Pattern.new
    render :new
  end

  def create
    @pattern = Pattern.new(pattern_params)
    @pattern.designer_id = current_user.id

    if @pattern.save
      redirect_to pattern_url(@pattern)
    else
      flash.now[:errors] = @patterns.errors.full_messages
      render :new
    end
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def pattern_params

  end

end