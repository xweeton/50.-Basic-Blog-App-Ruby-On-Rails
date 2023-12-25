# Pin npm packages by running ./bin/importmap
pin "application", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap/dist/js/bootstrap.bundle.min.js"
pin "trix", to: "trix/dist/trix.js"
pin "@rails/actiontext", to: "actiontext.esm.js"
