class AcademicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :college_name,:language,:other_language,:cv,:govt_id,:specialization,:career_goals,:currently_working,:experience,:availability


  attributes :cv do |resume|
    if resume.cv.present?
      host = Rails.env.development? ? "http://localhost:3000" : ENV["BASE_URL"]
      host + Rails.application.routes.url_helpers.rails_blob_url(resume.cv, only_path: true)
    end
  end

  attributes :govt_id do |goverment_id|
    if goverment_id.govt_id.present?
      host = Rails.env.development? ? "http://localhost:3000" : ENV["BASE_URL"]
      host + Rails.application.routes.url_helpers.rails_blob_url(goverment_id.govt_id, only_path: true)
    end
  end
end
