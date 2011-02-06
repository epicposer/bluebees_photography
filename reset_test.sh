while true; do
    read -p "Wipe everything in the database and reseed? (y/n): " yn
    case $yn in
        [Yy]* )
          echo "Recreate the database...";
          rake RAILS_ENV=test db:drop;
          echo "Seed the database...";
          rake RAILS_ENV=test db:seed;
          break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

