require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end
  describe "タスク作成" do
    context "フォームが入力済の場合" do
      context "期限に昨日の日付を設定した場合" do
        it "タスクの作成に失敗する" do
          visit new_task_path
          fill_in "Title", with: "hoge"
          fill_in  "Deadline", with: Date.yesterday
          click_on "Create Task"
          expect(page).not_to have_text("Task was successfully created.")
        end
      end

      context "期限に今日の日付を設定した場合" do
        it "タスクの作成に成功する" do
          visit new_task_path
          fill_in "Title", with: nil
          fill_in  "Deadline", with: Date.today
          click_on "Create Task"
          expect(page).to have_text("Task was successfully created.")
        end
      end
    end

    context "フォームが未入力の場合" do
      it "タスクの作成に失敗する" do
        visit new_task_path
        click_on "Create Task"
        expect(page).not_to have_text("Task was successfully created.")
        expect(page).to have_text("Title can't be blank")
        expect(page).to have_text("Deadline can't be blank")
      end
    end
  end
end
