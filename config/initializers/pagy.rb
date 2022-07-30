# Set number of items per page
Pagy::DEFAULT[:items] = 15

# Set number of items to display before and after current page
Pagy::DEFAULT[:size] = [1,2,2,1]

# Behavior when selected page does not exist :empty_page (other options :empty_page and :exception )
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page

# Remove the page=1 parameter from the link on first page
require 'pagy/extras/trim'

# Add Bootstrap support to pagination
require 'pagy/extras/bootstrap'
