class SetupPostgis < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          CREATE EXTENSION cube;
          CREATE EXTENSION earthdistance;
        SQL
      end

      direction.down do
        execute <<-SQL
          DROP EXTENSION cube;
          DROP EXTENSION earthdistance;
        SQL
      end
    end
  end
end
