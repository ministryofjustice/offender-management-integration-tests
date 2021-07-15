RSpec::Matchers.define :have_heading do |heading_text|
  match do |actual|
    actual.has_css?('h1', text: heading_text)
  end
end
