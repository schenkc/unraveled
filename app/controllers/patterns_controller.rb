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
    @patterns = Pattern.all
    render :index
  end

  def edit
    @pattern = Pattern.find(params[:id])
    render :edit
  end

  def update
    @pattern = Pattern.find(params[:id])
    @pattern.update(pattern_params)
    render :show
  end

  def destroy
    @pattern = Pattern.find(params[:id])
    @pattern.destroy
    redirect_to patterns_url
  end

  def show
    @pattern = Pattern.find(params[:id])
    @current_user = current_user
    render :show
  end

  private

  def pattern_params
    params.require(:pattern).permit(:name, :category, :yarn_name, :yarn_weight, :stitch_col,
      :stitch_row, :swatch, :swatch_stitch, :needles, :amount_yarn, :sizes, :price, :notes)
  end

end