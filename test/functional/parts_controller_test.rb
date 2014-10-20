require 'test_helper'

class PartsControllerTest < ActionController::TestCase
  setup do
    @part = parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part" do
    assert_difference('Part.count') do
      post :create, part: { cut_length: @part.cut_length, drawing_created: @part.drawing_created, have_material: @part.have_material, name: @part.name, notes: @part.notes, part_number: @part.part_number, part_type: @part.part_type, priority: @part.priority, quantity: @part.quantity, source_material: @part.source_material, status: @part.status }
    end

    assert_redirected_to part_path(assigns(:part))
  end

  test "should show part" do
    get :show, id: @part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part
    assert_response :success
  end

  test "should update part" do
    put :update, id: @part, part: { cut_length: @part.cut_length, drawing_created: @part.drawing_created, have_material: @part.have_material, name: @part.name, notes: @part.notes, part_number: @part.part_number, part_type: @part.part_type, priority: @part.priority, quantity: @part.quantity, source_material: @part.source_material, status: @part.status }
    assert_redirected_to part_path(assigns(:part))
  end

  test "should destroy part" do
    assert_difference('Part.count', -1) do
      delete :destroy, id: @part
    end

    assert_redirected_to parts_path
  end
end
