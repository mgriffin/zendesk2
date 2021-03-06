# frozen_string_literal: true
class Zendesk2::HelpCenter::Sections
  include Zendesk2::Collection

  include Zendesk2::PagedCollection
  include Zendesk2::Searchable

  model Zendesk2::HelpCenter::Section

  self.collection_method = :get_help_center_sections
  self.collection_root   = 'sections'
  self.model_method      = :get_help_center_section
  self.model_root        = 'section'

  attribute :category_id, type: :integer

  scopes << :category_id

  def collection_page(params = {})
    collection_method = if category_id
                          :get_help_center_categories_sections
                        else
                          :get_help_center_sections
                        end

    body = cistern.send(collection_method, Cistern::Hash.stringify_keys(attributes.merge(params))).body

    load(body[collection_root]) # 'results' is the key for paged searches
    merge_attributes(Cistern::Hash.slice(body, 'count', 'next_page', 'previous_page'))
    self
  end
end
