class OptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :option, :question_id
end
