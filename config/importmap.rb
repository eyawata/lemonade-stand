# Pin npm packages by running ./bin/importmap

pin "application"
pin "bootstrap", to: "bootstrap.min.js", preload: true # @5.3.3
pin "@popperjs/core", to: "popper.js", preload: true # @2.11.8
