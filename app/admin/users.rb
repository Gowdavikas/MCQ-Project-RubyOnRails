ActiveAdmin.register User do

  permit_params :name, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :jti, :role, :phonenumber, :otp_verified, :authentication_token
  
end
