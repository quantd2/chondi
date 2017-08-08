class AdminConstraint
  def matches?(request)
    return false unless request.session["warden.user.user.key"][0]
    user = User.find(request.session["warden.user.user.key"][0].first)
    user && user.admin?
  end
end
