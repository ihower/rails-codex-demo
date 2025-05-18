require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let!(:todo) { Todo.create!(title: 'Test Todo', completed: false) }

  describe "GET /todos" do
    it "returns success" do
      get todos_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /todos" do
    it "creates a todo" do
      expect {
        post todos_path, params: { todo: { title: 'New Todo', completed: true } }
      }.to change(Todo, :count).by(1)
      expect(response).to redirect_to(todo_path(Todo.last))
    end
  end

  describe "PATCH /todos/:id" do
    it "updates the todo" do
      patch todo_path(todo), params: { todo: { title: 'Updated' } }
      expect(response).to redirect_to(todo_path(todo))
      todo.reload
      expect(todo.title).to eq('Updated')
    end
  end

  describe "DELETE /todos/:id" do
    it "deletes the todo" do
      expect {
        delete todo_path(todo)
      }.to change(Todo, :count).by(-1)
      expect(response).to redirect_to(todos_path)
    end
  end
end
