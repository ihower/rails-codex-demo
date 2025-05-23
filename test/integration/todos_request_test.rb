require "test_helper"

class TodosRequestTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get todos_url
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post todos_url, params: { todo: { title: 'New Todo', completed: false } }
    end
    assert_redirected_to todo_url(Todo.last)
  end

  test "should show todo" do
    get todo_url(@todo)
    assert_response :success
  end

  test "should update todo" do
    patch todo_url(@todo), params: { todo: { title: 'Updated', completed: true } }
    assert_redirected_to todo_url(@todo)
    @todo.reload
    assert_equal 'Updated', @todo.title
    assert @todo.completed
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete todo_url(@todo)
    end
    assert_redirected_to todos_url
  end
end
