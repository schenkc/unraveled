class Pattern < ActiveRecord::Base

  belongs_to(
    :designer,
    class_name: "User",
    foreign_key: :designer_id,
    primary_key: :id
  )

end