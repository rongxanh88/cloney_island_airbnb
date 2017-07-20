module ExperienceHelper

  def create_experience
    exp = create(:experience)
    @role_host = host_role
    @role_traveler = traveler_role
    exp.user.roles << @role_host
    exp.user.roles << @role_traveler
    images = create_images
    exp.experience_images << images
    cats = create_categories
    exp.experience_categories << cats.sample(2)
    exp
  end

  def create_many_experiences
    exps = create_list(:experience, 4)
    role = host_role
    images = create_images
    exps.each do |e|
      e.user.roles << role
      e.experience_images << images
    end
  end

  def host_role
    create(:role, name: "host")
  end

  def traveler_role
    create(:role, name: "traveler")
  end

  def create_images
    create_list(:experience_image, 4)
  end

  def create_categories
    create_list(:experience_category, 10)
  end

end
