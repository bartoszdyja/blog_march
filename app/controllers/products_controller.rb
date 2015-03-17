class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  expose(:category)
  expose(:products) {Product.where(category_id: params[:category_id])}
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
    
  end

  def show
  end

  def new
  end

  def edit
    if !owner(self.product)
      redirect_to root_path, error: 'You are not allowed to edit this product.'
    end
  end

  def create
    self.product = Product.new(product_params)

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if !owner(self.product)
      redirect_to root_path, error: 'You are not allowed to edit this product.'
    else
      if self.product.update(product_params)
        redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
      else
        render action: 'edit'
      end
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end



  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end

  def owner(procuct)
    current_user == product.user
  end


end
