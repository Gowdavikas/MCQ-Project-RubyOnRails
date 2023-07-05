Rails.application.routes.draw do
  devise_for :users, controllers: {	
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  post "otpverify", to: "accounts#otp_verify"

  get "questions", to: "questions#index"
  get "question/:id", to: "questions#show"
  put "question/:id", to: "questions#update"
  post "question", to: "questions#create"
  delete "question/:id", to: "questions#destroy"


  get "options", to: "options#index"
  get "option/:id", to: "options#show"
  put "option/:id", to: "options#update"
  post "option", to: "options#create"
  delete "option/:id", to: "options#destroy"


  post "submitanswer", to: "answers#submit_answer"
  get "answers", to: "answers#index"
  get "answer/:id", to: "answers#show"
  patch "answer/:id", to: "answers#update"
  post "answer", to: "answers#create"
  delete "answer/:id", to: "answers#destroy"


  get "users", to: "users#index"
  get "user/:id", to: "users#show"
  put "user/:id", to: "users#update"
  post "user", to: "users#create"
  delete "user/:id", to: "users#destroy"

  get "getquestion", to: "questions#level_question"
  
end
