require 'capybara/poltergeist'

# This is the number of seconds, that Capybara waits for AJAX requests to finish.
# Default is 2.
Capybara.default_max_wait_time = 15

# One can use this line, to switch between drivers for JavaScript specs.
# Both configuration should be kept, so we can flip quickly in the future.
#
# Previously we used poltergeist driver and it made our test suite
# unreliable on CI. We were affected by the following issues:
#  - https://github.com/teampoltergeist/poltergeist/issues/375
#  - https://github.com/ariya/phantomjs/issues/12234
#
# We have tried several strategies described to mitigate those (but none helped)
#  - PhantomJS restart after timeout
#  - upgrade to PhantomJS 2.0
#	 - resetting Capyabara driver after each test
#  - precompiling our assets before running CI
#
# Changing driver to capybara-webkit did help. The main downside is that
#	capybara-webkit is unable to raise JavaScript errors.
Capybara.javascript_driver = :poltergeist

CAPYBARA_POLTERGEIST_OPTIONS = {
    debug: false, # change this to true to troubleshoot
    timeout: 30,
    # Do raise JavaScript errors as exceptions as we want to know about them.
    js_errors: false,
    # XXX: Not loading images seems to improve reliability and performance of specs.
    phantomjs_options: [
        '--load-images=no',
        '--ignore-ssl-errors=yes'
    ]
}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, CAPYBARA_POLTERGEIST_OPTIONS)
end
