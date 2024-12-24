class ChildPackingItemsController < ApplicationController
  before_action :set_trip, only: [:index, :create, :update, :destroy, :complete]
  before_action :set_child_packing_item, only: [:update, :destroy]
  def index
    @child_packing_items = @trip.child_packing_items.where.not(id: nil) # 保存済みアイテムのみ取得
    @child_packing_item = @trip.child_packing_items.new # 新規追加用
    @edit_item = @trip.child_packing_items.find(params[:id]) if params[:id] # 編集用
  end

  def create
    @child_packing_item = @trip.child_packing_items.new(child_packing_item_params)
    if @child_packing_item.save
      redirect_to trip_child_packing_items_path(@trip)
    else
      @child_packing_items = @trip.child_packing_items
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @child_packing_items = @trip.child_packing_items
    if @child_packing_item.update(child_packing_item_params)
      redirect_to trip_child_packing_items_path(@trip)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @child_packing_item.destroy
    redirect_to trip_child_packing_items_path(@trip)
  end

  def complete
    if @trip.child_packing_items.update_all(is_event_completed: true)
      redirect_to trip_child_packing_items_path(@trip), notice: '荷物準備イベントが完了しました！'
    else
      redirect_to trip_child_packing_items_path(@trip), alert: '完了処理に失敗しました。'
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_child_packing_item
    @child_packing_item = @trip.child_packing_items.find(params[:id])
  end

  def child_packing_item_params
    params.require(:child_packing_item).permit(:name, :quantity, :is_event_completed)
  end
end
