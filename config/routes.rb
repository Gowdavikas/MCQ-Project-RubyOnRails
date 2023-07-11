Rails.application.routes.draw do
  devise_for :users, controllers: {	
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  post "otpverify", to: "accounts#otp_verify"

  
  get "getquestion", to: "questions#level_question"

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


  get "users", to: "users#index"
  get "user/:id", to: "users#show"
  put "user/:id", to: "users#update"
  post "user", to: "users#create"
  delete "user/:id", to: "users#destroy"

  get "interests", to: "interests#index"
  get "interest/:id", to: "interests#show"
  post "interest", to: "interests#create"
  put "interest/:id", to: "interests#update"
  delete "interest/:id", to: "interests#destroy"

  get "qualifications", to: "qualifications#index"
  get "qualification/:id", to: "qualifications#show"
  post "qualification", to: "qualifications#create"
  put "qualification/:id", to: "qualifications#update"
  delete "qualification/:id", to: "qualifications#destroy"

  get "academics", to: "academics#index"
  get "academic/:id", to: "academics#show"
  post "academic", to: "academics#create"
  put "academic/:id", to: "academics#update"
  delete "academic/:id", to: "academics#destroy"
  
  
end