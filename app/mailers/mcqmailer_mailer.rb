class McqmailerMailer < ApplicationMailer
    default from: 'mcq@test.com'

    def email(user, score)
        @user = user
        @score = score
        mail(to: @user.email, subject: 'Regarding your MCQ-Test result') do |format|
          format.text { render plain: "Hello, #{user.name}!\nYour MCQ test score: #{score}"}
        end
    end
end