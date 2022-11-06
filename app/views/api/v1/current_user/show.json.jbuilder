[
  :id,
  :email,
  :firstname,
  :lastname
].each do |key|
  json.set! key, @user.public_send(key)
end
