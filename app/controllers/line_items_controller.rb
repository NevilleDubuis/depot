class LineItemsController < ApplicationController
  skip_before_filter :authorize, :only => [:create, :increment, :decrement, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
    @cart = current_cart

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])
    @cart = current_cart
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new
    @cart = current_cart

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url}
        format.js   { @current_item = @line_item}
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.js
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])
    @cart = current_cart

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to store_url, notice: 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @cart = @line_item.cart
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js
      format.json { head :ok }
    end
  end

  def decrement
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    else
      @line_item.destroy
    end
    @line_item.save

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js { @cart = current_cart }
    end
  end

  def increment
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js { @cart = current_cart }
    end
  end

end