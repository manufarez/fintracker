class ProfilesController < ApplicationController
  def show
    render inertia: "Profile/Show", props: {
      user: Current.user
    }
  end
end
