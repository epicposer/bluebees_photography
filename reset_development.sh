while true; do
    read -p "Wipe everything in the database and reseed? (y/n): " yn
    case $yn in
        [Yy]* )
          echo "Recreate the database...";
          rake db:drop --trace;
          echo "Seed the database...";
          rake db:seed --trace;
          break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
