require 'test_helper'

class MealIngredientsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get meal_ingredients_show_url
    assert_response :success
  end

  test 'should get new' do
    get meal_ingredients_new_url
    assert_response :success
  end

  test 'should get create' do
    get meal_ingredients_create_url
    assert_response :success
  end

  test 'should get modify' do
    get meal_ingredients_modify_url
    assert_response :success
  end

  test 'should get destroy' do
    get meal_ingredients_destroy_url
    assert_response :success
  end
end
