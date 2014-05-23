class PatternsController < ApplicationController

before_filter :require_signed_in!

CATEGORIES = %w( Clothing Accessories Home Toys Pet Components )

  def new
    @pattern = Pattern.new
    @category = CATEGORIES
    render :new
  end

  def create
    @pattern = Pattern.new(pattern_params)
    @pattern.designer_id = current_user.id
    make_tags(tag_names)
    add_photos(params[:picture][:images]) if params[:picture]
    if @pattern.save
      redirect_to pattern_url(@pattern)
    else
      flash.now[:errors] = @patterns.errors.full_messages
      # flash.now[:errors] << @tags.errors.full_messages
      render :new
    end
  end

  def index
    @patterns ||= Pattern.includes(:tags).page(params[:page]).per(10)
    render :index
  end

  def edit
    @pattern = Pattern.find(params[:id])
    @tags = @pattern.tags
    @category = CATEGORIES
    render :edit
  end

  def update
    @pattern = Pattern.find(params[:id])
    @pattern.update(pattern_params)
    make_tags(tag_names)
    add_photos(params[:picture][:images]) if params[:picture]
    render :show
  end

  def destroy
    @pattern = Pattern.find(params[:id])
    @pattern.destroy
    redirect_to patterns_url
  end

  def show
    @pattern = Pattern.includes(:tags, :pictures).find(params[:id])
    @designer = @pattern.designer
    render :show
  end

  def pdf
    @pattern = Pattern.find(params[:id])
    render :pdf
  end

  def search
    results = PgSearch.multisearch(params[:query])
    @patterns = []
    @display_users = []
    if results
      results.each do |result|
        if result.searchable_type == "Tag"
          @patterns += result.searchable.patterns
        elsif result.searchable_type == "User"
          @display_users << result.searchable
        elsif result.searchable_type == "Pattern"
          @patterns << result.searchable
        end
      end
    end
    @patterns = Kaminari.paginate_array(@patterns).page(params[:page]).per(10)
    @display_users = Kaminari.paginate_array(@display_users).page(params[:page]).per(10)
    render :index
  end


  private

  def pattern_params
    params.require(:pattern).permit(:name, :category, :yarn_name,
      :yarn_weight, :stitch_col, :stitch_row, :swatch,
      :swatch_stitch, :needles, :amount_yarn, :sizes,
      :price, :notes, :instruction, :url, tags_attributes: [:id, :name])
  end

  def tag_names
    params.require(:tag).permit(:name)[:name].split(",").map(&:strip)
  end

  def make_tags(array)
    @pattern.tags = array.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end

  def add_photos(array)
    @pattern.pictures << array.map { |image| Picture.create(image: image) }
  end

end