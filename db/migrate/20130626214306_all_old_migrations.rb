class AllOldMigrations < ActiveRecord::Migration
  def change

  	## Schools
  	create_table :schools do |t|
      t.string :name

      t.timestamps
    end

  	## Classrooms
    create_table :classrooms do |t|
      t.string :name
      t.integer :school_id
      t.integer :classroom_type_id

      t.timestamps
    end
    add_index :classrooms, :school_id

    ## Children
    create_table :children do |t|
      t.string :name
      t.integer :school_id
      t.integer :parent_id
      t.integer :classroom_id

      t.timestamps
    end
    add_index :children, :school_id
    add_index :children, :parent_id
    add_index :children, :classroom_id

    ## Materials
    create_table :materials do |t|
      t.string :title
      t.datetime :date
      t.integer :classroom_id      

      t.timestamps
    end
    add_index :materials, :classroom_id

    ## ChildrenMaterials
    create_table :children_materials, :id => false do |t|
      t.integer :child_id
      t.integer :material_id
    end

    ## Communications
    create_table :communications do |t|
      t.string :title
      t.text :body
      t.datetime :date
      t.integer :classroom_id
      t.integer :subject_id

      t.timestamps
    end
    add_index :communications, :classroom_id

    ## ChildrenCommunications
    create_table :children_communications, :id => false do |t|
      t.integer :child_id
      t.integer :communication_id
    end

    ## Subjects
    create_table :subjects do |t|
      t.string :name
      t.integer :classroom_id
      t.integer :teacher_id

      t.timestamps
    end
    add_index :subjects, :classroom_id
    add_index :subjects, :teacher_id

    ## ClassroomsTeachers
    create_table :classrooms_teachers, :id => false do |t|
      t.integer :classroom_id
      t.integer :teacher_id
    end

    ## ClassroomTypes
    create_table :classroom_types do |t|
      t.integer :school_id
      t.string :name
      t.boolean :materials, :default => false
      t.boolean :communications, :default => false
      t.boolean :lunch_reports, :default => false
      t.boolean :daily_activities, :default => false
    end
    add_index :classroom_types, :school_id

    ## LunchReports
    create_table :lunch_reports do |t|
      t.integer :status
      t.datetime :date
      t.integer :child_id
      t.integer :classroom_id

      t.timestamps
    end
    add_index :lunch_reports, :classroom_id
    add_index :lunch_reports, :child_id

    ## DailyActivities
    create_table :daily_activities do |t|
      t.string :title
      t.text :body
      t.datetime :date
      t.integer :classroom_id

      t.timestamps
    end
    add_index :daily_activities, :classroom_id

    ## ChildrenDailyActivities
    create_table :children_daily_activities, :id => false do |t|
      t.integer :child_id
      t.integer :daily_activity_id
    end

  end
end
