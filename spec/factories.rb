FactoryGirl.define do
  
  factory :hook do
    sequence(:number){|n| (100+n).to_s}
  end

  factory :bike do
    sequence(:number){|n| (10000+n).to_s}
  end

  factory :project_category do
    sequence(:name){|n| "Category#{n}"}
    project_type "Project::Eab"
    max_programs 3
  end

  factory :program, :aliases => [:prog] do
    sequence(:title){|n| "TestProgram#{n}"}
    project_category
  end

  factory :youth_detail, :class => "Project::YouthDetail" do
    association :proj, :factory => :youth_project
  end

  factory :youth_project, :class => "Project::Youth" do
    prog
    bike
    #factory :youth_project_with_detail do
    #  after(:build) do |proj_instance|
    #    detail FactoryGirl.build(:youth_detail)
    #  end
    #end
    #association :detail, :factory => :youth_detail
  end

end
