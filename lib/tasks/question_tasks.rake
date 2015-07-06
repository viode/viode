desc 'close old questions'
task close_old_questions: :environment do
  questions = Question.to_be_closed
  questions.each do |question|
    question.update_attributes(closed: true)
  end
end