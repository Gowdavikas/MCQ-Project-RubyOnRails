class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :question
end
