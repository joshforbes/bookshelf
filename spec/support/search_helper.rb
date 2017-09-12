module SearchHelpers
  def reindex_search(resource)
    resource.reindex
    resource.searchkick_index.refresh
  end
end

# RSpec.configure do |config|
#   config.before(:suite) do
#     Searchkick.disable_callbacks
#   end
#
#   config.around(:each, search: true) do |example|
#     Searchkick.enable_callbacks
#     example.run
#     Searchkick.disable_callbacks
#   end
# end
