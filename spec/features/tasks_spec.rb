require 'spec_helper'

describe "Tasks" do

	subject { page }
  
	describe "Adding a Task", :js => true do

		let(:task) { FactoryGirl.create(:task) }
		#let(:task) { Task.find(1) } 

		before do
			task.save  
			visit root_path
			fill_in "task_content", with: "this task"
			#click_button "Add Task"
		end

		after do
			#click_link("remove", match: :first)
		end

		it "should be able to add a task" do
			should have_content(task.content)
			should have_selector("form#edit_task_#{task.id}", text: task.content)
		end

		it "should have the correct headline" do
			should have_content("Tasks App")
		end

		it "should have complete/incomplete tasks headlines" do
			should have_content("Complete Tasks")
			should have_content("Incomplete Tasks")
		end

		describe "removing a task" do
		  
			before do 
			    #visit tasks_path
			    click_link("remove", href: task_path(task.id))
			    #click_link("remove")
			end

			it "removes the task" do
			    #visit tasks_path
			    should_not have_content(task.content)
			    should_not have_selector("form#edit_task_#{task.id}", text: task.content)
			end
		end
  
		context "using javascript" do

			describe "completing an incomplete task" do

				before do
					#click_link("")
					check(task.content, match: :first)
					#click_link("form#edit_task_#{task.id} input")
				end

				it { should_not have_selector("div#incomplete_tasks form#edit_task_#{task.id}", 
					          												          text: task.content) }
				it { should have_selector("div#complete_tasks form#edit_task_#{task.id}", text: task.content) }
			end 
		end
	end
end
     