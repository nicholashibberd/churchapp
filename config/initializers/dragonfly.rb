require 'dragonfly/rails/images'
app = Dragonfly[:images]
app.define_macro_on_include(Mongoid::Document, :image_accessor)