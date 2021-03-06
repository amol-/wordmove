require 'wordmove/wordpress_directory/path'

class WordpressDirectory
  attr_accessor :type, :options

  def initialize(type, options)
    @type = type
    @options = options
  end

  DEFAULT_PATHS = {
    Path::WP_CONTENT => 'wp-content',
    Path::WP_CONFIG  => 'wp-config.php',
    Path::PLUGINS    => 'wp-content/plugins',
    Path::THEMES     => 'wp-content/themes',
    Path::UPLOADS    => 'wp-content/uploads',
    Path::LANGUAGES  => 'wp-content/languages'
  }.freeze

  def self.default_path_for(sym)
    DEFAULT_PATHS[sym]
  end

  def path(*args)
    File.join(options[:wordpress_path], relative_path(*args))
  end

  def url(*args)
    File.join(options[:vhost], relative_path(*args))
  end

  def relative_path(*args)
    path = if options[:paths] && options[:paths][type]
             options[:paths][type]
           else
             DEFAULT_PATHS[type]
           end
    File.join(path, *args)
  end
end
