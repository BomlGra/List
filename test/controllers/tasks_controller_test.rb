require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  test "should not get index" do
    get root_path
    assert_response :redirect
  end

  test "should get index with authentication" do
    @new_user = User.create(email: 'test@mail.ru', password: '123456',
                            password_confirmation: '123456')
    sign_in @new_user
    get root_path
    assert_response :success
  end

  test "add and remove task" do
    @new_user = User.create(email: 'test@mail.ru', password: '123456',
                            password_confirmation: '123456')
    sign_in @new_user
    task = @new_user.tasks.new(title: 'Title', text: 'Text for testing')
    assert task.save
    # Изначально в базе нет ни одной задачи
    # Поэтому после добавления их должно стать 1
    assert_equal 1, Task.count
    # И у текущего пользователя тоже 1
    assert_equal 1, @new_user.tasks.count

    # Теперь удаляем задачу
    @new_user.tasks.find_by_title('Title').delete
    assert_equal 0, Task.count
    assert_equal 0, @new_user.tasks.count
  end

  test "Tasks title validate" do
    @new_user = User.create(email: 'test@mail.ru', password: '123456',
                            password_confirmation: '123456')
    sign_in @new_user

    task1 = @new_user.tasks.new(title: nil, text: '!Correct text!123')
    assert_not task1.save

    task2 = @new_user.tasks.new(title: 'Correct title!13579', text: nil)
    assert_not task2.save

    task3 = @new_user.tasks.new(title: nil, text: nil)
    assert_not task3.save

    task_correct = @new_user.tasks.new(title: 'Correct title! and',
                                       text: 'Correct text! ???')
    assert task_correct.save
  end
end
