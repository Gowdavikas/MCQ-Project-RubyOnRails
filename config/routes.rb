Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {	
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  post "otpverify", to: "accounts#otp_verify"

  
  get "getquestion", to: "questions#level_question"

  QUESTION_ROUTE = "question/:id"
  get "questions", to: "questions#index"
  get QUESTION_ROUTE, to: "questions#show"
  put QUESTION_ROUTE, to: "questions#update"
  post "question", to: "questions#create"
  delete QUESTION_ROUTE, to: "questions#destroy"

  OPTION_ROUTE = "option/:id"
  get "options", to: "options#index"
  get OPTION_ROUTE, to: "options#show"
  put OPTION_ROUTE, to: "options#update"
  post "option", to: "options#create"
  delete OPTION_ROUTE, to: "options#destroy"
 
  ANSWER_ROUTE = "answer/:id"
  post "submitanswer", to: "answers#submit_answer"
  get "answers", to: "answers#index"
  get ANSWER_ROUTE, to: "answers#show"
  patch ANSWER_ROUTE, to: "answers#update"
  post "answer", to: "answers#create"


  USER_ROUTE = "user/:id"
  get "users", to: "users#index"
  get USER_ROUTE, to: "users#show"
  put USER_ROUTE, to: "users#update"
  post "user", to: "users#create"
  delete USER_ROUTE, to: "users#destroy"

  INTEREST_ROUTE = "interest/:id"
  get "interests", to: "interests#index"
  get INTEREST_ROUTE, to: "interests#show"
  post "interest", to: "interests#create"
  put INTEREST_ROUTE, to: "interests#update"
  delete INTEREST_ROUTE, to: "interests#destroy"

  QUALIFICATION_ROUTE = "qualification/:id"
  get "qualifications", to: "qualifications#index"
  get QUALIFICATION_ROUTE, to: "qualifications#show"
  post "qualification", to: "qualifications#create"
  put QUALIFICATION_ROUTE, to: "qualifications#update"
  delete QUALIFICATION_ROUTE, to: "qualifications#destroy"

  ACADEMIC_ROUTE = "academic/:id"
  get "academics", to: "academics#index"
  get ACADEMIC_ROUTE, to: "academics#show"
  post "academic", to: "academics#create"
  put ACADEMIC_ROUTE, to: "academics#update"
  delete ACADEMIC_ROUTE, to: "academics#destroy"
  
end