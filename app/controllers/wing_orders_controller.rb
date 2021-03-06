class WingOrdersController < ApplicationController
  def index
    @wing_orders = WingOrder.all
  end

  def show
    @wing_order = WingOrder.find(params[:id])
  end

  def new
    @wing_order = WingOrder.new
    @state_collection = WingOrder::STATES
    @quantity_collection = WingOrder::QUANTITIES
    @flavor_collection = Flavor.all
  end

  def edit
    @wing_order = WingOrder.find(params[:id])
    @state_collection = WingOrder::STATES
    @quantity_collection = WingOrder::QUANTITIES
    @flavor_collection = Flavor.all
  end

  def create
    @wing_order = WingOrder.new(wing_order_params)
    @wing_order.flavors = Flavor.where(id: params[:wing_order][:flavor_ids])
    if @wing_order.save
      flash[:notice] = "Wing order created!"
      redirect_to wing_orders_path
    else
      flash[:alert] = "Wing order not created"
      @state_collection = WingOrder::STATES
      @quantity_collection = WingOrder::QUANTITIES
      @flavor_collection = Flavor.all
      render :new
    end
  end

  def update
    @wing_order = WingOrder.find(params[:id])
    @wing_order.flavors = Flavor.where(id: params[:wing_order][:flavor_ids])
    if @wing_order.update(wing_order_params)
      redirect_to wing_order_path(@wing_order)
    else
      render :edit
    end
  end

  private

  def wing_order_params
    params.require(:wing_order).permit(
      :customer_name,
      :city,
      :state,
      :quantity,
      :ranch_dressing,
      :bleu_cheese
    )
  end
end
