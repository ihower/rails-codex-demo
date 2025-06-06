require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:valid_attributes) { { title: 'Test Todo', completed: false } }
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET /todos' do
    before { Todo.create!(valid_attributes) }

    it 'returns a successful response' do
      get todos_path, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it 'returns the todo' do
      get todo_path(todo), headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /todos' do
    it 'creates a new Todo' do
      expect {
        post todos_path, params: { todo: valid_attributes }, headers: headers
      }.to change(Todo, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it 'updates the requested todo' do
      patch todo_path(todo), params: { todo: { completed: true } }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(todo.reload.completed).to be true
    end
  end

  describe 'DELETE /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it 'destroys the requested todo' do
      expect {
        delete todo_path(todo), headers: headers
      }.to change(Todo, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
