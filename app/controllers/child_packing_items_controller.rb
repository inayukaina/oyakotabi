class ChildPackingItemsController < ApplicationController
  before_action :set_trip, only: [:index, :create, :edit, :update, :destroy]
  def index
    @child_packing_items = @trip.child_packing_items
    @child_packing_item = @trip.child_packing_items.new # 新規追加用
    @edit_item = @trip.child_packing_items.find(params[:id]) if params[:id] # 編集用
  end

  def create
    @child_packing_item = @trip.child_packing_items.new(child_packing_item_params)
    if @child_packing_item.save
      redirect_to trip_child_packing_items_path(@trip), notice: '荷物が追加されました！'
    else
      @child_packing_items = @trip.child_packing_items
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to trip_child_packing_items_path(@trip)
    @child_packing_items = @trip.child_packing_items
    @child_packing_item = @trip.child_packing_items.find(params[:id])
  end

  def update
    @child_packing_items = @trip.child_packing_items
    @child_packing_item = @trip.child_packing_items.find(params[:id])
    if @child_packing_item.update(child_packing_item_params)
      redirect_to trip_child_packing_items_path(@trip), notice: '荷物が更新されました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @child_packing_item = @trip.child_packing_items.find(params[:id])
    @child_packing_item.destroy
    redirect_to trip_child_packing_items_path(@trip), notice: '荷物が削除されました！'
  end

  def complete
    @trip.child_packing_items.update_all(is_event_completed: true)
    redirect_to trip_child_packing_items_path(@trip), notice: '準備がすべて完了しました！'
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def child_packing_item_params
    params.require(:child_packing_item).permit(:name, :quantity, :is_event_completed)
  end
end
