namespace :setup do
  desc "Запуск міграцій у заданому порядку + seed"
  task custom: :environment do
    migrations_path = Rails.root.join("db/migrate")

    ordered_migrations = [
      "20251212231018_create_active_storage_tables.active_storage.rb",
      "20251212231156_devise_create_users.rb",
      "20251213005306_create_addresses.rb",
      "20251213005322_create_categories.rb",
      "20251213005408_create_collections.rb",
      "20251213005706_create_products.rb",
      "20251213005425_create_product_collections.rb",
      "20251213005926_create_carts.rb",
      "20251213010225_create_cart_items.rb",
      "20251213010249_create_orders.rb",
      "20251213010310_create_order_items.rb",
      "20251213010418_create_reviews.rb",
      "db/migrate/20251213234752_add_default_to_users_role.rb"
    ]

    puts "➡️ Запуск міграцій у заданому порядку..."

    ordered_migrations.each do |file|
      full_path = migrations_path.join(file)

      unless File.exist?(full_path)
        puts "⚠️ Міграція не знайдена: #{file}"
        next
      end

      version = file.split("_").first

      if ActiveRecord::SchemaMigration.where(version: version).exists?
        puts "⏭ Пропущено (вже виконана): #{file}"
        next
      end

      puts "🚀 Виконую: #{file}"
      ActiveRecord::Migrator.run(:up, migrations_path, version)
    end

    puts "✅ Міграції завершено"
    puts "🌱 Запуск seed..."

    Rake::Task["db:seed"].invoke

    puts "🎉 Проєкт готовий"
  end
end
