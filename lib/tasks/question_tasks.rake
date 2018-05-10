# frozen_string_literal: true

desc 'close old questions'
task close_old_questions: :environment do
  Question.to_be_closed.update_all(closed: true)
end
