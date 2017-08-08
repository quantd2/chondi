class AdminConstraint
  def matches?(request)
    return false unless request.session["warden.user.user.key"][1][0]
    user = User.find(session["warden.user.user.key"][1][0])
    user && user.admin?
  end
end
