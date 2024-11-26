# Pin npm packages by running ./bin/importmap

pin "application"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.8/dist/esm/index.js"
pin "@rails/ujs", to: "rails-ujs.js", preload: true
# config/importmap.rb
# pin "mrujs", to: "https://ga.jspm.io/npm/mrujs@1.0.2/dist/index.module.js", preload: true

pin "@hotwired/turbo-rails", to: "turbo.es2017-esm.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
